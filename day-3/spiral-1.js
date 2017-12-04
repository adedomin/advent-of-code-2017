#!/usr/bin/node
'use strict'

// run as ./spiral.js "$(< input.txt)"
// note, this requires node v8

if (!process.argv[2] || 
    isNaN(process.argv[2]) || 
    process.argv[2] < 1
) {
    console.error('Invalid Argument, must be a positive number')
    process.exit(1)
}

const blockNum = process.argv[2]
if (blockNum == 1) return console.log(0)

const squared = Math.ceil(Math.sqrt(blockNum)) | 0b1
const level =  Math.trunc(squared/2)
const endOf = Math.pow(squared, 2)
const steps = Math.abs(level - (endOf - blockNum) % (2 * level))

console.log(level + steps)
