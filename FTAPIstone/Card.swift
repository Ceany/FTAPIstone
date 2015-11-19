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
    let damage: Int
    
    init(){
        self.manaCosts = 0
        self.damage = 0
    }
    
    init(manaCosts: Int){
        self.manaCosts = manaCosts
        self.damage = manaCosts
    }
    
    var description: String {
        return "Card(\(manaCosts))"
    }
}

public func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.manaCosts == rhs.manaCosts && lhs.damage == rhs.damage
}