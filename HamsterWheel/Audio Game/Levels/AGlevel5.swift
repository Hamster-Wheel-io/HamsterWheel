//
//  AGlevel3.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 1/30/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import SpriteKit
import AVFoundation

class AGlevel5: SKScene {
    
    // Game elements
    var audioButton: SKButton2!
    var nextButton: SKButton!
    var titleLabel: SKLabelNode!
    var grayOutView: SKNode!
    var spellLabel: SKLabelNode!
    
    // Navigation buttons
    var menuButton: SKButton!
    var backButton: SKButton!
    
    // Players and Trackers
    var audio: AVAudioPlayer?
    var start: DispatchTime?
    var end: DispatchTime?
    var totalTime: Double?
    
    override func didMove(to view: SKView) {
        
        // Start time in level
        self.start = DispatchTime.now()
        
        // Sets up all UI elements in this level
        setup()
    }
    
    // MARK: Scene Connections
    // Main
    
    func setup() {
        // Creating and adding audio button to view
        setupAudioButton()
        
        // Creating and adding title label
        setupTitleLabel()
        
        // Connecting the navigation buttons to variables
        connectNextLevelButton()
        setupHomeButton()
        setupBackButton()
        
        // Connect elements for word spelling and hide them
        setupGrayOutView()
        setupSpellLabel()
    }
    
    // Creates and adds the title label
    func setupTitleLabel() {
        // Create title label
        titleLabel = SKLabelNode(text: "The cow says ...")
        // Position on screen
        // TODO: do position based on view size
        titleLabel.position = CGPoint(x: 680, y: -200)
        titleLabel.zPosition = 1
        titleLabel.fontSize = 48
        titleLabel.fontName = "Arial-BoldMT"
        // Adding title label to view
        addChild(titleLabel)
    }
    
    // Creates and adds the aufio button with the correct images and action
    func setupAudioButton() {
        // Creates button to play audio
        audioButton = SKButton2(defaultButtonImage: "redCowButton", activeButtonImage: "redCowButtonPressed", buttonAction: { [unowned self] in
            self.audioButtonPressed()
        })
        // Position in center of the screen
        audioButton.position = CGPoint(x: 680, y: -385)
        // Add button to view
        addChild(audioButton)
    }
    
    // Navigation
    // Connects the skscene button to code
    func connectNextLevelButton() {
        nextButton = self.childNode(withName: "nextButton") as! SKButton
        // nextButton.selectedHandler = transitionToNextScene
        nextButton.isHidden = true
    }
    
    // Connects the skscene button to code
    func setupHomeButton() {
        /* Set UI connections */
        menuButton = self.childNode(withName: "menuButton") as! SKButton
        
        /* Setup button selection handler for homescreen */
        menuButton.selectedHandler = { [unowned self] in
            if let view = self.view {
                self.setEndTimeAndCalculateDifference()
                if let scene = SKScene(fileNamed: "MainMenuScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    // Present the scene
                    view.presentScene(scene)
                }
                
                // Debug helpers
                view.showsFPS = true
                view.showsPhysics = true
                view.showsDrawCount = true
            }
        }
    }
    
    // Connects the skscene button to code
    func setupBackButton() {
        /* Set UI connections */
        backButton = self.childNode(withName: "backButton") as! SKButton
        
        /* Setup button selection handler for homescreen */
        backButton.selectedHandler = { [unowned self] in
            if let view = self.view {
                self.setEndTimeAndCalculateDifference()
                if let scene = SKScene(fileNamed: "AGlevel4") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    // Present the scene
                    view.presentScene(scene)
                }
                
                // Debug helpers
                view.showsFPS = true
                view.showsPhysics = true
                view.showsDrawCount = true
            }
        }
    }
    
    // Word Spelling
    
    // Connects the skscene label to spellLabel variable
    func setupSpellLabel() {
        spellLabel = self.childNode(withName: "spellLabel") as? SKLabelNode
        spellLabel.isHidden = true
        spellLabel.text = ""
    }
    
    // Connects the skscene gray view to the grayOutView variable
    func setupGrayOutView() {
        grayOutView = self.childNode(withName: "grayOutView")
        grayOutView?.isHidden = true
    }
    
    // MARK: Functionality
    
    // Audio
    // Actions to make when the audio button is pressed
    func audioButtonPressed() {
        playAudio(soundName: "cowMoo", soundExtention: ".mp3")
        nextButton.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.spellWord(word: "COW")
        }
    }
    
    // Plays the selected sound
    func playAudio(soundName: String, soundExtention: String) {
        // Fetch the sound data set.
        if let asset = NSDataAsset(name: soundName) {
            do {
                // Use NSDataAssets's data property to access the audio file stored in cartoon voice says yahoo.
                audio = try AVAudioPlayer(data: asset.data, fileTypeHint: soundExtention)
                // Play the above sound file
                audio?.play()
            } catch let error as NSError {
                // Should print...
                print(error.localizedDescription)
            }
        }
    }
    
    // Word Spelling
    func spellWord(word: String) {
        grayOutView.isHidden = false
        spellLabel.isHidden = false
        
        for i in 0..<word.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(i * 1), execute: {
                let index = word.index(word.startIndex, offsetBy: i)
                self.spellLabel.text?.append(word[index])
                if index.encodedOffset == word.endIndex.encodedOffset - 1 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(i * 1), execute: {
                        self.spellingDone()
                    })
                }
            })
        }
    }
    
    func spellingDone() {
        spellLabel.isHidden = true
        spellLabel.text = ""
        grayOutView.isHidden = true
    }
    
    // Time Tracking
    
    // Sets the end time and calculates the time spent on the level using the start time
    func setEndTimeAndCalculateDifference() {
        // end time when level is complete
        self.end = DispatchTime.now()
        
        // Difference in nano seconds (UInt64) converted to a Double
        let nanoTime = Double((self.end?.uptimeNanoseconds)!) - Double((self.start?.uptimeNanoseconds)!)
        let timeInterval = (nanoTime / 1000000000)
        
        self.totalTime = timeInterval
    }
    // General
    
    //    func transitionToNextScene() {
    //        let level4 = AGlevel4(fileNamed: "AGlevel4")
    //        level4?.scaleMode = .aspectFill
    //        self.view?.presentScene(level4)
    //    }
}

