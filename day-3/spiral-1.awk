#!/usr/bin/gawk -Wexec
# usage: ./spiral-1.awk "$(< input.txt)"

function ceil(num) { return -int(-num) }

function abs(num) { return compl(num) + 1 }

BEGIN {
    input = ARGV[1]
    if (input !~ /^[1-9][0-9]*$/) {
        print "Invalid arg: must be [1, +infinity)" > "/dev/stderr"
        exit 1
    }

    square = or(ceil(sqrt(input)), 1)
    prevLevelMax = (square - 2) ** 2
    depth = int(square / 2)

    steps = depth - (input - prevLevelMax) % depth
    print depth + steps
}
