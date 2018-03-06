//
//  Actions.swift
//  HamsterWheel
//
//  Created by Phyllis Wong on 3/1/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class DDLevelSelector: SKScene {
    
    var currentLevel: Int?
    var lastLevel = 5
    
    var homeButton: SKButton!
    var backButton: SKButton!
    
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
                
            default: loadLevel1()
            }
        } else {
            currentLevel = 1
            loadLevel1()
        }
    }
    
    func loadLevel1() {
        if let view = view {
            if let scene = DDLevel(fileNamed: "DDLevelOne") {
                
                scene.levelSelector = self
                currentLevel = 1
                // Level 1 variables
                var audio: AVAudioPlayer?
                var soundEffect: AVAudioPlayer?
                
                var player: SKSpriteNode!
                var matchShape: SKSpriteNode!
                
                
                
                var isDragging = false

                var levelSelector: DDLevelSelector?
                loadHomeButton()
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
            }
        }
    }
    
    func loadLevel2() {
        if let view = view {
            if let scene = DDLevel(fileNamed: "DDLevelTwo") {
                
                scene.levelSelector = self
                currentLevel = 2
                
                // Level 2 variables
                
                var start: DispatchTime?
                var end: DispatchTime?
                var totalTime: Double?
                
                
                var audio: AVAudioPlayer?
                var soundEffect: AVAudioPlayer?
                var player: SKSpriteNode!
                var matchShape: SKSpriteNode!
                
                var homeButton: SKButton!
                var backButton: SKButton!
                
                var isDragging = false
                
                // Sets scale mode
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
        }
    }
    
    func loadLevel3() {
        if let view = view {
            if let scene = DDLevel(fileNamed: "DDLevelThree") {
                
                scene.levelSelector = self
                currentLevel = 3
                
                // Level 1 variables

                
                // Sets scale mode
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
        }
    }
    
    func loadLevel4() {
        if let view = view {
            if let scene = DDLevel(fileNamed: "DDLevelFour") {
                scene.levelSelector = self
                currentLevel = 3
                
                // Level 1 variables
                
                
                // Sets scale mode
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
        }
    }
    
    func loadLevel5() {
        if let view = view {
            if let scene = DDLevel(fileNamed: "DDLevelFive") {
                scene.levelSelector = self
                currentLevel = 3
                
                // Level 1 variables
                
                
                // Sets scale mode
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
        }
    }
    func loadLevel6() {
        if let view = view {
            if let scene = DDLevel(fileNamed: "DDLevelSix") {
                scene.levelSelector = self
                currentLevel = 3
                
                // Level 1 variables
                
                
                // Sets scale mode
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
        }
    }
    func loadLevel7() {
        if let view = view {
            if let scene = DDLevel(fileNamed: "DDLevelSeven") {
                scene.levelSelector = self
                currentLevel = 3
                
                // Level 1 variables
                
                
                // Sets scale mode
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
        }
    }
    
}
