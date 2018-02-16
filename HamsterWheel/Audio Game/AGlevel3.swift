//
//  AGlevel3.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 1/30/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import SpriteKit
import AVFoundation

class AGlevel3: SKScene {
    
    // Game elements
    var audioButton: SKButton2!
    var nextButton: SKButton2!
    var titleLabel: SKLabelNode!
    
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
        
        // Creating and adding audio button to view
        setupAudioButton()
        // Creating and adding title label
        setupTitleLabel()
        // Creating and adding next level button
        setupNextLevelButton()
        
        setupHomeButton()
        setupBackButton()
    }
    
    // MARK: UI Setup
    
    func setupTitleLabel() {
        // Create title label
        titleLabel = SKLabelNode(text: "The sheep 🐑 says ...")
        // Position on screen
        // TODO: do position based on view size
        titleLabel.position = CGPoint(x: 680, y: -200)
        titleLabel.zPosition = 1
        titleLabel.fontSize = 48
        titleLabel.fontName = "Arial-BoldMT"
        // Adding title label to view
        addChild(titleLabel)
    }
    
    func setupAudioButton() {
        // Creates button to play audio
        audioButton = SKButton2(defaultButtonImage: "redSheepButton", activeButtonImage: "redSheepButtonPressed", buttonAction: { [unowned self] in
            self.playAudio(soundName: "sheepBaa", soundExtention: ".wav")
            self.nextButton.isHidden = false
        })
        // Position in center of the screen
        audioButton.position = CGPoint(x: 680, y: -385)
        // Add button to view
        addChild(audioButton)
    }
    
    func setupNextLevelButton() {
        nextButton = SKButton2(defaultButtonImage: "nextButton", activeButtonImage: "nextButton", buttonAction: transitionToNextScene)
        nextButton.position = CGPoint(x: 1200, y: -630)
        // Setting is hidden to true to hide it until the audio button has been pressed once
        nextButton.isHidden = true
        addChild(nextButton)
    }
    
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
    
    func setupBackButton() {
        /* Set UI connections */
        backButton = self.childNode(withName: "backButton") as! SKButton
        
        /* Setup button selection handler for homescreen */
        backButton.selectedHandler = { [unowned self] in
            if let view = self.view {
                self.setEndTimeAndCalculateDifference()
                if let scene = SKScene(fileNamed: "AGlevel2") {
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
    
    // MARK: Functionality
    
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
    
    // Sets the end time and calculates the time spent on the level using the start time
    func setEndTimeAndCalculateDifference() {
        // end time when level is complete
        self.end = DispatchTime.now()
        print(self.end as Any)
        
        // Difference in nano seconds (UInt64) converted to a Double
        let nanoTime = Double((self.end?.uptimeNanoseconds)!) - Double((self.start?.uptimeNanoseconds)!)
        let timeInterval = (nanoTime / 1000000000)
        
        self.totalTime = timeInterval
        print("timeInterval: \(self.totalTime!)") /* <<<<<< save this value to db >>>>>> */
    }
    
    func transitionToNextScene() {
        let level4 = AGlevel4(fileNamed: "AGlevel4")
        level4?.scaleMode = .aspectFill
        self.view?.presentScene(level4)
    }
}
