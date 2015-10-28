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


public class Game {
    let player1: Player
    let player2: Player
    let interface: GameInterface
    var round:Int = 0
    
    init(interface: GameInterface, player1Name: String, player2Name: String){
        self.interface = interface
        self.player1 = Player(name: player1Name)
        self.player2 = Player(name: player2Name)
    }
    
    public func playRound() {
        
        interface.startedTurn(player1)
        playTurn(player1, opponent: player2)
        interface.finishedTurn(player1)
        if player2.health > 0 {
            interface.startedTurn(player2)
            playTurn(player2, opponent: player1)
            interface.finishedTurn(player2)
        } else {
            interface.gameFinished(player1, loser: player2)
        }
        
        if player1.health <= 0 {
            interface.gameFinished(player2, loser: player1)
        }
    }
    
    public func getOtherPlayer(player: Player) -> Player {
        return player == player1 ? player2 : player1
    }
    
    private func playTurn(activePlayer: Player, opponent: Player){
        activePlayer.mana = activePlayer.manaslots
        defer {
            activePlayer.manaslots++
        }
        
        let drawnCard = activePlayer.deck.drawCard()
        interface.drawnCard(activePlayer, card: drawnCard)
        activePlayer.handcards.append(drawnCard)
        
        let cardsToPlay = chooseCards(activePlayer.handcards, mana: activePlayer.mana)
        
        for card in cardsToPlay {
            playCard(card, opponent: opponent)
        }
    }
    
    private func chooseCards(var cards: [Card], mana: Int) -> [Card] {
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
    
    private func playCard(card: Card, opponent: Player) {
        opponent.health -= card.manaCosts
        interface.playedCard(opponent, cardPlayed: card)
    }
    
}
