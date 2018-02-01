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
    var nextButton: SKButton2!
    var titleLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        // Creating and adding audio button to view
        setupAudioButton()
        // Creating and adding title label
        setupTitleLabel()
        // Creating and adding next level button
        setupNextLevelButton()
    }
    
    // UI Setup
    
    func setupTitleLabel() {
        // Create title label
        titleLabel = SKLabelNode(text: "The cow 🐮🐄 says ...")
        // Position on screen
        // TODO: do position based on view size
        titleLabel.position = CGPoint(x: 0, y: 170)
        titleLabel.fontSize = 48
        titleLabel.fontName = "Arial-BoldMT"
        // Adding title label to view
        addChild(titleLabel)
    }
    
    func setupAudioButton() {
        // Creates button to play audio
        audioButton = SKButton2(defaultButtonImage: "redButton", activeButtonImage: "redButtonPressed", buttonAction: { [unowned self] in
            let moo = SKAction.playSoundFileNamed("cow_moo.wav", waitForCompletion: true)
            self.nextButton.isHidden = false
            self.run(moo)
        })
        // Position in center of the screen
        audioButton.position = CGPoint(x: 0, y: 0)
        // Add button to view
        addChild(audioButton)
    }
    
    func setupNextLevelButton() {
        nextButton = SKButton2(defaultButtonImage: "nextButton", activeButtonImage: "nextButton", buttonAction: transitionToNextScene)
        nextButton.position = CGPoint(x: 200, y: 0)
        // Setting is hidden to true to hide it until the audio button has been pressed once
        nextButton.isHidden = true
        addChild(nextButton)
    }
    
    // Functionality
    
    func transitionToNextScene() {
        let level2 = AGlevel2(fileNamed: "AGlevel2")
        self.view?.presentScene(level2)
    }
}
