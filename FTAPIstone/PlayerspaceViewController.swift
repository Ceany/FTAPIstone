//
//  PlayerspaceViewController.swift
//  FTAPIstone
//
//  Created by Maximilian Meier on 28/10/15.
//  Copyright © 2015 TiloBox. All rights reserved.
//

import UIKit

public protocol PlayerspaceDataProvider {
    func requestForData(playerspaceVC: PlayerspaceViewController)
}

public class PlayerspaceViewController: UIViewController {
    
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerHealth: UILabel!
    @IBOutlet weak var playerCards: UITextView!
    var player: Player?
    var dataProvider: PlayerspaceDataProvider?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        dataProvider?.requestForData(self)
    }
    
    func updatePlayer() {
        playerName.text = player?.name
        playerHealth.text = String(player?.health)
        var cards = "";
        player?.handcards.map({ (card: Card) in
            cards += "\(card.description), "
        })
        playerCards.text = cards
    }
}