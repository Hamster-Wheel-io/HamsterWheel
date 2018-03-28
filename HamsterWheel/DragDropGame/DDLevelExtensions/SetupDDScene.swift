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

    func setupTextures() {
        // Set the textures of the shape(s) and match(es)
        if let texture = shape1Texture, let position = shape1Position {
            setupShape1(texture: texture, position: position)
        }
        if let texture = shape2Texture, let position = shape2Position {
            setupShape2(texture: texture, position: position)
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
        
        if collision == PhysicsCategory.Wall | PhysicsCategory.Shape1 | PhysicsCategory.Shape2 {
        } else if collision == PhysicsCategory.Match1 | PhysicsCategory.Shape1 {
        } else if collision == PhysicsCategory.Match2 | PhysicsCategory.Shape2 {
        } else if collision == PhysicsCategory.Match1 | PhysicsCategory.Shape2 {
            playUhOhSound()
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        } else if collision == PhysicsCategory.Match2 | PhysicsCategory.Shape1 {
            // play uh-oh sound and vibrate the phone
            playUhOhSound()
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))  
        }
    }
    
    // Setup the peices on the board
    func setupShape1(texture: String, position: CGPoint) {
        shape1 = Shape1(imageNamed: texture)
        shape1.size = shapeSmall
        shape1.position = position
        shape1.zPosition = 2
        
        addChild(shape1)
    }
    
    func setupMatch1(texture: String, position: CGPoint) {
        match1 = Match1(imageNamed: texture)
        match1.size = CGSize(width: 150, height: 150)
        match1.position = position
        match1.zPosition = 1
        
        addChild(match1)
    }
    
    func setupShape2(texture: String, position: CGPoint) {
        shape2 = Shape2(imageNamed: texture)
        shape2?.size = shapeSmall
        shape2?.position = position
        shape2?.zPosition = 2
        
        addChild(shape2!)
    }
    
    func setupMatch2(texture: String, position: CGPoint) {
        match2 = Match2(imageNamed: texture)
        match2?.size = CGSize(width: 150, height: 150)
        match2?.position = position
        match2?.zPosition = 1
        
        addChild(match2!)
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
