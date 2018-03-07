//
//  SetUpLevel.swift
//  HamsterWheel
//
//  Created by Phyllis Wong on 3/1/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import SpriteKit
import AVFoundation

extension DDLevel {

    func loadHomeButton() {
        /* Set UI connections */
        homeButton = self.childNode(withName: "homeButton") as! SKButton
        
        /* Setup button selection handler for homescreen */
        homeButton.selectedHandler = { [unowned self] in
            if let view = self.view {
                
                // FIXME: Load the SKScene from 'MainMenuScene.sks'
                if let scene = SKScene(fileNamed: "MainMenuScene") {
                    
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view.presentScene(scene)
                }
                
                // Debug helpers
//                view.showsPhysics = true
            }
        }
    }
    
    func loadBackButton() {
        
        /* Set UI connections */
        backButton = self.childNode(withName: "backButton") as! SKButton
        
        /* Setup button selection handler for homescreen */
        backButton.selectedHandler = { [unowned self] in
            if let view = self.view {
                
                // FIXME: Load the SKScene from before. Hard Code this until I figure out an algorithm.
                self.transitionToPreviousScene()
                // Debug helpers
//                view.showsPhysics = true
            }
        }
    }
    
    // Setup the peices on the board
    func setupPlayer1(texture: String, position: CGPoint) {
        player1 = Player1(imageNamed: texture)
        player1.size = playerSmall
        player1.position = position
        player1.zPosition = 2
        
        addChild(player1)
    }
    
    func setupMatch1(texture: String, position: CGPoint) {
        match1 = Match1(imageNamed: texture)
        match1.size = CGSize(width: 150, height: 150)
        match1.position = position
        match1.zPosition = 1
        
        addChild(match1)
    }
    
    func setupPlayer2(texture: String, position: CGPoint) {
        player2 = Player2(imageNamed: texture)
        player2.size = playerSmall
        player2.position = position
        player2.zPosition = 2
        
        addChild(player2)
    }
    
    func setupMatch2(texture: String, position: CGPoint) {
        match2 = Match2(imageNamed: texture)
        match2.size = CGSize(width: 150, height: 150)
        match2.position = position
        match2.zPosition = 1
        
        addChild(match2)
    }
    
    func setupWall(texture: String, position: CGPoint) {
        wall = Wall(imageNamed: texture)
        wall.size = CGSize(width: 100, height: 400)
        wall.position = position
        wall.zPosition = 1
        
        addChild(wall)
    }

    // Back button calls this to go back 1 scene
    func transitionToNextScene() {
        if let view = view {
            
            if let selector = levelSelector {
                if selector.currentLevel != nil {
                    selector.currentLevel! += 1
                } else {
                    selector.currentLevel = 1
                }
                view.presentScene(selector)
            }
        }
    }
    
}
