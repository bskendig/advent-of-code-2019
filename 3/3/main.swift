//
//  main.swift
//  3
//
//  Created by Brian Kendig on 12/9/19.
//  Copyright © 2019 Brian Kendig. All rights reserved.
//

import Foundation

var grid: [Int: [Int: Int]] = [:]
var closestDistance: Int?
var shortestDistance: Int?

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! String(contentsOfFile: path!)
}

func set(x: Int, y: Int, i: Int) {
    if grid[x] == nil {
        grid[x] = [:]
    }
    if x != 0 || y != 0, i < 0, let j = grid[x]?[y], j > 0 {
        let newDistance = abs(x) + abs(y)
        closestDistance = (closestDistance == nil) ? newDistance : min(closestDistance!, newDistance)
        let newDistance2 = j + abs(i)
        shortestDistance = (shortestDistance == nil) ? newDistance2 : min(shortestDistance!, newDistance2)
    }
    grid[x]![y] = i
}

func step(direction: String) -> (x: Int, y: Int) {
    let step: (x: Int, y: Int)
    switch direction {
    case "U":
        step = (x: 0, y: -1)
    case "D":
        step = (x: 0, y: 1)
    case "L":
        step = (x: -1, y: 0)
    case "R":
        step = (x: 1, y: 0)
    default:
        fatalError()
    }
    return step
}

func main() {
    let paths = getInput().split(separator: "\n")
    let path1 = paths[0].split(separator: ",").map { String($0) }
    let path2 = paths[1].split(separator: ",").map { String($0) }

    var x = 0
    var y = 0
    var distance = 0
    for wire in path1 {
        let direction = String(wire.prefix(1))
        let count = Int(wire.suffix(wire.count - 1))!

        set(x: 0, y: 0, i: 1)  // start of path 1

        let s = step(direction: direction)
        for _ in 0..<count {
            x += s.x
            y += s.y
            distance += 1
            set(x: x, y: y, i: distance)
        }
    }

    x = 0
    y = 0
    distance = 0
    for wire in path2 {
        let direction = String(wire.prefix(1))
        let count = Int(wire.suffix(wire.count - 1))!

        let s = step(direction: direction)
        for _ in 0..<count {
            x += s.x
            y += s.y
            distance -= 1
            set(x: x, y: y, i: distance)
        }
    }
    print(closestDistance)
    print(shortestDistance)
}

main()
