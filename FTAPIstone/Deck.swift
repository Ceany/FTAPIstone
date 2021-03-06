//
//  Deck.swift
//  FTAPIstone
//
//  Created by Maximilian Meier on 17/09/15.
//  Copyright © 2015 TiloBox. All rights reserved.
//

import Foundation

enum DeckErrors : ErrorType {
    case Empty
}

public struct Deck {
    var cards: [Card]
    
    init(){
        cards = []
        
        do {
            if let cardsPath = NSBundle.mainBundle().pathForResource("cards", ofType: "json") {
                if let cardsData = NSData(contentsOfFile: cardsPath) {
                    
                    if  let cardsJSON: AnyObject = try NSJSONSerialization.JSONObjectWithData(cardsData, options:NSJSONReadingOptions.MutableContainers) {
                        if let cardsArray: NSArray = cardsJSON["cards"] as NSArray {
                            for card in cardsArray as! [NSDictionary]{
                                cards.append(Card(manaCosts: card.valueForKey("manaCosts") as! Int, health: card.valueForKey("health") as! Int, attack: card.valueForKey("attack") as! Int, identifier: card.valueForKey("identifier") as! Int))
                                cards.append(Card(manaCosts: card.valueForKey("manaCosts") as! Int, health: card.valueForKey("health") as! Int, attack: card.valueForKey("attack") as! Int, identifier: card.valueForKey("identifier") as! Int))
                            }
                        }
                    }
                    
                    
                }
            }
            
        } catch let error as NSError {
           print(error)
        }
        
    }
    
    mutating func drawCard() throws -> Card {
        guard cards.count > 0 else {
            throw DeckErrors.Empty
        }
        
        let position = cards.count > 1 ? Int(arc4random_uniform(UInt32(cards.count-1))) : 0
        
        let cardDrawn = self.cards.removeAtIndex(position)
    
        return cardDrawn
    }
    
    mutating func drawCards(number:Int) throws -> [Card] {
        var cardsDrawn = [Card]()
        for _ in 1...number {
            try cardsDrawn.append(drawCard())
        }
        return cardsDrawn
    }
}