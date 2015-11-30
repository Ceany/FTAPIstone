//
//  BoardScene.swift
//  FTAPIstone
//
//  Created by Alex Stonehouse on 19.11.15.
//  Copyright © 2015 TiloBox. All rights reserved.
//

import UIKit
import SpriteKit

protocol UserInteraction {
    func didTouchPlay()
}

class BoardScene: SKScene, GameInterface {
    let boardNode = SKSpriteNode(imageNamed: "board")
    let scoreNode = SKLabelNode()
    let playerLabels = [SKLabelNode(), SKLabelNode()]
    var cardNodes = [CardNode]()
    let playButton = SKSpriteNode(imageNamed: "playButton")
    var userInteractionDelegate: UserInteraction?
    
    override func didMoveToView(view: SKView) {
        boardNode.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        boardNode.zPosition = -1
        addChild(boardNode)
        
        scoreNode.position = CGPointMake(10, 25)
        scoreNode.horizontalAlignmentMode = .Left;
        scoreNode.fontSize = 18
        scoreNode.fontColor = UIColor.whiteColor()
        
        var verticalOffset = 50
        
        playerLabels[0].position = CGPointMake(10, CGRectGetMaxY(self.frame) - CGFloat(verticalOffset))
        playerLabels[0].horizontalAlignmentMode = .Left;
        playerLabels[0].fontSize = 14
        playerLabels[0].fontColor = UIColor.whiteColor()
        
        verticalOffset = 320
        playerLabels[1].position = CGPointMake(10, CGRectGetMaxY(self.frame) - CGFloat(verticalOffset))
        playerLabels[1].horizontalAlignmentMode = .Left;
        playerLabels[1].fontSize = 14
        playerLabels[1].fontColor = UIColor.whiteColor()
        
        playButton.size = CGSizeMake(50, 30)
        playButton.position = CGPointMake(CGRectGetMaxX(self.frame) - 30, 50)

        addChild(playerLabels[0])
        addChild(playerLabels[1])
        addChild(scoreNode)
        addChild(playButton)
    }
    
    func startedTurn(player: Player) {
        
    }
    
    func finishedTurn(player: Player) {
        for card in cardNodes {
            if card.player == player {
                card.flipped = true
            } else {
                card.flipped = false
            }
        }
    }
    
    func drawnCard(player: Player, card: Card) {
        renderCards(player)
        
        let playerLabel = playerLabels[player.number - 1]
        playerLabel.text = "\(player.name)'s Hand (\(player.health))"
    }
    
    func playedCard(opponent: Player, cardPlayed: Card) {
        renderScore("\(opponent.name) was dealt \(cardPlayed.attack) damage!")
        
        let playerLabel = playerLabels[opponent.number - 1]
        playerLabel.text = "\(opponent.name)'s Hand (\(opponent.health))"
    }
    
    func gameFinished(winner: Player, loser: Player) {
        renderScore("Game finished and \(winner.name) won!")
    }
    
    func renderScore(score: String) {
       scoreNode.text = score
    }
    
    func renderCards(player: Player) {
        let verticalOffset = player.number == 1 ? 150 : 450
        
        cardNodes = cardNodes.filter { (cardNode) -> Bool in
            if cardNode.player == player {
                cardNode.removeFromParent()
                return false
            }
            return true
        }
        
        
        
        let midX = CGRectGetMidX(self.frame)
        
        var zIndex = CGFloat(player.handcards.count)
        var index = 0;
        for card in player.handcards {
            let cardNode = CardNode(player: player, card: card)
            cardNodes.append(cardNode)
            
            let targetDegrees = 45.0 - (Double(index) * 20.0)
            let rotateAction = SKAction.rotateToAngle(CGFloat(targetDegrees * 0.0175), duration: 0)
            
            if targetDegrees < 0 {
                cardNode.anchorPoint = CGPoint(x: 0, y: 0)
                cardNode.position = CGPoint(x: Int(midX) - 50, y: Int(CGRectGetMaxY(self.frame)) - verticalOffset)
            } else {
                cardNode.anchorPoint = CGPoint(x: 1, y: 0)
                cardNode.position = CGPoint(x: Int(midX), y: Int(CGRectGetMaxY(self.frame)) - verticalOffset)
            }
            
            cardNode.zPosition = zIndex
            zIndex--
            
            
            cardNode.runAction(rotateAction)
            
            addChild(cardNode)
            index++
        }
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.locationInNode(self)
        let nodeTouched = nodeAtPoint(touchLocation)

        if nodeTouched == playButton {
            userInteractionDelegate?.didTouchPlay()
        }
    }
}
