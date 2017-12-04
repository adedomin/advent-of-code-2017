#!/usr/bin/node
'use strict'

// run as ./spiral.js "$(< input.txt)"
// note, this requires node v8

if (!process.argv[2] || isNaN(process.argv[2])) {
    console.error('Invalid Argument, must be a positive number')
    process.exit(1)
}

const blockNum = process.argv[2]
const squared = Math.ceil(Math.sqrt(blockNum)) | 0b1
const level =  Math.trunc(squared/2)
const startOf = squared - 2 ** 2
const halfOf = (squared & ~0b1) ** 2 +  1
const quarterOf = halfOf - (squared-1)
const threeQuarterOf = halfOf + (squared-1)
const endOf = squared ** 2

var coord = { x: 0, y: 0, dist: 0 }

if (blockNum <= quarterOf) {
    coord.x = level
    coord.y = level - (quarterOf - blockNum)
}
else if (blockNum <= halfOf) {
    coord.x = -level + (halfOf - blockNum) 
    coord.y = level
}
else if (blockNum <= threeQuarterOf) {
    coord.x = -level
    coord.y = -level + (threeQuarterOf - blockNum)
}
else {
    coord.x = level - (endOf - blockNum)
    coord.y = -level
}

coord.dist = Math.abs(coord.x) + Math.abs(coord.y)

console.log(`Point: [${coord.x},${coord.y}] distance: ${coord.dist}`)
