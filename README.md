Home Directory Config Files (dotfiles)
=====================================

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
