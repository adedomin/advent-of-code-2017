#!/usr/bin/gawk -Wexec
# usage: ./spiral-1.awk "$(< input.txt)"

function ceil(num) { return (num == int(num)) ? num : int(num) + 1 }

function abs(num) { return sqrt(num * num) }

BEGIN {
    input = ARGV[1]
    if (input !~ /^[1-9][0-9]*$/) {
        print "Invalid arg: must be [1, +infinity)" > "/dev/stderr"
        exit 1
    }

    square = or(ceil(sqrt(input)), 1)
    prevLevelMax = (square - 2) ^ 2
    depth = int(square / 2)


    steps = abs(depth - (input - prevLevelMax)) % (2 * depth)
    print depth + steps
}
