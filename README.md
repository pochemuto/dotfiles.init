Home Directory Config Files (dotfiles)
=====================================
Based on [The Bare Repo Approach to Storing Home Directory Config Files (Dotfiles) in Git using Bash, Zsh, or Powershell](https://dev.to/bowmanjd/store-home-directory-config-files-dotfiles-in-git-using-bash-zsh-or-powershell-the-bare-repo-approach-35l3)

Source repo: https://github.com/pochemuto/dotfiles

## Restore

```shell
OUT="$(mktemp)"; wget -q -O - https://raw.githubusercontent.com/pochemuto/dotfiles.init/main/bare.sh > $OUT; . $OUT
restore-dots
```

## Usage
### Status
```
dots st
```

### Adding tracked
```
dots add -u
```
