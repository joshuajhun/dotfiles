#!/usr/bin/env bash
# Bootstrap a Mac dev environment from this repo.
# Safe to re-run: every step checks before it installs.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"
INSTALLED=()
SKIPPED=()

# --- helpers -----------------------------------------------------------------
say()     { printf '\033[1;35m==>\033[0m %s\n' "$*"; }
have()    { command -v "$1" >/dev/null 2>&1; }
done_()   { INSTALLED+=("$1"); say "installed: $1"; }
skip()    { SKIPPED+=("$1"); say "already set: $1"; }

# step NAME CHECK_CMD INSTALL_FN — run INSTALL_FN only when CHECK_CMD fails
step() {
  local name="$1" check="$2" install="$3"
  if eval "$check"; then skip "$name"; else "$install" && done_ "$name"; fi
}

# link SRC DEST — symlink, backing up any real file already at DEST
link() {
  local src="$DOTFILES/$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then skip "link $dest"; return; fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then mv "$dest" "$dest.bak-$STAMP"; say "backed up $dest"; fi
  ln -s "$src" "$dest" && done_ "link $dest"
}

# --- installers --------------------------------------------------------------
install_clt() {
  xcode-select --install || true
  say "Finish the Xcode Command Line Tools dialog, then re-run ./install.sh"
  exit 0
}

install_brew() {
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

load_brew() { eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"; }

install_bundle() { brew bundle --no-upgrade --file="$DOTFILES/Brewfile"; }

install_omz() {
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}

install_asdf_node() { asdf plugin add nodejs; }
install_tool_versions() { (cd "$HOME" && asdf install) && asdf reshim nodejs; }

install_npm_globals() {
  local missing=()
  local pkgs=(yarn neovim)
  local p
  for p in "${pkgs[@]}"; do npm ls -g --depth=0 "$p" >/dev/null 2>&1 || missing+=("$p"); done
  npm install -g "${missing[@]}" && asdf reshim nodejs
}
npm_globals_present() { npm ls -g --depth=0 yarn neovim >/dev/null 2>&1; }

PLUG_VIM="$HOME/.vim/autoload/plug.vim"
install_vim_plug() {
  curl -fLo "$PLUG_VIM" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}
install_plugins() { nvim --headless +PlugInstall +qall; }
plugins_present() { [ -d "$HOME/.vim/plugged/coc.nvim" ]; }

COC_DIR="$HOME/.config/coc/extensions"
install_coc_exts() { (cd "$COC_DIR" && npm install --no-package-lock --ignore-scripts --legacy-peer-deps); }
coc_exts_present() { [ -d "$COC_DIR/node_modules/coc-tsserver" ]; }

# --- run ---------------------------------------------------------------------
LINKS=(
  "zsh/.zshrc:$HOME/.zshrc"
  "zsh/.zprofile:$HOME/.zprofile"
  "vim/.vimrc:$HOME/.vimrc"
  "nvim/init.vim:$HOME/.config/nvim/init.vim"
  "git/.gitconfig:$HOME/.gitconfig"
  ".tool-versions:$HOME/.tool-versions"
  "coc/package.json:$COC_DIR/package.json"
)

main() {
  step "Xcode Command Line Tools" "xcode-select -p >/dev/null 2>&1" install_clt
  step "Homebrew" "have brew || [ -x /opt/homebrew/bin/brew ]" install_brew
  load_brew
  step "Brewfile (asdf, neovim, pure, SF Mono Powerline, ...)" \
    "brew bundle check --no-upgrade --file='$DOTFILES/Brewfile' >/dev/null 2>&1" install_bundle
  step "oh-my-zsh" "[ -d '$HOME/.oh-my-zsh' ]" install_omz

  local pair
  for pair in "${LINKS[@]}"; do link "${pair%%:*}" "${pair#*:}"; done

  step "asdf nodejs plugin" "asdf plugin list 2>/dev/null | grep -qx nodejs" install_asdf_node
  step "asdf tools (.tool-versions)" "(cd '$HOME' && asdf current nodejs >/dev/null 2>&1)" install_tool_versions
  export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
  step "npm globals (yarn, neovim)" npm_globals_present install_npm_globals
  step "vim-plug" "[ -f '$PLUG_VIM' ]" install_vim_plug
  step "nvim plugins" plugins_present install_plugins
  step "coc extensions" coc_exts_present install_coc_exts

  echo
  say "Installed (${#INSTALLED[@]}): ${INSTALLED[*]:-none}"
  say "Skipped   (${#SKIPPED[@]}): ${SKIPPED[*]:-none}"
  say "iTerm2: Settings > Profiles > Text > Font = 'SF Mono for Powerline'"
  say "Open a new terminal (or: exec zsh) to load the config."
}

main "$@"
