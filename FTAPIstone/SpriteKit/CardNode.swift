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
    
    private var _flipped: Bool = false
    var flipped : Bool {
        get {
            return self._flipped
        }
        set(newValue) {
            if newValue != flipped {
                if flipped {
                    self.texture = SKTexture(imageNamed: "back")
                } else {
                    self.texture = SKTexture(imageNamed: String(card.identifier))
                }
            }
            _flipped = newValue
        }
    }
    
    convenience init(player: Player, card: Card) {
        let color = UIColor()
        let texture = SKTexture(imageNamed: String(card.identifier))
        let size = CGSizeMake(66.0, 100.0)
        self.init(texture: texture, color: color, size: size)
        self.player = player
        self.card = card
    }
}
