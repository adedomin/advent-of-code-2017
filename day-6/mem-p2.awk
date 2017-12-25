#!/usr/bin/mawk -Wexec

function getMaxInd(arr,     i, maxind) {
    maxind = 1
    for (i=2; i<=bankCount; ++i) {
        if (arr[maxind] < arr[i]) {
            maxind = i
        }
    }

    return maxind
}

function join(arr,      i, retstring) {
    retstring = arr[1]
    for (i=2; i<=bankCount; ++i)
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
    loop = 0
    while (!image[join(bank)]++) {
        currInd = getMaxInd(bank, bankCount)
        blocks = bank[currInd]
        bank[currInd] = 0
        rounds = int(blocks / bankCount)

        for (ind in bank)
            bank[ind] += rounds

        blocks -= rounds * bankCount
        currInd = currInd % bankCount + 1

        while (blocks > 0) {
            ++bank[currInd]
            --blocks
            currInd = currInd % bankCount + 1
        }

        if (loop == 0 && image[join(bank)] == 1) {
            delete image    
            ++loop
        }
    }

    print "Cycle period: " length(image)
}
