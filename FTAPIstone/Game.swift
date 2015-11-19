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
    let player1: Player
    let player2: Player
    var activePlayer: Player
    var interface: GameInterface?
    
    var round:Int = 0
    var gameFinished = false
    
    convenience init(interface: GameInterface, player1Name: String, player2Name: String){
        self.init(player1Name: player1Name, player2Name: player2Name);
        self.interface = interface
    }
    
    init(player1Name: String, player2Name: String){
        player1 = Player(name: player1Name)
        player2 = Player(name: player2Name)
        activePlayer = player1
    }
    
    public func getOtherPlayer(player: Player) -> Player {
        return player == player1 ? player2 : player1
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
        var player = activePlayer == player1 ? player2 : player1
        
        defer {
            player.manaslots++
        }
        
        interface?.finishedTurn(activePlayer)
        
        let opponent = getOtherPlayer(activePlayer)
        if opponent.health > 0 {
            activePlayer = opponent
        } else {
            gameFinished = true
            interface?.gameFinished(activePlayer, loser: opponent)
        }
    }
    
    public func playCard(card: Card) throws {
        if !activePlayer.handcards.contains(card) {
            throw GameError.CardNotInHand
        }
        
        let opponent = getOtherPlayer(activePlayer)
        opponent.health -= card.attack
        interface?.playedCard(opponent, cardPlayed: card)
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
