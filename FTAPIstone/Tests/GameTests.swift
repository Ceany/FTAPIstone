//
//  GameTests.swift
//  FTAPIstone
//
//  Created by Alex Stonehouse on 28/10/15.
//  Copyright © 2015 TiloBox. All rights reserved.
//

import XCTest
@testable import FTAPIstone

class GameTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let interface = InterfaceTest()
        let game = Game(interface: interface, player1Name: "Player1", player2Name: "Player2")
        do {
          try game.playAutomatically(0)
        } catch {
            XCTFail()
        }
        XCTAssertTrue(game.round > 1)
        XCTAssertTrue(game.gameFinished)
        XCTAssertTrue(interface.playerLost!.health <= 0)
        XCTAssertTrue(interface.playerWon!.health > 0)
    }
    
    
}

class InterfaceTest: GameInterface {
    var playerWon: Player?
    var playerLost: Player?
    
    init() {
        
    }
    
    func startedTurn(player: Player) {
        print("Starting Turn: \(player.name) has \(player.handcards.count) cards")
    }
    func finishedTurn(player: Player) {
        print("Finished Turn: \(player.name) with health \(player.health) and has \(player.handcards.count) cards")
    }
    
    func drawnCard(player: Player, card: Card) {
        print("Drew Card: \(card.manaCosts) (\(player.name))")
    }
    func playedCard(opponent: Player, cardPlayed: Card) {
        print("Played Card: \(cardPlayed.attack)  against (\(opponent.name))")
    }
    
    func gameFinished(winner: Player, loser: Player) {
        print("Game Finished: \(winner.name) won and \(loser.name) lost")
        playerWon = winner
        playerLost = loser
    }
}
