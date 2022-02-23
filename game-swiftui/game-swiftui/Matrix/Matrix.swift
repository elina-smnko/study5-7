//
//  Matrix.swift
//  game-swiftui
//
//  Created by Elina Semenko on 18.02.2022.
//

import Foundation

enum Move {
    case up, down, left, right
}

enum ArrayDirection {
    case left, right
}

class Matrix: ObservableObject {
    @Published private(set) var value: [[Int]] = [[0,2,2,4],[0,0,4,0],[2,0,0,0],[0,2,0,4]]
    
    func move(_ move: Move) {
        switch move {
        case .up:
            rotate()
            for (index, _) in value.enumerated() {
                value[index].moveArray(.left)
            }
            rotate()
            addRandom()
        case .down:
            rotate()
            for (index, _) in value.enumerated() {
                value[index].moveArray(.right)
            }
            rotate()
            addRandom()
        case .left:
            for (index, _) in value.enumerated() {
                value[index].moveArray(.left)
            }
            addRandom()
        case .right:
            for (index, _) in value.enumerated() {
                value[index].moveArray(.right)
            }
            addRandom()
        }
    }
    
    private func rotate() {
        var result = [[Int]]()
        for i in (0..<value.capacity) {
            result.append([Int]())
            for row in value {
                result[i].append(row[i])
            }
        }
        value = result
    }
    
    private func addRandom() {
        var zeroPositions = [(Int, Int)]()
        for (indexR, row) in value.enumerated() {
            for (index, element) in row.enumerated() {
                if element == 0 {
                    zeroPositions.append((indexR, index))
                }
            }
        }
        guard let position = zeroPositions.randomElement(), let val = [2,2,2,2,4,4,8].randomElement() else { return }
        value[position.0][position.1] = val
    }
}

extension Array where Element == Int {
    mutating func moveArray(_ move: ArrayDirection) {
        var prev = [Element]()
        switch move {
        case .left:
            self = Array(self.reversed())
            self.moveArray(.right)
            self = Array(self.reversed())
        case .right:
            while prev != self {
                prev = self
                for (index, _) in self.enumerated() {
                    if index+1 == self.capacity {break}
                    if self[index] == self[index+1] {
                        self[index+1] = self[index]*2
                        self[index] = 0
                    } else if self[index] != 0 && self[index+1] == 0 {
                        self[index+1] = self[index]
                        self[index] = 0
                    }
                }
            }
        }
    }
}
