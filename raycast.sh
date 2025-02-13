#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title LogseqPublicSync
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 {"type": "text", "placeholder": "target", "optional": true}

BASEDIR="$(dirname $0)"

function validate() {
    if [[ -n "$1" ]] && ! echo "$1" | grep -q '^2\d\{7\}$'; then
        echo "[Error] TARGET needs to be YYYYMMDD"
        exit 1
    fi
}

get_src_paths() {
    if [[ -n "$1" ]]; then
        local input_date="$1"
        local year="${input_date:0:4}"
        local month="${input_date:4:2}"
        local day="${input_date:6:2}"
        echo "link/src/${year}_${month}_${day}.md"
    else
        grep -lR '#public' "$BASEDIR/link/src/" | \
            grep -v "$(date '+%Y_%m_%d')" | \
            sed 's%src//%src/%'
    fi
}

TARGET="$1"
validate "$TARGET"
SRCS="$(get_src_paths $TARGET)"

for src in $SRCS; do
    bash "$BASEDIR/go.sh" "$src" "${src/src/dst}"
done
echo "LogseqPublicSync: ${SRCS:-Empty}"

