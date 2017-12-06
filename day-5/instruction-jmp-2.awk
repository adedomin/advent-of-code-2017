#!/usr/bin/mawk -Wexec
BEGIN { pos = 1; steps = 0 }

{ instruction[NR] = $0 }

END { 
    while (pos <= NR) {
        if (instruction[pos] >= 3) 
            pos += instruction[pos]--
        else 
            pos += instruction[pos]++
        ++steps
    }
    print steps 
}
