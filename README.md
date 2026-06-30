# Personal dot files

All existing dot files will be replaced without asking.

Clone the repo:

    git clone git@github.com:kalkov/dot-files.git ~/dot-files

Choose between essential and full packages.

## Essential

Used for slower machines like RaspberryPI or small cloud instances.

### Prerequisites
* [fzf](https://github.com/junegunn/fzf)
* [tmux](https://github.com/tmux/tmux/wiki)
* [tpm](https://github.com/tmux-plugins/tpm)
* [Vundle](https://github.com/VundleVim/Vundle.vim)

### Install
Symlink dot files from `~/dot-files/essential` to `~/`:

    ./install-essential.sh

Installs symlinks for: `.aliases`, `.bash_profile`, `.bashrc`, `.functions`, `.gitconfig`, `.gitignore`, `.paths`, `.profile`, `.tmux.conf`, `.vimrc`, `.ssh/config`

## Full

Used for desktop, laptop or powerful cloud instances. Includes the essential package.

### Prerequisites

* [zsh](https://www.zsh.org/)
* [antigen](https://github.com/zsh-users/antigen)
* [fzf](https://github.com/junegunn/fzf)
* [tmux](https://github.com/tmux/tmux/wiki)
* [tpm](https://github.com/tmux-plugins/tpm)
* [Vundle](https://github.com/VundleVim/Vundle.vim)
* [k9s](https://k9scli.io/)
* [gh](https://cli.github.com/)
* [ghostty](https://ghostty.org/)

### Install
Symlink dot files from `~/dot-files/essential` & `~/dot-files/full` to `~/`:

    ./install-full.sh

In addition to the essential symlinks, installs:

| What | Destination |
|------|-------------|
| Shell config (`.zshrc`, `.santiment`, etc.) | `~/` |
| Scripts (`vault-ctx`) | `~/.local/bin/` |
| AWS config | `~/.aws/config` |
| gh config | `~/.config/gh/config.yml` |
| k9s config | `~/.config/k9s/config.yaml` |
| ghostty config | `~/.config/ghostty/config` |
| kube loader | `~/.kube/load-kube-configs.sh` |
| Global AI context | `~/CLAUDE.md`, `~/AGENTS.md` |

## Vault access

The `full` package includes `vault-ctx`, a wrapper for accessing Vault across Santiment clusters.

### Usage

    vault-ctx <cluster> <vault args...>

    vault-ctx aws-prod kv get secret/foo
    vault-ctx system status

Available clusters: `system`, `aws-prod`, `aws-stage`, `hetzner-stage`, `hetzner-prod`.

### Setup on a new machine

After running `install-full.sh`, create the credential files:

    san-vault-setup

This creates `~/.config/vault/<cluster>.env` templates. Fill in `VAULT_USER` and `VAULT_PASS` for each cluster, then verify:

    vault-ctx <cluster> status

Credentials are machine-local and not stored in this repo.

## New machine checklist

1. `git clone git@github.com:kalkov/dot-files.git ~/dot-files`
2. `cd ~/dot-files && ./install-full.sh`
3. `san-vault-setup` — create vault credential templates, then fill them in
4. Place kubeconfig files in `~/.kube/config-files/` (as `.yaml` symlinks)
5. Place SSH keys in `~/.ssh/` (config is already symlinked, keys are machine-local)
6. `gh auth login` — authenticate the GitHub CLI
