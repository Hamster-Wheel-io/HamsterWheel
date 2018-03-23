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
                
            default: returnToMainMenu()
            }
        } else {
            returnToMainMenu()
        }
    }
    
    func loadLevel1() {
        if let view = view {
            if let scene = RandomWheel(fileNamed: "RandomWheel") {
                scene.levelSelector = self
                currentLevel = 1 // Just to be sure
                scene.scaleMode = .aspectFit
                view.presentScene(scene)
            }
        }
    }
    
    func loadLevel2() {
        if let view = view {
            if let scene = SpellingLevel(fileNamed: "SpellingLevelScene") {
                scene.levelSelector = self
                currentLevel = 2 // Just in case
                
                // scene setup
                
                scene.scaleMode = .aspectFit
                
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
