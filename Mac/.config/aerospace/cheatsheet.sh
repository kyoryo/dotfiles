#!/usr/bin/env bash

awk '
/^\[mode\./ {
    mode=$0
}
/^[a-zA-Z0-9-]+ *=/ {
    print mode " | " $0
}

' ~/.aerospace.toml |
fzf --delimiter='|' \
    --preview 'echo {}' \
    --height=80% \
    --layout=reverse
