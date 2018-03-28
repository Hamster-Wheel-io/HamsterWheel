//
//  AGlevel2.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 2/1/18.
//  Copyright © 2018 HamsterWheel. All rights reserved.
//
import SpriteKit
import TTFortuneWheel
import AVFoundation

class RandomWheel: SKScene {
    
    var levelSelector: AudioGameLevelSelector?
    
    let slices = [ HWheelSlice(title: "", animal: "Cow"),
                   HWheelSlice(title: "", animal: "Dog"),
                   HWheelSlice(title: "", animal: "Cat"),
                   HWheelSlice(title: "", animal: "Pig"),
                   HWheelSlice(title: "", animal: "Sheep"),
                   HWheelSlice(title: "", animal: "Horse")]
    
    var wheel: TTFortuneWheel?
    var frameImage: UIImageView?
    var spinButtonImage: UIImageView?
    var spinButton: UIButton?
    
    var audio: AVAudioPlayer?
    
    var menuButton: SKButton!
    var backButton: SKButton!
    var nextButton: SKButton!
    
    override func didMove(to view: SKView) {
        // Adds the TTWheel, the frame image and the spin button
        addWheel(view: view)
        
        setupHomeButton()
        setupBackButton()
        setupNextLevelButton()
        
        // Fixes letter boxing on iPad
        sceneDidLayoutSubviews()
        // Avoids letter boxing on iPhoneX
        iPhoneXLetterBoxing()
    }
    
    // MARK: UI setup
    
    func setupHomeButton() {
        /* Set UI connections */
        menuButton = self.childNode(withName: "menuButton") as! SKButton
        menuButton.position = positionFromTop(CGPoint(x: 75.0, y: 75.0))
        /* Setup button selection handler for homescreen */
        menuButton.selectedHandler = { [unowned self] in
            if let view = self.view {
                
                if let scene = SKScene(fileNamed: "MainMenuScene") {
                    
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    self.removeWheel()
                    // Present the scene
                    view.presentScene(scene)
                }
                
                // Debug helpers
                view.showsFPS = true
                // view.showsPhysics = true
                view.showsDrawCount = true
            }
        }
    }
    
    func setupBackButton() {
        /* Set UI connections */
        backButton = self.childNode(withName: "backButton") as! SKButton
        backButton.position = positionFromTop(CGPoint(x: 75.0, y: 175.0))
        
        /* Setup button selection handler for homescreen */
        backButton.selectedHandler = { [unowned self] in
            if let view = self.view {
                if let selector = self.levelSelector {
                    if selector.currentLevel != nil {
                        selector.currentLevel! -= 1
                    } else {
                        selector.currentLevel = 1
                    }
                    self.removeWheel()
                    view.presentScene(selector)
                }
            }
        }
    }
    
    func setupNextLevelButton() {
        nextButton = self.childNode(withName: "nextButton") as! SKButton
        nextButton.position = positionFromTop(CGPoint(x: 75.0, y: 275.0))
        nextButton.selectedHandler = transitionToNextScene
    }
    
    // MARK: Functionality
    
    // Start the wheel spinning
    @objc func spinWheel() {
        if let wheel = wheel {
            wheel.startAnimating()
            self.spinButton?.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                let index = self.randomIndex()
                self.wheel?.startAnimating(fininshIndex: index) { (finished) in
                    self.playSoundForIndex(index: index)
                }
            }
        }
    }
    
    // Play sound
    func playSoundForIndex(index: Int) {
        var sound = String()
        var extention = String()
        if let animal = self.slices[index].animal {
            switch animal {
            case "Dog":     sound = "dogBark";          extention = ".wav"
            case "Cow":     sound = "cowMoo";           extention = ".mp3"
            case "Cat":     sound = "catMeow";          extention = ".wav"
            case "Pig":     sound = "duckQuacking";     extention = ".wav"
            case "Sheep":   sound = "sheepBaa";         extention = ".wav"
            case "Horse":   sound = "horseWhinnying";   extention = ".wav"
            default:        sound  = "cartoon_voice_says_yahoo"; extention = ".mp3"
            }
            self.spinButton?.isEnabled = true
            self.playAudio(soundName: sound, soundExtention: extention)
        }
    }
    
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
    
    func transitionToNextScene() {
        if let view = view {
            if let selector = levelSelector {
                if selector.currentLevel != nil {
                    selector.currentLevel! += 1
                } else {
                    selector.currentLevel = 1
                }
                
                removeWheel()
                view.presentScene(selector)
            }
        }
    }
    
    // Generates a random index based on the length of the slices array
    func randomIndex() -> Int {
        let max = slices.count
        let index = Int(arc4random_uniform(UInt32(max)))
        return index
    }
}

