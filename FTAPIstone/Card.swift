//
//  Card.swift
//  FTAPIstone
//
//  Created by Maximilian Meier on 17/09/15.
//  Copyright © 2015 TiloBox. All rights reserved.
//

import Foundation

public struct Card: Equatable {
    let manaCosts: Int
    let health: Int
    let attack: Int
    let identifier: Int
    
    init(manaCosts: Int, health: Int, attack: Int, identifier: Int){
        self.manaCosts = manaCosts
        self.health = health
        self.attack = attack
        self.identifier = identifier
    }
    
    var description: String {
        return "Card(\(manaCosts))"
    }
}

public func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.manaCosts == rhs.manaCosts && lhs.attack == rhs.attack
}