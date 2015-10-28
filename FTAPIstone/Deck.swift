//
//  Deck.swift
//  FTAPIstone
//
//  Created by Maximilian Meier on 17/09/15.
//  Copyright © 2015 TiloBox. All rights reserved.
//

import Foundation

public struct Deck {
    var cards: [Card]
    
    init(){
        self.cards = [Card(manaCosts: 0),Card(manaCosts: 0),Card(manaCosts: 1),Card(manaCosts: 1),Card(manaCosts: 2),Card(manaCosts: 2),Card(manaCosts: 2),Card(manaCosts: 3),Card(manaCosts: 3),Card(manaCosts: 3),Card(manaCosts: 3),Card(manaCosts: 4),Card(manaCosts: 4),Card(manaCosts: 5),Card(manaCosts: 5),Card(manaCosts: 6),Card(manaCosts: 6),Card(manaCosts:7),Card(manaCosts: 8)]
    }
    
    mutating func drawCard() -> Card {
        let position = Int(arc4random_uniform(UInt32(cards.count-1)))
        
        let cardDrawn = self.cards.removeAtIndex(position)
    
        return cardDrawn
    }
    
    mutating func drawCards(number:Int) -> [Card] {
        var cardsDrawn = [Card]()
        for _ in 1...number {
            cardsDrawn.append(drawCard())
        }
        return cardsDrawn
    }
}