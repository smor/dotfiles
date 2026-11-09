# dotfiles

Managed with [chezmoi](https://chezmoi.io). zsh (antidote + oh-my-zsh plugins,
starship prompt), Ghostty, git, vim, mise (node/python), Homebrew packages and apps.

## New Mac

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin init --apply smor
```

That one command, in order:

1. installs chezmoi into `~/.local/bin` and clones this repo;
2. asks for your git name and email (stored in `~/.config/chezmoi/chezmoi.toml`, not in the repo);
3. installs **Homebrew** if missing, which also installs the Xcode Command Line Tools
   (asks for your password once; needs an admin account);
4. writes the dotfiles and clones antidote (zsh plugin manager);
5. installs everything in `~/.Brewfile`: command-line tools and apps (`brew bundle`);
6. installs node/python with `mise install`, and the vim plugins.

Then, by hand:

- open a new terminal (Ghostty is installed by step 5);
- `gh auth login` (git pushes to GitHub use the gh login);
- sign in to the apps; App Store apps and work-managed apps aren't in the Brewfile.

Machine-specific shell settings go in `~/.zshrc_local` (not in this repo).

## Day to day

| Task | Command |
|---|---|
| Pull and apply changes from GitHub | `chezmoi update` |
| Edit a dotfile | `chezmoi edit ~/.zshrc` then `chezmoi apply` |
| See what would change | `chezmoi diff` |
| Add a Homebrew package or app | add it to `~/.Brewfile` (`chezmoi edit ~/.Brewfile`), then `chezmoi apply` |
| Installed by hand, not in the Brewfile | `brew bundle cleanup --global` (dry run) |
| Pin a node/python version in a project | `.nvmrc` / `.python-version`, or `mise use node@22` |

## Existing clone

If the repo is already cloned somewhere, `./install.sh` from inside it installs
chezmoi if needed and applies from that folder.
