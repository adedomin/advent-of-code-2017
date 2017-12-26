#!/usr/bin/mawk -Wexec

function die(msg) {
    print msg > "/dev/stderr"    
    exitCode =1
    exit(1)
}

function interpCond(cond, reg1, reg2) {
         if (cond == ">" ) return reg[reg1] >  reg2
    else if (cond == ">=") return reg[reg1] >= reg2
    else if (cond == "<" ) return reg[reg1] <  reg2
    else if (cond == "<=") return reg[reg1] <= reg2
    else if (cond == "==") return reg[reg1] == reg2
    else if (cond == "!=") return reg[reg1] != reg2
    else { print "Error: Invalid Conditional"; exit(1) }
}

function interpInstruct(instr, reg1, value) {
         if (instr == "inc") reg[reg1] += value
    else if (instr == "dec") reg[reg1] -= value
    else { print "Error: Invalid instruction" > "/dev/stderr"; exit(1) }
}

BEGIN { 
    max = ""
    regname = ""
}

{
    if (interpCond($6, $5, $7)) 
        interpInstruct($2, $1, $3)

    if (max == "" || max < reg[$1]) {
        max = reg[$1]
        regname = $1
    }
}

END {
    if (exitCode) exit exitCode
    print "Max Value Seen:", regname, max
}
