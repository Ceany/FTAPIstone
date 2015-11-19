//
//  BoardScene.swift
//  FTAPIstone
//
//  Created by Alex Stonehouse on 19.11.15.
//  Copyright © 2015 TiloBox. All rights reserved.
//

import UIKit
import SpriteKit

class BoardScene: SKScene {
    override func didMoveToView(view: SKView) {
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "FTAPIStone 4eva 10/10 -IGN!";
        myLabel.fontSize = 45;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
    }
}
