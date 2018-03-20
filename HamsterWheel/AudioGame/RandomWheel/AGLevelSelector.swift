//
//  AGLevelSelector.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 3/1/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import SpriteKit

class AudioGameLevelSelector: SKScene {
    
    var currentLevel: Int?
    
    override func didMove(to view: SKView) {
        // Check to see what level is next
        if let level = currentLevel {
            switch level {
            case 1: loadLevel1()
            case 2: loadLevel2()
            case 3: loadLevel3()
            case 4: loadLevel4()
            case 5: loadLevel5()
            case 6: loadLevel6()
            case 7: loadLevel7()
                
            default: returnToMainMenu()
            }
        } else {
            returnToMainMenu()
        }
    }
    
    func loadLevel1() {
        if let view = view {
            if let scene = SingleButtonAudioLevel(fileNamed: "AGButtonLevel") {
                
                scene.levelSelector = self
                currentLevel = 1 // Just to be sure
                // Level 1 variables
                scene.animal = "Cow"
                scene.defaultButtonImage = "cowButton"
                scene.pressedButtonImage = "cowButtonPressed"
                scene.audioFileName = "cowMoo"
                scene.audioFileExtension = ".mp3"
                scene.hasSpelling = false
                
                // Sets scale mode
                scene.scaleMode = .aspectFit
                
                // Present the scene
                view.presentScene(scene)
            }
        }
    }
    
    func loadLevel2() {
        if let view = view {
            if let scene = SingleButtonAudioLevel(fileNamed: "AGButtonLevel") {
                
                scene.levelSelector = self
                currentLevel = 2 // Just to be sure
                
                // Level 2 variables
                scene.animal = "Dog"
                scene.defaultButtonImage = "dogButton"
                scene.pressedButtonImage = "dogButtonPressed"
                scene.audioFileName = "dogBark"
                scene.audioFileExtension = ".wav"
                scene.hasSpelling = false
                
                // Sets scale mode
                scene.scaleMode = .aspectFit
                
                // Present the scene
                view.presentScene(scene)
            }
        }
    }
    
    func loadLevel3() {
        if let view = view {
            if let scene = SingleButtonAudioLevel(fileNamed: "AGButtonLevel") {
                
                scene.levelSelector = self
                currentLevel = 3 // Just to be sure
                
                // Level 3 variables
                scene.animal = "Sheep"
                scene.defaultButtonImage = "sheepButton"
                scene.pressedButtonImage = "sheepButtonPressed"
                scene.audioFileName = "sheepBaa"
                scene.audioFileExtension = ".wav"
                scene.hasSpelling = false
                
                // Sets scale mode
                scene.scaleMode = .aspectFit
                
                // Present the scene
                view.presentScene(scene)
            }
        }
    }
    
    func loadLevel4() {
        if let view = view {
            if let scene = RandomWheel(fileNamed: "RandomWheel") {
                scene.levelSelector = self
                currentLevel = 4 // Just to be sure
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
        }
    }
    
    func loadLevel5() {
        if let view = view {
            if let scene = SingleButtonAudioLevel(fileNamed: "AGButtonLevel") {
                
                scene.levelSelector = self
                currentLevel = 5 // Just to be sure
                
                scene.animal = "Cow"
                scene.defaultButtonImage = "cowButton"
                scene.pressedButtonImage = "cowButtonPressed"
                scene.audioFileName = "cowMoo"
                scene.audioFileExtension = ".mp3"
                scene.hasSpelling = true
                
                // Sets scale mode
                scene.scaleMode = .aspectFit
                
                // Present the scene
                view.presentScene(scene)
            }
        }
    }
    
    func loadLevel6() {
        if let view = view {
            if let scene = SingleButtonAudioLevel(fileNamed: "AGButtonLevel") {
                
                scene.levelSelector = self
                currentLevel = 6 // Just to be sure
                
                scene.animal = "Dog"
                scene.defaultButtonImage = "dogButton"
                scene.pressedButtonImage = "dogButtonPressed"
                scene.audioFileName = "dogBark"
                scene.audioFileExtension = ".wav"
                scene.hasSpelling = true
                
                // Sets scale mode
                scene.scaleMode = .aspectFit
                
                // Present the scene
                view.presentScene(scene)
            }
        }
    }
    
    func loadLevel7() {
        if let view = view {
            if let scene = SingleButtonAudioLevel(fileNamed: "AGButtonLevel") {
                
                scene.levelSelector = self
                currentLevel = 7 // Just to be sure
                
                scene.animal = "Cat"
                scene.defaultButtonImage = "catButton"
                scene.pressedButtonImage = "catButtonPressed"
                scene.audioFileName = "catMeow"
                scene.audioFileExtension = ".wav"
                scene.hasSpelling = true
                
                // Sets scale mode
                scene.scaleMode = .aspectFit
                
                // Present the scene
                view.presentScene(scene)
            }
        }
    }
    
    func returnToMainMenu() {
        if let view = view {
            if let scene = SKScene(fileNamed: "MainMenuScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                // Present the scene
                view.presentScene(scene)
            }
        }
    }
}
