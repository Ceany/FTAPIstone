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
    let playerLabels = [SKLabelNode(), SKLabelNode()]
    var cardNodes = [CardNode]()
    var game: Game?
    
    override func didMoveToView(view: SKView) {
        scoreNode.position = CGPointMake(10, 25)
        scoreNode.horizontalAlignmentMode = .Left;
        
        var verticalOffset = 120
        
        playerLabels[0].position = CGPointMake(10, CGRectGetMaxY(self.frame) - CGFloat(verticalOffset))
        playerLabels[0].horizontalAlignmentMode = .Left;
        
        verticalOffset = 320
        playerLabels[1].position = CGPointMake(10, CGRectGetMaxY(self.frame) - CGFloat(verticalOffset))
        playerLabels[1].horizontalAlignmentMode = .Left;

        addChild(playerLabels[0])
        addChild(playerLabels[1])
        addChild(scoreNode)
    }
    
    func renderScore(score: String) {
       scoreNode.text = score
    }
    
    func renderCards(player: Player) {
        let verticalOffset = 200 * player.number
        
        cardNodes = cardNodes.filter { (cardNode) -> Bool in
            if cardNode.player == player {
                cardNode.removeFromParent()
                return false
            }
            return true
        }
        
        let playerLabel = playerLabels[player.number - 1]
        playerLabel.text = "\(player.name)'s Hand (\(player.health))"
        
        var index = 0;
        for card in player.handcards {
            let cardNode = CardNode(player: player, card: card)
            cardNodes.append(cardNode)
            cardNode.position = CGPoint(x: (70 * index) + 50, y: Int(CGRectGetMaxY(self.frame)) - verticalOffset)
            
            self.addChild(cardNode)
            index++
        }
    }
}
