//
//  GameViewController.swift
//  FTAPIstone
//
//  Created by Maximilian Meier on 28/10/15.
//  Copyright © 2015 TiloBox. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, PlayerspaceDataProvider {
    @IBOutlet weak var roundLabel: UILabel!
    var playerSpace1Initialized = false
    var playerSpace1: PlayerspaceViewController?
    var playerSpace2: PlayerspaceViewController?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundLabel.text = "Round: 2"
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
            setupPlayerSpaces()
        }
    }

    
    func setupPlayerSpaces() {
        playerSpace1?.setUpLabels("Maxi")
        playerSpace2?.setUpLabels("Alex")
    }
    
}
