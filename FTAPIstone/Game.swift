//
//  Game.swift
//  FTAPIstone
//
//  Created by Maximilian Meier on 17/09/15.
//  Copyright © 2015 TiloBox. All rights reserved.
//

import Foundation

protocol GameInterface {
    func startedTurn(player: Player)
    func finishedTurn(player: Player)
    
    func drawnCard(player: Player, card: Card)
    func playedCard(opponent: Player, cardPlayed: Card)
    
    func gameFinished(winner: Player, loser: Player)
}

enum GameError: ErrorType {
    case CardNotInHand
}


public class Game {
    var players: [Player]
    var activePlayer: Player {
        get {
            return players[0]
        }
    }
    var opponentPlayer: Player {
        get {
            return players[1]
        }
    }
    var interface: GameInterface?
    
    var round:Int = 0
    var gameFinished = false
    
    convenience init(interface: GameInterface, player1Name: String, player2Name: String){
        self.init(player1Name: player1Name, player2Name: player2Name);
        self.interface = interface
    }
    
    init(player1Name: String, player2Name: String){
        players = [Player(name: player1Name), Player(name: player2Name)]
    }
    
    public func drawCard() -> Card {
        let drawnCard = activePlayer.deck.drawCard()
        activePlayer.handcards.append(drawnCard)
        
        return drawnCard
    }
    
    public func startTurn() {
        round++
        
        interface?.startedTurn(activePlayer)
        activePlayer.mana = activePlayer.manaslots
        
        let drawnCard = drawCard()
        interface?.drawnCard(activePlayer, card: drawnCard)
    }
    
    public func finishTurn() {
        var player = activePlayer == players[0] ? players[1] : players[0]
        
        defer {
            player.manaslots++
        }
        
        interface?.finishedTurn(activePlayer)
        
        if opponentPlayer.health > 0 {
            players = [players[1], players[0]]
        } else {
            gameFinished = true
            interface?.gameFinished(activePlayer, loser: opponentPlayer)
        }
    }
    
    public func playCard(card: Card) throws {
        if !activePlayer.handcards.contains(card) {
            throw GameError.CardNotInHand
        }
        
        opponentPlayer.health -= card.attack
        interface?.playedCard(opponentPlayer, cardPlayed: card)
    }
    
}

extension Game {
    
    public func playAutomatically(delayBetweenTurns: UInt32) throws {
        repeat {
            try playTurnAutomatically()
            sleep(delayBetweenTurns)
        } while (!gameFinished)
    }
    
    public func playTurnAutomatically() throws {
        startTurn()
        
        defer {
            finishTurn()
        }
        
        let cardsToPlay = chooseCardsAutomatically(activePlayer.handcards, mana: activePlayer.mana)
        
        for card in cardsToPlay {
            try playCard(card)
        }
        
        for card in cardsToPlay {
            activePlayer.handcards.removeAtIndex(activePlayer.handcards.indexOf(card)!)
        }
    }
    
    private func chooseCardsAutomatically(var cards: [Card], mana: Int) -> [Card] {
        var manaLeft = mana
        var cardsToPlay = [Card]()
        
        repeat {
            guard let thisCard = cards.popLast() where thisCard.manaCosts < manaLeft else {
                break
            }
            
            cardsToPlay.append(thisCard)
            manaLeft -= thisCard.manaCosts
        } while( manaLeft > 0 )
        
        return cardsToPlay
    }
    
}
