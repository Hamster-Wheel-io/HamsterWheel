//
//  AGlevel1.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 1/30/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import SpriteKit
import AVFoundation

class AGlevel1: SKScene {
    var playingSound: Bool = false
    var audioButton: SKButton2!
    var titleLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        // Creating and adding audio button to view
        audioButton = SKButton2(defaultButtonImage: "redButton", activeButtonImage: "redButtonPressed", buttonAction: playCowSound)
        audioButton.position = CGPoint(x: 0, y: 0)
        addChild(audioButton)
        
        // Creating and adding title label
        titleLabel = SKLabelNode(text: "The cow 🐮🐄 says ...")
        titleLabel.position = CGPoint(x: 0, y: 150)
        addChild(titleLabel)
    }
    
    func playCowSound() {
        audioButton.action = { [unowned self] in
            let moo = SKAction.playSoundFileNamed("cow_moo.wav", waitForCompletion: false)
            self.run(moo)
        }
    }
}
