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
    private let player1: Player
    private let player2: Player
    var activePlayer: Player
    let interface: GameInterface
    
    var round:Int = 0
    var gameFinished = false
    
    init(interface: GameInterface, player1Name: String, player2Name: String){
        self.interface = interface
        player1 = Player(name: player1Name)
        player2 = Player(name: player2Name)
        activePlayer = player1
    }
    
    public func getOtherPlayer(player: Player) -> Player {
        return player == player1 ? player2 : player1
    }
    
    public func startTurn() {
        interface.startedTurn(activePlayer)
        activePlayer.mana = activePlayer.manaslots
        
        let drawnCard = activePlayer.deck.drawCard()
        interface.drawnCard(activePlayer, card: drawnCard)
        activePlayer.handcards.append(drawnCard)
    }
    
    public func finishTurn() {
        defer {
            activePlayer.manaslots++
        }
        
        interface.finishedTurn(activePlayer)
        
        let opponent = getOtherPlayer(activePlayer)
        if opponent.health > 0 {
            activePlayer = opponent
        } else {
            gameFinished = true
            interface.gameFinished(activePlayer, loser: opponent)
        }
    }
    
    public func playCard(card: Card) throws {
        if !activePlayer.handcards.contains(card) {
            throw GameError.CardNotInHand
        }
        
        let opponent = getOtherPlayer(activePlayer)
        opponent.health -= card.damage
        interface.playedCard(opponent, cardPlayed: card)
    }
    
}

extension Game {
    
    public func playAutomatically() throws {
        repeat {
            try playTurnAutomatically()
            sleep(3)
        } while (!gameFinished)
    }
    
    private func playTurnAutomatically() throws {
        startTurn()
        
        defer {
            finishTurn()
        }
        
        let cardsToPlay = chooseCardsAutomatically(activePlayer.handcards, mana: activePlayer.mana)
        
        for card in cardsToPlay {
            try playCard(card)
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
