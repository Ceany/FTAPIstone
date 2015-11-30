//
//  GameViewController.swift
//  FTAPIstone
//
//  Created by Maximilian Meier on 28/10/15.
//  Copyright © 2015 TiloBox. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, UserInteraction {
    
    var game: Game?
    var player1Name: String = ""
    var scene: BoardScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = self.view as! SKView
        
        scene = BoardScene(size: skView.bounds.size)
        scene.userInteractionDelegate = self
        self.game = Game(interface: scene, player1Name: "Maxi", player2Name: "Alex")
        doTurn()
        
        // Configure the view.
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
    }
    
    func doTurn() {
        do {
            try game?.playTurnAutomatically()
        } catch {
            print("Oh noes!")
        }
        
//        if let game = game {
//            if !game.gameFinished {
//                NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("doTurn"), userInfo: nil, repeats: false)
//            }
//        }
    }
    
    func didTouchPlay() {
        doTurn()
    }
    
}
