//
//  SignleButtonAudioLevel.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 3/1/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class SingleButtonAudioLevel: SKScene {
    // Game elements
    // Audio
    var audioButton: SKButton2!
    var titleLabel: SKLabelNode!
    
    // Spelling
    var hasSpelling: Bool?
    var grayOutView: SKNode!
    var spellLabel: SKLabelNode!
    
    // Navigation buttons
    var menuButton: SKButton!
    var nextButton: SKButton!
    var backButton: SKButton!
    
    // Players and Trackers
    var audio: AVAudioPlayer?
    var start: DispatchTime?
    var end: DispatchTime?
    var totalTime: Double?
    
    // Level variables
    
    var levelSelector: AudioGameLevelSelector?
    var nextLevel: String?
    var pastLevel: String?
    
    var pressedButtonImage: String?
    var defaultButtonImage: String?
    
    var audioFileName: String?
    var audioFileExtension: String?
    
    var animal: String?
    
    override func didMove(to view: SKView) {
        // Start time tracking in level
        self.start = DispatchTime.now()
        
        // Creating and adding audio button to view
        // AGAudioExtension.swift
        setupAudioButton()
        
        // Creating and adding title label
        setupTitleLabel()
        
        // Connecting the navigation buttons to variables
        // AGNavigationExtension.swift
        connectNextLevelButton()
        setupHomeButton()
        setupBackButton()
        
        // Connect elements for word spelling and hide them
        // AGSpellingExtension.swift
        setupGrayOutView()
        setupSpellLabel()
    }
    
    // Setup title label and add it to the scene
    func setupTitleLabel() {
        // Create title label
        titleLabel = SKLabelNode(text: "The \(animal ?? "cow") says ...")
        // Position on screen
        // TODO: do position based on view size
        titleLabel.position = CGPoint(x: 680, y: -200)
        titleLabel.zPosition = 1
        titleLabel.fontSize = 48
        titleLabel.fontName = "Arial-BoldMT"
        // Adding title label to view
        addChild(titleLabel)
    }
}
