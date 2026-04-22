# gx

A minimal shell plugin for kubectx-style Google Cloud project switching.

Uses [`fzf`](https://github.com/junegunn/fzf) for interactive fuzzy project selection and wraps `gcloud` project switching into two fast commands.

## Commands

| Command | Description |
|---------|-------------|
| `gx`   | **Permanently** switch the active project via `gcloud config set project` |
| `gx -` | Switch back to the **previous** project (like `cd -`) |
| `tgx`  | **Temporarily** switch the project for the current shell session only (sets `CLOUDSDK_CORE_PROJECT`) |

## Requirements

- [`gcloud` CLI](https://cloud.google.com/sdk/docs/install)
- [`fzf`](https://github.com/junegunn/fzf)

## Install

```sh
git clone https://github.com/jesbinjoseph/gcloudx.git
cd gcloudx
bash install.sh
```

`install.sh` copies `gx.plugin.zsh` to `~/.gx/` and adds a `source` line to `~/.zshrc` and/or `~/.bashrc`.

Restart your shell, or source the plugin manually:

```sh
source ~/.gx/gx.plugin.zsh
```

## Uninstall

```sh
bash uninstall.sh
```

Removes `~/.gx/` and cleans the `source` line from `~/.zshrc` / `~/.bashrc`.

## Usage

Run `gx` to permanently switch your active project:

```
$ gx
> my-project-a
  my-project-b
  my-project-c
Switched to project: my-project-a
```

Run `gx -` to switch back to the previous project:

```
$ gx -
Switched to project: my-project-b
```

Run `tgx` to switch only for the current shell session:

```
$ tgx
> my-project-b
CLOUDSDK_CORE_PROJECT=my-project-b (session only)
```

Press `Esc` or `Ctrl-C` in fzf to cancel without making any changes.

## Design

- Two shell functions, no config files, no abstractions.
- No dependencies beyond `gcloud` and `fzf`.
- POSIX-compatible (`[ ]` tests, works in both zsh and bash).
- Cancelling fzf selection (empty result) is a no-op.