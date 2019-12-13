//
//  main.swift
//  6
//
//  Created by Brian Kendig on 12/12/19.
//  Copyright © 2019 Brian Kendig. All rights reserved.
//

import Foundation

var mapData: [String: String] = [:]
var distance: [String: Int] = [:]

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! String(contentsOfFile: path!)
}

func howManyParents(of satellite: String) -> Int {
    if mapData[satellite] == nil {
        distance[satellite] = 0
        return 0
    } else if let d = distance[satellite] {
        return d
    } else if let s = mapData[satellite] {
        let d = howManyParents(of: s) + 1
        distance[satellite] = d
        return d
    } else {
        fatalError()
    }
}

func listOrbits(of satellite: String) -> Set<String> {
    var orbitList: Set<String> = []
    var loc = satellite
    repeat {
        loc = mapData[loc]!
        orbitList.insert(loc)
    } while mapData[loc] != nil
    return orbitList
}

func main() {
    let orbits = getInput().split(separator: "\n")
    for orbit in orbits {
        let pair = orbit.split(separator: ")")
        let orbited = String(pair[0])
        let satellite = String(pair[1])
        mapData[satellite] = orbited
    }
    let total = mapData.keys.map { howManyParents(of: $0) }.reduce(0, +)
    print(total)

    let myOrbits = listOrbits(of: "YOU")
    let santaOrbits = listOrbits(of: "SAN")
    let distinctOrbits = myOrbits.symmetricDifference(santaOrbits)
    print(distinctOrbits.count)
}

main()
