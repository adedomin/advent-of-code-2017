#!/usr/bin/mawk -Wexec

function die(msg) {
    print "Error: " msg > "/dev/stderr"
    exitCode = 1
    exit 1
}

BEGIN { 
    FS = ""
    depth = 0
    garbage = 0
    escape = 0
    commaNext = 0
    total = 0
}

{
    for (i=1; i<=NF; ++i) {
        if (garbage) {    
            if (escape) {
                escape = 0                
            }
            else if ($i == ">") {
                garbage = 0    
                commaNext = 1
            }
            else if ($i == "!") {
                escape = 1
            }
            else {
                ++total    
            }
        }    
        else if ($i == "<") {
            garbage = 1    
        }
        else if (commaNext) {
            if ($i == ",") {
                commaNext = 0    
            }
            else if ($i == "}") {
                --depth    
            }
            else {
                die("Group must be preceded by a comma.")    
            }
        }
        else if ($i == "{") {
            ++depth
        }
        else if ($i == "}") {
            --depth    
            commaNext = 1
        }
        else {
            die("Syntax error; unexpected token (" $i ") at position: " i)
        }
    }
}

END {
    if (exitCode)
        exit 1    
    else if (depth != 0)
        print "Error: Unbalanced Groups." > "/dev/stderr"
    else if (inGarbage)
        print "Error: Unbalanced Garbage." > "/dev/stderr"    
    else
        print "Total garbage characters: " total
}
