//
//  Player.swift
//  FTAPIstone
//
//  Created by Maximilian Meier on 17/09/15.
//  Copyright © 2015 TiloBox. All rights reserved.
//

import Foundation

class Player {
    var health: Int = 30
    var manaslots: Int = 1
    var mana: Int = 0
    var deck: Deck
    var handcards: [Card]
    var name:String
    
    init(name: String){
        self.name = name
        deck = Deck()
        handcards = deck.drawCards(3)
    }
    
    /*func describeHand() -> String {
        var
        for card in handcards {
            
        }
    }*/
}
