#!/usr/bin/gawk -Wexec
BEGIN { valid = 0 }

function anagram(str,   nstr, i) {
    split(str, chars, //)
    len = asort(chars, sorted)
    for (i=1; i<=len; ++i)
        nstr = nstr sorted[i]
    return nstr
}

{
    delete uniq
    for (i=1; i<=NF; ++i) {
        if (uniq[anagram($i)]++) next
    }
    ++valid
}

END { print valid }
