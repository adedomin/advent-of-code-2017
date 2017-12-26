#!/usr/bin/env node
'use strict'

const fs = require('fs') 

var root = { __ROOT: {} }

function createNode(name, weight, children) {
    if (!root[name])
        root[name] = {}

    if (!root[name].parent) {
        root[name].parent = '__ROOT'
        root.__ROOT[name] = true
    }

    root[name].weight = weight
    root[name].children = children

    children.forEach(child => {
        if (!root[child]) 
            root[child] = {}
        root[child].parent = name
        delete root.__ROOT[child]
    })
}

fs.readFile(process.argv[2] || '/dev/stdin', (err, data) => {
    if (err) throw err
    var nodes = data.toString().replace(/,/g, '').split('\n')
    nodes.forEach(node => {
        node = node.split(' ')
        if (node.length < 2) return
        createNode(
            node[0],
            node[1].substring(1, node[1].length-1),
            node.slice(3)
        )
    })
    console.log(Object.keys(root.__ROOT)[0])
})

