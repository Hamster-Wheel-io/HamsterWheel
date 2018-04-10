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
    
    // MARK: Variables
    // Handels navigation an keeping track on what level we are
    var levelSelector: AudioGameLevelSelector?
    
    /*
     All slices we want to include in the wheel.
     Title is blank because we use images of the animals
     */
    let slices = [ HWheelSlice(title: "", animal: "Cow"),
                   HWheelSlice(title: "", animal: "Dog"),
                   HWheelSlice(title: "", animal: "Cat"),
                   HWheelSlice(title: "", animal: "Pig"),
                   HWheelSlice(title: "", animal: "Sheep"),
                   HWheelSlice(title: "", animal: "Horse")]
    
    // Actual rotating wheel
    var wheel: TTFortuneWheel?
    // Gives the rotating wheel a frame
    var frameImage: UIImageView?
    // Activates the spinning of the wheel
    var spinButton: UIButton?
    
    // AV Audio Player to play the animal sounds
    var audio: AVAudioPlayer?
    
    // Navigation buttons
    var menuButton: SKButton!
    var backButton: SKButton!
    var nextButton: SKButton!
    
    // MARK: Did Move
    override func didMove(to view: SKView) {
        // Adds the TTWheel, the frame image and the spin button
        addWheel(view: view)
        
        setupHomeButton()
        // setupBackButton()
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
                    scene.scaleMode = .aspectFit
                    self.removeWheel()
                    // Present the scene
                    view.presentScene(scene)
                }
            }
        }
    }
    
    // Connect and reposition the next level button
    func setupNextLevelButton() {
        nextButton = self.childNode(withName: "nextButton") as! SKButton
        nextButton.position = positionFromTop(CGPoint(x: 75.0, y: 175.0))
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
    
    // Plays a sound based on a given index relating to the slices array
    func playSoundForIndex(index: Int) {
        var sound = String()
        var extention = String()
        if let animal = self.slices[index].animal {
            switch animal {
            case "Dog":     sound = "dogBark";          extention = ".mp3"
            case "Cow":     sound = "cowMoo";           extention = ".mp3"
            case "Cat":     sound = "catMeow";          extention = ".mp3"
            case "Pig":     sound = "pigOink";          extention = ".mp3"
            case "Sheep":   sound = "sheepBaa";         extention = ".wav"
            case "Horse":   sound = "horseWhinnying";   extention = ".mp3"
            default:        sound = "dogBark"; extention = ".mp3"
            }
            // Re-enable the spin button (is disabled when pressed)
            self.spinButton?.isEnabled = true
            self.playAudio(soundName: sound, soundExtention: extention)
        }
    }
    
    func playAudio(soundName: String, soundExtention: String) {
        // Fetch the sound data set.
        if let asset = NSDataAsset(name: soundName) {
            do {
                // Use NSDataAssets's data property to access the audio file
                audio = try AVAudioPlayer(data: asset.data, fileTypeHint: soundExtention)
                // Play the above sound file
                audio?.play()
            } catch let error as NSError {
                // Should print...
                print(error.localizedDescription)
            }
        }
    }
    
    // Increments the current level and presents the next one if it is available.
    func transitionToNextScene() {
        if let view = view {
            // Check if there is a levelSelector
            if let selector = levelSelector {
                // Safety if there would be a problem with the level counter we return to level 1
                if selector.currentLevel != nil {
                    selector.currentLevel! += 1
                } else {
                    selector.currentLevel = 1
                }
                
                // Remove the random wheel, because wheel is a subclass of UIView its not removed when changing scenes.
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

