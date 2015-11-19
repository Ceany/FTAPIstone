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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = BoardScene(fileNamed:"BoardScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
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

    }
    
    func finishedTurn(player: Player) {
 
    }
    
    func drawnCard(player: Player, card: Card) {
        
    }
    
    func playedCard(opponent: Player, cardPlayed: Card) {
        
    }
    
    func gameFinished(winner: Player, loser: Player) {

    }
    
}
