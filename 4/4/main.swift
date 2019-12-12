//
//  main.swift
//  4
//
//  Created by Brian Kendig on 12/9/19.
//  Copyright © 2019 Brian Kendig. All rights reserved.
//

import Foundation

func isValid(_ i: Int) -> Bool {
    let a = Array(String(i))
    let c = a.map { $0.wholeNumberValue }
    if c.count != 6 {
        return false
    }
    guard var previousCharacter: Int = c[0] else {
        fatalError()
    }
    var hasAdjacentDigits = false
    var digitsDecrease = false
    for i in 1..<c.count {
        guard let t: Int = c[i] else
        {
            fatalError()
        }
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

func main() {
    var validInts: [Int] = []
    for i in 234208...765869 {
        if isValid(i) {
            validInts.append(i)
        }
    }
    print(validInts.count)
}

main()
