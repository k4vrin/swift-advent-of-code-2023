//
//  Day01.swift
//
//
//  Created by Mostafa Hosseini on 12/2/23.
//

import Algorithms

struct Day01: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    // Splits input data into its component parts and convert from string.
    var entities: [[Int]] {
        data.split(separator: "\n\n").map {
            $0.split(separator: "\n").compactMap { Int($0) }
        }
    }
    
    let numLetterMap = ["one":1, "two":2, "three":3, "four":4, "five":5, "six":6, "seven":7, "eight":8, "nine":9]

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        // Calculate the sum of the first set of input data
        let lines = data.components(separatedBy: "\n").dropLast()
        let b = lines.map { line in
            let a = line.first { ch in ch.isNumber }!
            let b = line.last { ch in ch.isNumber }!
            return Int("\(a)\(b)")
        }
        return b.reduce(0) { partialResult, num in
            return partialResult + num!
        }
    }

    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        let lines = data.components(separatedBy: "\n").dropLast()
        let s = lines.map { line in
            var numLetterIndexes = Dictionary<String.Index, String>()
            var digitsIndexes = Dictionary<String.Index, String>()
            
            numLetterMap.keys.forEach { numLetter in
                if line.contains(numLetter) {
                    let i = line.ranges(of: numLetter).map { range in
                        range.lowerBound
                    }
                    numLetterIndexes[i.first!] = String(numLetterMap[numLetter]!)
                    numLetterIndexes[i.last!] = String(numLetterMap[numLetter]!)
                }
            }
            
            line.forEach { ch in
                if ch.isNumber {
                    let i1 = line.firstIndex(of: ch)!
                    let i2 = line.lastIndex(of: ch)!
                    digitsIndexes[i1] = String(ch)
                    digitsIndexes[i2] = String(ch)
                }
            }
            
            digitsIndexes.forEach { (key, value) in
                numLetterIndexes[key] = value
            }
            
            let sortedMap = numLetterIndexes.sorted { ma1, ma2 in
                ma2.key > ma1.key
            }
            
            return Int("\(sortedMap.first!.value)\(sortedMap.last!.value)")!
        }
        
        print(s)
        // Sum the maximum entries in each set of data
        return s.reduce(0) { partialResult, num in
            partialResult + num
        }
    }
}

extension StringProtocol {
    func distance(of element: Element) -> Int? { firstIndex(of: element)?.distance(in: self) }
    func distance<S: StringProtocol>(of string: S) -> Int? { range(of: string)?.lowerBound.distance(in: self) }
}

extension Collection {
    func distance(to index: Index) -> Int { distance(from: startIndex, to: index) }
}

extension String.Index {
    func distance<S: StringProtocol>(in string: S) -> Int { string.distance(to: self) }
}
