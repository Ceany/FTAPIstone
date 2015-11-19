//
//  GameViewController.swift
//  FTAPIstone
//
//  Created by Maximilian Meier on 28/10/15.
//  Copyright © 2015 TiloBox. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, GameInterface {
    
    var game: Game?
    var player1Name: String = ""
    var scene: BoardScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = self.view as! SKView
        
        scene = BoardScene(size: skView.bounds.size)
        
        // Configure the view.
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
        
        setupGame()
        
    }
    
    
    
    func setupGame() {
        game = Game(interface: self, player1Name: "Maxi", player2Name: "Alex")
        
        doTurn()
    }
    
    func doTurn() {
        do {
            try game?.playTurnAutomatically()
        } catch {
            print("Oh noes!")
        }
        
        if let game = game {
            if !game.gameFinished {
                NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("doTurn"), userInfo: nil, repeats: false)
            }
        }
    }
    
    func startedTurn(player: Player) {
        if player1Name == "" {
            player1Name = player.name
        }
    }
    
    func finishedTurn(player: Player) {
        
    }
    
    func drawnCard(player: Player, card: Card) {
        let playerNumber = player.name == player1Name ? 1 : 2
        
        scene.renderCards(playerNumber, deck: player.deck)
    }
    
    func playedCard(opponent: Player, cardPlayed: Card) {
        scene.renderScore("\(opponent.name) was dealt \(cardPlayed.attack) damage!")
    }
    
    func gameFinished(winner: Player, loser: Player) {
        scene.renderScore("Game finished and \(winner.name) won!")
    }
    
}
