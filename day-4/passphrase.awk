#!/usr/bin/mawk -Wexec
BEGIN { valid = 0 }

{
    delete uniq
    for (i=1; i<=NF; ++i) {
        if (uniq[$i]++) next
    }
    ++valid
}

END { print valid }
