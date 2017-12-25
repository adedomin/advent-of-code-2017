#!/usr/bin/mawk -Wexec

function getMaxInd(arr, len,    i, maxind) {
    maxind = 1
    for (i=2; i<=len; ++i) {
        if (arr[maxind] < arr[i]) {
            maxind = i
        }
    }

    return maxind
}

function join(arr, len,     i, retstring) {
    retstring = arr[1]
    for (i=2; i<=len; ++i)
        retstring = retstring " " arr[i]

    return retstring
}

{
    bankCount = NF
    for (i=1; i<=NF; ++i) {
        bank[i] = $i
    }
}

END {
    while (!image[join(bank, bankCount)]++) {
        currInd = getMaxInd(bank, bankCount)
        blocks = bank[currInd]
        bank[currInd] = 0
        currInd = currInd % bankCount + 1

        while (blocks > 0) {
            ++bank[currInd]
            --blocks
            currInd = currInd % bankCount + 1
        }
    }

    print "Cycles til loop: " length(image)
}
