//
//  BoardScene.swift
//  FTAPIstone
//
//  Created by Alex Stonehouse on 19.11.15.
//  Copyright © 2015 TiloBox. All rights reserved.
//

import UIKit
import SpriteKit

class BoardScene: SKScene {
    let scoreNode = SKLabelNode()
    var cardNodes = [CardNode]()
    var game: Game?
    
    override func didMoveToView(view: SKView) {
        scoreNode.position = CGPointMake(10, 25)
        scoreNode.horizontalAlignmentMode = .Left;
        
        self.addChild(scoreNode)
    }
    
    func renderScore(score: String) {
       scoreNode.text = score
    }
    
    func renderCards(player: Player, deck: Deck) {
        let verticalOffset = 200 * player.number
        
        cardNodes = cardNodes.filter { (cardNode) -> Bool in
            if cardNode.player == player {
                cardNode.removeFromParent()
                return false
            }
            return true
        }
        
        var index = 0;
        for card in deck.cards {
            let cardNode = CardNode(player: player, card: card)
            cardNode.horizontalAlignmentMode = .Left;
            cardNodes.append(cardNode)
            cardNode.position = CGPoint(x: 30 * index, y: Int(CGRectGetMaxY(self.frame)) - verticalOffset)
            
            self.addChild(cardNode)
            index++
        }
    }
}
