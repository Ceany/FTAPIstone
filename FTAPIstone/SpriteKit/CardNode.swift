//
//  CardNode.swift
//  FTAPIstone
//
//  Created by Alex Stonehouse on 19.11.15.
//  Copyright © 2015 TiloBox. All rights reserved.
//

import UIKit
import SpriteKit

class CardNode: SKSpriteNode {

    var player: Player = Player()
    var card: Card = Card()
    
    convenience init(player: Player, card: Card) {
        let color = UIColor()
        let texture = SKTexture(imageNamed: String(card.identifier))
        let size = CGSizeMake(100.0, 150.0)
        self.init(texture: texture, color: color, size: size)
        self.player = player
        self.card = card
    }
}
