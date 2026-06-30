# Dot-files

Personal dotfiles for Vassil Kalkov. Managed via symlinks from this repo to `~/`.

## Structure

```
essential/        minimal setup (bash, vim, tmux, git)
full/             full setup (zsh, santiment tools, aws, vault, terraform)
full/bin/         scripts → symlinked to ~/.local/bin/
full/.aws/        AWS config (no credentials — credentials stay local)
full/CLAUDE.md    global Claude Code context → ~/CLAUDE.md
full/AGENTS.md    global Codex context → ~/AGENTS.md
install-essential.sh
install-full.sh
```

## Install

```bash
./install-essential.sh   # symlinks essential/* → ~/
./install-full.sh        # symlinks essential/* + full/* → ~/
                         # full/bin/* → ~/.local/bin/
                         # full/.aws/config → ~/.aws/config
```

After full install, create vault credential templates:
```bash
san-vault-setup
```
Then fill in `~/.config/vault/<cluster>.env` per cluster.

## Where things go

| What | File |
|------|------|
| Santiment shell functions (`san-*`) | `full/.santiment` |
| Personal cluster helpers (no `san-` prefix) | `full/.santiment` |
| General aliases (`tf`, `ll`, etc.) | `essential/.aliases` |
| General shell functions | `essential/.functions` |
| PATH additions | `essential/.paths` |
| Standalone scripts | `full/bin/<script>` |
| AWS region/profile config | `full/.aws/config` |

## Conventions

- `san-` prefix for Santiment-specific functions (e.g. `san-ku-aws-prod`)
- No prefix for personal helpers (e.g. `ku-terrarino`)
- **No secrets in this repo** — credentials stay in `~/.config/vault/`, `~/.aws/credentials`, etc.
- Commit and push after changes so other machines stay in sync
