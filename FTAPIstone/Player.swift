//
//  Player.swift
//  FTAPIstone
//
//  Created by Maximilian Meier on 17/09/15.
//  Copyright © 2015 TiloBox. All rights reserved.
//

import Foundation

private var playerNumber = 1

public class Player : Equatable {
    let number: Int
    var health: Int = 30
    var manaslots: Int = 1
    var mana: Int = 0
    var deck: Deck
    var handcards: [Card]
    var name: String
    
    convenience init(){
        self.init(name: "")
    }
    
    init(name: String){
        self.name = name
        deck = Deck()
        do {
            handcards = try deck.drawCards(2)
        } catch {
            handcards = [Card]()
        }
        number = playerNumber
        playerNumber++
    }
    
}

public func ==(lhs: Player, rhs: Player) -> Bool {
    return lhs.name == rhs.name;
}
