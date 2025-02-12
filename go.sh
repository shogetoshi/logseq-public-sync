#!/usr/bin/env bash
set -euo pipefail

INPUT="$1"
OUTPUT="$2"

BASEDIR="$(dirname $0)"
cat "$INPUT" | python3 "$BASEDIR/extract.py" >> "$OUTPUT"
temp_file=$(mktemp "/tmp/logseq-public-sync.XXXXXX")
cat "$INPUT" > $temp_file
cat $temp_file | sed 's/#public//g' > "$INPUT"
