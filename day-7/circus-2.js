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

    root[name].weight = +weight
    root[name].children = children

    children.forEach(child => {
        if (!root[child]) 
            root[child] = {}
        root[child].parent = name
        delete root.__ROOT[child]
    })
}

function getSums(index) {
    root[index].sum = 0
    root[index].sum =
        root[index].weight +
        root[index].children.reduce((acc, child) => {
            return acc + getSums(child)
        }, 0)
    return root[index].sum
}

function findUnbalance(index) {
    if (root[index].children.length > 1) {
        var retval = 0
        var ret = root[index].children.find(child => {
            retval = findUnbalance(child)
            return retval != 0
        })
        if (ret) return retval
    }
    else { 
        return 0
    }

    var compare = root[root[index].children[0]].sum
    var badIndex = root[index].children.slice(1).reduce((acc, val, ind) => {
        if (acc != -1 && compare != root[val].sum) 
            return 0
        else if (compare != root[val].sum) 
            return ind + 1
        else
            return acc
    }, -1)

    if (badIndex == -1) {
        return 0
    }
    else if (badIndex == 0) {
        return root[root[index].children[0]].weight - 
            (compare - root[root[index].children[1]].sum)
    }
    else {
        return root[root[index].children[badIndex]].weight -
            (root[root[index].children[badIndex]].sum - compare)
    }
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
    getSums(Object.keys(root.__ROOT)[0])
    console.log(findUnbalance(Object.keys(root.__ROOT)[0]))
})

