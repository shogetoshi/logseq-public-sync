#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title LogseqPublicSync
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 {"type": "text", "placeholder": "target", "optional": true}

function validate() {
    if [[ -n "$1" ]] && ! echo "$1" | grep -q '^2\d\{7\}$'; then
        echo "[Error] TARGET needs to be YYYYMMDD"
        exit 1
    fi
}

format_date() {
    if [[ -n "$1" ]]; then
        local input_date="$1"
        local year="${input_date:0:4}"
        local month="${input_date:4:2}"
        local day="${input_date:6:2}"
        echo "${year}_${month}_${day}"
    else
        date '+%Y_%m_%d'
    fi
}

TARGET="$1"
validate "$TARGET"
TARGET="$(format_date $TARGET)"

BASEDIR="$(dirname $0)"
bash "$BASEDIR/go.sh" link/src/${TARGET}.md link/dst/${TARGET}.md

