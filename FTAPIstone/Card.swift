//
//  Card.swift
//  FTAPIstone
//
//  Created by Maximilian Meier on 17/09/15.
//  Copyright © 2015 TiloBox. All rights reserved.
//

import Foundation

public struct Card {
    let manaCosts: Int
    let damage: Int
    
    init(manaCosts: Int){
        self.manaCosts = manaCosts
        self.damage = manaCosts
    }
}