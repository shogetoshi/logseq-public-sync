#!/usr/bin/env python
import sys


def count_indent(line):
    count = 0
    for char in line:
        if char == "\t":
            count += 1
        else:
            break
    return count


public_groups = []

lines = sys.stdin.readlines()
indent = -1
for line in [
    line.rstrip("\n") for line in lines if not (line.lstrip()).startswith("collapsed::")
]:
    if "#public" in line:
        indent = count_indent(line)
        group = [line.replace("#public", "")[indent:]]
        continue
    if indent >= 0:
        if count_indent(line) > indent:
            group.append(line[indent:])
        else:
            public_groups.append(group)
            group = []
            indent = -1

joined_groups = ["\n".join(g) for g in public_groups]
print("\n" + "\n".join(joined_groups) + "\n")
