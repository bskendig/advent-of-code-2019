//
//  main.swift
//  2
//
//  Created by Brian Kendig on 12/9/19.
//  Copyright © 2019 Brian Kendig. All rights reserved.
//

import Foundation

var program: [Int]!
var pc: Int!

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! String(contentsOfFile: path!)
}

func next() -> Int {
    let i = program[pc]
    pc += 1
    return i
}

func run() {
    pc = 0
    var i: Int
    var isRunning = true
    repeat {
        i = next()
        switch i {
        case 1:
            let sum = program[next()] + program[next()]
            let position = next()
            program[position] = sum
        case 2:
            let multiplicand = program[next()] * program[next()]
            let position = next()
            program[position] = multiplicand
        case 99:
            isRunning = false
        default:
            fatalError()
        }
    } while isRunning
}

func main() {
    let originalProgram = getInput().trimmingCharacters(in: .newlines).split(separator: ",").map { Int(String($0))! }

    program = originalProgram
    program[1] = 12
    program[2] = 2
    run()
    print(program[0])

    for noun: Int in 0..<originalProgram.count {
        for verb: Int in 0..<originalProgram.count {
            program = originalProgram
            program[1] = noun
            program[2] = verb
            run()
            if program[0] == 19690720 {
                print(100 * noun + verb)
                break
            }
        }
    }
}

main()
