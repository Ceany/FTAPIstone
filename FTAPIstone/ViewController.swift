//
//  ViewController.swift
//  FTAPIstone
//
//  Created by Maximilian Meier on 17/09/15.
//  Copyright © 2015 TiloBox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startButton.layer.cornerRadius = 5.0;
    }
    
    override func viewDidAppear(animated: Bool) {
        self.performSegueWithIdentifier("game", sender: self)
    }


    @IBAction private func tappedStartButton(sender: AnyObject) {

    }
}

