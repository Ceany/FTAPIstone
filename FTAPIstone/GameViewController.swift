//
//  GameViewController.swift
//  FTAPIstone
//
//  Created by Maximilian Meier on 28/10/15.
//  Copyright © 2015 TiloBox. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, PlayerspaceDataProvider, GameInterface {
    @IBOutlet weak var roundLabel: UILabel!
    var playerSpace1Initialized = false
    var playerSpace1: PlayerspaceViewController?
    var playerSpace2: PlayerspaceViewController?
    var game: Game?

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.isKindOfClass(PlayerspaceViewController) {
            if playerSpace1 == nil {
                if let vc = segue.destinationViewController as? PlayerspaceViewController {
                    playerSpace1 = vc
                    playerSpace1?.dataProvider = self
                }
            } else {
                if let vc = segue.destinationViewController as? PlayerspaceViewController {
                    playerSpace2 = vc
                    playerSpace2?.dataProvider = self
                }
            }
        }
    }
    
    func requestForData(playerspaceVC: PlayerspaceViewController) {
        if !playerSpace1Initialized {
            playerSpace1Initialized = true
        } else {
            setupGame()
        }
    }

    
    func setupGame() {
        game = Game(interface: self, player1Name: "Maxi", player2Name: "Alex")
        playerSpace1?.player = game?.player1
        playerSpace2?.player = game?.player2
        
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
        roundLabel.text = "Round: \(game?.round)"
    }
    
    func finishedTurn(player: Player) {
        playerSpace1?.updatePlayer()
        playerSpace2?.updatePlayer()
    }
    
    func drawnCard(player: Player, card: Card) {
        
    }
    
    func playedCard(opponent: Player, cardPlayed: Card) {
        
    }
    
    func gameFinished(winner: Player, loser: Player) {
        roundLabel.text = "\(winner.name) won the game! \(loser.name) is a friggin loser!"
    }
    
}
