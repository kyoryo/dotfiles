# Moving to a new Mac

Snapshot taken 2026-10-28 from the old machine. This repo is **public**, so nothing secret lives here.

## 1. Restore from this repo

```sh
# Xcode CLT + Homebrew first
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

git clone https://github.com/kyoryo/dotfiles.git ~/git/dotfiles && cd ~/git/dotfiles/Mac

brew bundle --file=Brewfile            # formulae, casks, go/cargo/npm tools, 72 nerd fonts (prune if you like)

# oh-my-zsh must be installed BEFORE copying .zshrc (and must not overwrite it)
KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cp .zshrc .vimrc .gitconfig ~/
cp -R .zsh ~/
mkdir -p ~/.config ~/.claude
rsync -a .config/ ~/.config/
cp .claude/settings.json .claude/keybindings.json ~/.claude/
```

Then:

- **tmux**: `git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm`, start tmux, press `prefix + I`.
- **yazi**: `ya pkg install` (restores `whoosh` from `package.toml`).
- **nvim**: just open it, lazy.nvim installs plugins from `lazy-lock.json`; Mason tools reinstall on demand.
- **sketchybar**: `brew services start sketchybar`. `borders` is launched by AeroSpace.
- **jiratui**: edit `~/.config/jiratui/config.yaml` (username / token / URL are placeholders).
- **gh**: `gh auth login` (only `config.yml` is tracked, not auth).

## 2. Re-grant by hand (cannot be migrated)

- Accessibility / Input Monitoring: AeroSpace, Karabiner-Elements, KeyCastr, Ghostty.
- Karabiner driver extension approval, Colemak-DH keyboard layout enable.
- Login items (AeroSpace, Karabiner, Dropbox, sketchybar).
- App sign-ins: Dropbox, Docker Desktop, Teams/Outlook, Obsidian, KeePassXC, OpenVPN profiles.

## 3. NOT in this repo: transfer securely (AirDrop / encrypted USB / `rsync` over SSH)

| Path | Why |
| --- | --- |
| `~/.ssh` | bastion / runner / ojire `.pem` keys, `config`, `known_hosts`. `chmod 600` the keys afterwards |
| `~/.aws` | `credentials` + `config` |
| `~/.kube`, `~/.docker/config.json`, `~/.terraform.d` | cluster creds, registry auth |
| `~/.hermes` (1.2 GB, has `.env`), `~/.9router` | agent state + API keys / JWT secret |
| `~/.claude.json`, `~/.claude/{projects,history.jsonl,plans}` | Claude Code sessions/history (optional) |
| `~/bni/*.pem` | private key |
| `~/.zsh_history` | shell history (optional) |
| KeePassXC database | wherever it lives (check Dropbox) |

## 4. Work that exists only on this disk

- `~/git/ojire/be`: **584 commits on local branches not on any remote**, 5 branches with no upstream, **14 stashes** (stashes are never pushed).
- `~/git/ojire/be-gh-runner-migration`, `be-gh-runner-pilot`: **not git repos**: copy the folders.
- `~/git/ojire/webapp`: 1 unpushed commit + 1 dirty file. `~/git/pintu/pintugopkg`: 2 dirty. `~/git/pintu/pintumono`: detached HEAD, 4 dirty.
- `~/git/golangStructToYamlOapi`: 2 untracked files (`components.yaml`, `goschema`).
- Also look at: `~/RestAPI`, `~/Postman`, `~/Documents`, `~/Desktop`, `~/Downloads` (2.7 GB), loose files in `~` (`*.csv`, `loadtest.js`, `scratchpad`, ...).

## 5. Known issues in the copied config

- `tmux.conf`: `@catppuccin_flavour 'moch'` is a typo (probably `mocha`); the unterminated quote on the `run .../tpm` line was fixed in this copy.
- `aerospace/cheatsheet.sh` reads `~/.aerospace.toml`, but the config lives in `~/.config/aerospace/aerospace.toml`.
- Not copied on purpose: nvim `.git` (live config is its own repo: `kyoryo/nvchad-conf`), tmux/yazi plugin dirs, Karabiner `automatic_backups`, opencode `node_modules` and `skills/` (also symlinked from `~/.claude/skills`), Zed prompt DB.
