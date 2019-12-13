//
//  main.swift
//  7
//
//  Created by Brian Kendig on 12/12/19.
//  Copyright © 2019 Brian Kendig. All rights reserved.
//

import Foundation

var program: [Int]!
var pc: Int!
var inputData: [Int] = []
var outputData: [Int] = []

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! String(contentsOfFile: path!)
}

func next() -> Int {
    let i = program[pc]
    pc += 1
    return i
}

func val(_ modes: inout [Int]) -> Int {
    let v = next()
    let mode = modes.isEmpty ? 0 : modes.removeFirst()

    switch mode {
    case 0:
        return program[v]
    case 1:
        return v
    default:
        fatalError()
    }
}

func run() {
    pc = 0
    var i: Int
    var isRunning = true
    repeat {
        i = next()
        var modes = Array(String(format: "%05d", Int(i / 100))).reversed().map { $0.wholeNumberValue! }
        let opcode = i % 100
        switch opcode {
        case 1:
            let sum = val(&modes) + val(&modes)
            let position = next()
            program[position] = sum
        case 2:
            var multiplicand = val(&modes)
            multiplicand *= val(&modes)
            let position = next()
            program[position] = multiplicand
        case 3:
            program[next()] = input()
        case 4:
            output(val(&modes))
        case 5:
            let p1 = val(&modes)
            let p2 = val(&modes)
            if p1 != 0 {
                pc = p2
            }
        case 6:
            let p1 = val(&modes)
            let p2 = val(&modes)
            if p1 == 0 {
                pc = p2
            }
        case 7:
            let p1 = val(&modes)
            let p2 = val(&modes)
            let p3 = next()
            program[p3] = (p1 < p2) ? 1 : 0
        case 8:
            let p1 = val(&modes)
            let p2 = val(&modes)
            let p3 = next()
            program[p3] = (p1 == p2) ? 1 : 0
        case 99:
            isRunning = false
        default:
            fatalError("unrecognized opcode: \(opcode)")
        }
    } while isRunning
}

func input() -> Int {
    return inputData.removeFirst()
}

func output(_ i: Int) {
    outputData.append(i)
}

func allPermutations<T>(of items: [T]) -> [[T]] {
    if items.count == 1 { return [items] }
    var allResults: [[T]] = []
    for (i, loc) in items.enumerated() {
        var mutableItems = items
        mutableItems.remove(at: i)
        let permutations = allPermutations(of: mutableItems)
        let p = permutations.map { (a: [T]) -> [T] in
            var b = a
            b.insert(loc, at: 0)
            return b
        }
        allResults += p
    }
    return allResults
}

func main() {
    let originalProgram = getInput().trimmingCharacters(in: .newlines).split(separator: ",").map { Int(String($0))! }
    var phaseSettings = Array(0...4)
    var highestSignal = 0

    for settings in allPermutations(of: phaseSettings) {
        var input = 0
        for instance in 0...4 {
            program = originalProgram
            inputData = [settings[instance], input]
            outputData = []
            run()
            input = outputData.first!
        }
        highestSignal = max(highestSignal, outputData.first!)
    }
    print(highestSignal)

    phaseSettings = Array(5...9)
    for settings in allPermutations(of: phaseSettings) {
        var input = 0
        for instance in 0...4 {
            program = originalProgram
            inputData = [settings[instance], input]
            outputData = []
            run()
            input = outputData.first!
        }
        print(outputData)
    }

}

main()
