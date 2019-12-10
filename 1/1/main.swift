//
//  main.swift
//  1
//
//  Created by Brian Kendig on 12/9/19.
//  Copyright © 2019 Brian Kendig. All rights reserved.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! String(contentsOfFile: path!)
}

func fuelRequired(for mass: Int) -> Int {
    return max(Int(floor(Double(mass) / 3.0)) - 2, 0)
}

func main() {
    var totalFuelPart1 = 0
    var totalFuelPart2 = 0
    let masses: [Int] = getInput().split(separator: "\n").map { Int(String($0))! }
    for mass in masses {
        var additionalFuel = fuelRequired(for: mass)
        totalFuelPart1 += additionalFuel
        repeat {
            totalFuelPart2 += additionalFuel
            additionalFuel = fuelRequired(for: additionalFuel)
        } while additionalFuel > 0

    }
    print(totalFuelPart1)
    print(totalFuelPart2)
}

main()
