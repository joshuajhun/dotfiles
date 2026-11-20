# dotfiles

My Mac dev setup: Homebrew, asdf + Node, npm/yarn, oh-my-zsh with the pure prompt, Neovim (vim-plug + coc.nvim), and the SF Mono Powerline font.

## Install

```sh
git clone https://github.com/joshuajhun/dotfiles ~/dotfiles
cd ~/dotfiles && ./install.sh
```

You can run it again at any time. Each step checks first and skips anything that's already there. Existing dotfiles get moved to `*.bak-<timestamp>` before they're replaced with symlinks into this repo.

## What it does

1. Installs the Xcode Command Line Tools
2. Installs Homebrew, then everything in the `Brewfile` (asdf, neovim, pure, gh, ripgrep, ag, `font-sf-mono-for-powerline`, ...)
3. Installs oh-my-zsh
4. Symlinks `.zshrc`, `.zprofile`, `.vimrc`, `~/.config/nvim/init.vim`, `.tool-versions`, and the coc extension list
5. **Git (opt-in):** asks *"Set up git with YOUR name/email?"*. If you say yes, it writes your name and email to `~/.gitconfig.local` (never committed) and links the shared `.gitconfig`. If you say no, git is left alone, which is what you want on someone else's computer. To skip the prompt: `GIT_NAME="..." GIT_EMAIL="..." ./install.sh`. GitHub sign-in is per person through `gh auth login`.
6. Installs Node through asdf (version from `.tool-versions`) and the global npm packages `yarn` and `neovim`
7. Installs vim-plug and runs `:PlugInstall`
8. Installs the coc.nvim extensions (tsserver, eslint, prettier, json, css, html, lists)

Afterward, set the iTerm2 font: **Settings → Profiles → Text → SF Mono for Powerline**.

## Layout

| Path | Goes to |
|---|---|
| `zsh/.zshrc`, `zsh/.zprofile` | `~/` |
| `vim/.vimrc` | `~/.vimrc` |
| `nvim/init.vim` | `~/.config/nvim/init.vim` (loads `~/.vimrc`) |
| `coc/package.json` | `~/.config/coc/extensions/package.json` |
| `git/.gitconfig` | `~/.gitconfig` (only if you opt in; includes `~/.gitconfig.local`) |
| `.tool-versions` | `~/.tool-versions` |
