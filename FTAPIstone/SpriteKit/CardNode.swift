//
//  CardNode.swift
//  FTAPIstone
//
//  Created by Alex Stonehouse on 19.11.15.
//  Copyright © 2015 TiloBox. All rights reserved.
//

import UIKit
import SpriteKit

class CardNode: SKLabelNode {

    var player: Player = Player()
    var card: Card = Card()
    
    init(player: Player, card: Card) {
        super.init()
        self.player = player
        self.card = card
        self.text = "(\(card.attack))"
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
