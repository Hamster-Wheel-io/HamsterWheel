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
                scene.has2Players = false
                scene.loadHomeButton()
                
                // Level 1 variables
                scene.player1Texture = "squareRed"
                scene.match1Texture = "squareRedMatch"
                scene.player1Position = CGPoint(x: 1125, y: 525)
                scene.match1Position = CGPoint(x: 235, y: 207)
                
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
                view.showsPhysics = true
            }
        }
    }
    
    func loadLevel2() {
        if let view = view {
            if let scene = DDLevel(fileNamed: "DDLevelTwo") {
                
                scene.levelSelector = self
                currentLevel = 2
                scene.has2Players = false
                scene.loadHomeButton()
                scene.loadBackButton()
                
                // Level 2 variables
                scene.player1Texture = "circleBlu"
                scene.match1Texture = "circleBluMatch"
                scene.player1Position = CGPoint(x: 260, y: 550)
                scene.match1Position = CGPoint(x: 1150, y: 160)
                
                // Sets scale mode
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
                view.showsPhysics = true
            }
        }
    }
    
    func loadLevel3() {
        if let view = view {
            if let scene = DDLevel(fileNamed: "DDLevelThree") {
                
                scene.levelSelector = self
                currentLevel = 3
                scene.has2Players = false
                scene.loadHomeButton()
                scene.loadBackButton()
                
                // Level 3 variables
                scene.player1Texture = "triangleYel"
                scene.match1Texture = "triangleYelMatch"
                scene.player1Position = CGPoint(x: 1210, y: 375)
                scene.match1Position = CGPoint(x: 321, y: 142)
                
                // Sets scale mode
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
                view.showsPhysics = true
            }
        }
    }
    
    func loadLevel4() {
        if let view = view {
            if let scene = DDLevel(fileNamed: "DDLevelFour") {
                scene.levelSelector = self
                currentLevel = 4
                scene.has2Players = true
                scene.loadHomeButton()
                scene.loadBackButton()
                
                // Level 4 variables
                scene.player1Texture = "squareRed"
                scene.match1Texture = "squareRedMatch"
                scene.match2Texture = "triangleBluMatch"
                scene.player1Position = CGPoint(x: 223, y: 115)
                scene.match1Position = CGPoint(x: 1084, y: 570)
                scene.match2Position = CGPoint(x: 462, y: 502)
                
                
                // Sets scale mode
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
                view.presentScene(scene)
            }
        }
    }
    
    func loadLevel5() {
        if let view = view {
            if let scene = DDLevel(fileNamed: "DDLevelFive") {
                scene.levelSelector = self
                currentLevel = 5
                scene.has2Players = true
                
                // Level 5 variables
                scene.player1Texture = "circleYel"
                scene.player2Texture = "squareBlu"
                scene.match1Texture = "circleYelMatch"
                scene.match2Texture = "squareBluMatch"
                scene.player1Position = CGPoint(x: 960, y: 170)
                scene.player2Position = CGPoint(x: 1115, y: 475)
                scene.match1Position = CGPoint(x: 475, y: 590)
                scene.match2Position = CGPoint(x: 224, y: 200)
                
                // Sets scale mode
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
                view.presentScene(scene)
            }
        }
    }
    func loadLevel6() {
        if let view = view {
            if let scene = DDLevel(fileNamed: "DDLevelSix") {
                scene.levelSelector = self
                currentLevel = 6
                scene.has2Players = true
                
                // Level 6 variables
                scene.player1Texture = "triangleRed"
                scene.player2Texture = "squareYel"
                scene.match1Texture = "triangleRedMatch"
                scene.match2Texture = "squareYelMatch"
                scene.player1Position = CGPoint(x: 100, y: 452)
                scene.player2Position = CGPoint(x: 1208, y: 636)
                scene.match1Position = CGPoint(x: 1056, y: 498)
                scene.match2Position = CGPoint(x: 260, y: 253)
                
                // Sets scale mode
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
                view.presentScene(scene)
            }
        }
    }
    func loadLevel7() {
        if let view = view {
            if let scene = DDLevel(fileNamed: "DDLevelSeven") {
                scene.levelSelector = self
                currentLevel = 7
                scene.has2Players = true
                
                // Level 7 variables
                scene.player1Texture = "circleRed"
                scene.player2Texture = "circleBlu"
                scene.match1Texture = "circleRedMatch"
                scene.match2Texture = "circleBluMatch"
                scene.player1Position = CGPoint(x: -458, y: 162)
                scene.player2Position = CGPoint(x: -370, y: -60)
                scene.match1Position = CGPoint(x: -184, y: -186)
                scene.match2Position = CGPoint(x: 498, y: 153)
                
                // Sets scale mode
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
                view.presentScene(scene)
   
            }
        }
    }
    
}
