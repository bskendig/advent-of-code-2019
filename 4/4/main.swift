//
//  main.swift
//  4
//
//  Created by Brian Kendig on 12/9/19.
//  Copyright © 2019 Brian Kendig. All rights reserved.
//

import Foundation

func isValidPart1(_ c: [Int]) -> Bool {
    if c.count != 6 {
        return false
    }
    var previousCharacter = c[0]
    var hasAdjacentDigits = false
    var digitsDecrease = false
    for i in 1..<c.count {
        let t: Int = c[i]
        if t == previousCharacter {
            hasAdjacentDigits = true
        }
        if t < previousCharacter {
            digitsDecrease = true
        }
        previousCharacter = t
    }
    return hasAdjacentDigits && !digitsDecrease
}

func isValidPart2(_ c: [Int]) -> Bool {
    var runCount = 1
    var previousCharacter = c[0]
    for i in 1..<c.count {
        let t = c[i]
        if t == previousCharacter {
            runCount += 1
        } else {
            if runCount == 2 {
                return true
            } else {
                runCount = 1
                previousCharacter = t
            }
        }
    }
    return runCount == 2
}

func main() {
    var validIntsPart1: [Int] = []
    var validIntsPart2: [Int] = []
    for i in 234208...765869 {
        let c = Array(String(i)).map { $0.wholeNumberValue! }
        if isValidPart1(c) {
            validIntsPart1.append(i)
            if isValidPart2(c) {
                validIntsPart2.append(i)
            }
        }
    }
    print(validIntsPart1.count)
    print(validIntsPart2.count)
}

main()
