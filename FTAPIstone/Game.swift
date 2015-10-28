//
//  Game.swift
//  FTAPIstone
//
//  Created by Maximilian Meier on 17/09/15.
//  Copyright © 2015 TiloBox. All rights reserved.
//

import Foundation


class Game {
    var player1 = Player(name: "Alex")
    var player2 = Player(name: "Maxi")
    var round:Int = 1
    
    init(){
        playGame()
    }
    
    func playGame() {
        repeat {
            print("--------Round: \(round)--------")
            round++
            playRound(&player1, opponent: &player2)
            if(player2.health>0){
                playRound(&player2, opponent: &player1)
            }
            print("Health of \(player1.name): \(player1.health)")
            print("Health of \(player2.name): \(player2.health)")
            print("--------END OF ROUND--------")
            //sleep(2)
        } while(player1.health>0 && player2.health>0)
        
        if(player1.health<1){
            print("\(player2.name) wins")
        } else {
            print("\(player1.name) wins")
        }

    }
    
    func playRound(inout activePlayer:Player, inout opponent: Player){
        activePlayer.mana = activePlayer.manaslots
        defer {
            activePlayer.manaslots++
        }
        
        activePlayer.handcards.append(activePlayer.deck.drawCard())
        
        let cardsToPlay = chooseCards(activePlayer.handcards, mana: activePlayer.mana)
        
        for card in cardsToPlay {
            playCard(card, opponent: &opponent)
        }
    }
    
    func chooseCards(var cards: [Card], mana: Int) -> [Card] {
        var manaLeft = mana;
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
    
    func playCard(card: Card, inout opponent: Player) {
        opponent.health -= card.manaCosts
        print("\(opponent.name) got damaged for \(card.manaCosts).")
    }
    
}
