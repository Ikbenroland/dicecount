//
//  Round.swift
//  DiceCount
//
//  Created by Roland Keesom on 07/03/2023.
//

import Foundation

struct Round: Codable {
    var result:[Int] = []
    
    init(result: [Int]) {
        self.result = result
    }
}
