//
//  SetUpLevel.swift
//  HamsterWheel
//
//  Created by Phyllis Wong on 3/1/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import SpriteKit
import AVFoundation
import AudioToolbox

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
                    view.presentScene(scene)
                }
                // Debug helpers
                // view.showsPhysics = true
            }
        }
    }
    
    func loadBackButton() {
        
        /* Set UI connections */
        backButton = self.childNode(withName: "backButton") as! SKButton
        
        /* Setup button selection handler for homescreen */
        backButton.selectedHandler = { [unowned self] in
            if self.view != nil {
                
                self.transitionToPreviousScene()
                // Debug helpers
                // view.showsPhysics = true
            }
        }
    }
    
    func setupTextures() {
        // Set the textures of the player(s) and match(es)
        if let texture = player1Texture, let position = player1Position {
            setupPlayer1(texture: texture, position: position)
        }
        if let texture = player2Texture, let position = player2Position {
            setupPlayer2(texture: texture, position: position)
        }
        if let texture = match1Texture, let position = match1Position {
            setupMatch1(texture: texture, position: position)
        }
        if let texture = match2Texture, let position = match2Position {
            setupMatch2(texture: texture, position: position)
        }
        if let texture = wallTexture, let position = wallPosition {
            setupWall(texture: texture, position: position)
        }
    }
    
    func setupCollisions(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == PhysicsCategory.Wall | PhysicsCategory.Player1 | PhysicsCategory.Player2 {
        } else if collision == PhysicsCategory.Match1 | PhysicsCategory.Player1 {
            player1Success = true
        } else if collision == PhysicsCategory.Match2 | PhysicsCategory.Player2 {
            player2Success = true
        } else if collision == PhysicsCategory.Match1 | PhysicsCategory.Player2 {
            // play uh-oh sound and vibrate the phone
            playUhOhSound()
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        } else if collision == PhysicsCategory.Match2 | PhysicsCategory.Player1 {
            // play uh-oh sound and vibrate the phone
            playUhOhSound()
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))  
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

    // Success calls this to go forward one scene
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
    
    // Back button calls this to go back one scene
    func transitionToPreviousScene() {
        if let view = view {
            
            if let selector = levelSelector {
                if selector.currentLevel != nil {
                    selector.currentLevel! -= 1
                } else {
                    selector.currentLevel = 1
                }
                view.presentScene(selector)
            }
        }
    }
    
}
