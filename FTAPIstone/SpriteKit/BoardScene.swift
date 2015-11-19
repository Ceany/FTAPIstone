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
    let scoreNode = SKLabelNode(text: "TEST")
    var cardNodesPlayer1 = [SKLabelNode]()
    var cardNodesPlayer2 = [SKLabelNode]()
    
    override func didMoveToView(view: SKView) {
        scoreNode.position = CGPointMake(CGRectGetMidX(self.frame), 25)
        
        self.addChild(scoreNode)
    }
    
    func renderScore(score: String) {
       scoreNode.text = score
    }
    
    func renderCards(playerNumber: Int, deck: Deck) {
        let verticalOffset = 200 * playerNumber
        
        var cardNodes = playerNumber == 1 ? cardNodesPlayer1 : cardNodesPlayer2
        
        self.removeChildrenInArray(cardNodes)
        cardNodes.removeAll()
        
        var index = 0;
        for card in deck.cards {
            let cardNode = SKLabelNode.init(text: "(\(card.attack))")
            cardNodes.append(cardNode)
            cardNode.position = CGPoint(x: (Int(CGRectGetMinX(self.frame)) + 50) * index, y: Int(CGRectGetMaxY(self.frame)) - verticalOffset)
            
            self.addChild(cardNode)
            index++
        }
    }
}
