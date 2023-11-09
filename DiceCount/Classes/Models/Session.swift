//
//  Session.swift
//  DiceCount
//
//  Created by Roland Keesom on 07/03/2023.
//

import Foundation

class Session: Codable, CustomDebugStringConvertible {
    var date: Date
    private var rounds: [Round] = []
    
    init(date: Date = Date()) {
        self.date = date
    }
    
    func addRound(_ round: Round) {
        rounds.append(round)
    }
    
    func roundsGroupedByNumber() -> [Int:Int] {
        var groupedRounds: [Int:Int] = [:]
        for round in rounds {
            let result = round.result.reduce(0, +)
            if let count = groupedRounds[result] {
                groupedRounds[result] = count + 1
            } else {
                groupedRounds[result] = 1
            }
        }
        return groupedRounds
    }
    
    func roundsCount() -> Int {
        return rounds.count
    }
    
    var debugDescription: String {
        "Rounds: \(rounds)"
    }
}
