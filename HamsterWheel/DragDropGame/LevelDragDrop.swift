//
//  DDLevelSeven.swift
//  HamsterWheel
//
//  Created by Phyllis Wong on 2/26/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import SpriteKit
import AVFoundation

class DDLevel: SKScene, SKPhysicsContactDelegate {

    var audio: AVAudioPlayer?
    var soundEffect: AVAudioPlayer?
    var homeButton: SKButton!
    var backButton: SKButton!
    
    // Items that can be interacted with in the game
    // FIXME: rename to shape instead of player
    var shape1: Shape1!
    var shape2: Shape2?
    var match1: Match1!
    var match2: Match2?
    var wall: Wall!

    // Set the texture variables
    var shape1Texture: String?
    var shape2Texture: String?
    var match1Texture: String?
    var match2Texture: String?
    var wallTexture: String?

    // Hold the shape size variable because it increases on touche
    var shapeBig = CGSize(width: 110, height: 110)
    var shapeSmall = CGSize(width: 100, height: 100)
    
    // Set the position variables because the pieces are placed
    // in different spots on the board in each level
    var shape1Position: CGPoint?
    var shape2Position: CGPoint?
    var match1Position: CGPoint?
    var match2Position: CGPoint?
    var wallPosition: CGPoint?
    
    // If there are 2 shapes, there will be 2 matches
    var has2Shapes = false
    
    // Use this variable for touchesMoved
    var shape1Dragging = false
    var shape2Dragging = false
    
    // For tracking the success of 2 shapes on the board
    var shape1Success = false
    var shape2Success = false
    
    // Variable to fire off the correct level
    var levelSelector: DDLevelSelector?

    override func didMove(to view: SKView) {

        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        physicsWorld.contactDelegate = self
        loadHomeButton()
        loadBackButton()
        setupTextures()
        
        // Avoids letter boxing on iPad
        sceneDidLayoutSubviews()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        setupCollisions(contact)
    }
    
    var theDraggingShape: SKSpriteNode? = nil

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if shape1.contains(location) {
                theDraggingShape = shape1
            } else {
                if let shape2 = shape2 {
                    if shape2.contains(location) {
                        theDraggingShape = shape2
                    }
                }
            }
            
            if let theDraggingShape = theDraggingShape {
                self.playCartoonVoice()
                theDraggingShape.zPosition = 100
                theDraggingShape.position = location
                theDraggingShape.size = shapeBig
            }
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if let theDraggingShape = theDraggingShape {
                move(shape: theDraggingShape, location: location)
            }
        }
    }
    
    func resetShapeSize() {
        theDraggingShape?.size = shapeSmall
        theDraggingShape?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        theDraggingShape?.zPosition = 10
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let wait = SKAction.wait(forDuration: 3)
        let slowFadeAction = SKAction.fadeOut(withDuration: 0.2)
        let fastFadeAction = SKAction.fadeOut(withDuration: 0.2)
        let transitionAction = SKAction.run { self.transitionToNextScene() }
        let spinAction = SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 0.5))
        let musicAction = SKAction.run { self.playSuccessMusic() }
        let musicStopAction = SKAction.run { self.audio?.stop() }
        let shrinkAction = SKAction.resize(toWidth: 1, height: 1, duration: 1)
        let shape1RemoveAction = SKAction.run { self.shape1?.removeFromParent() }
        let shape2RemoveAction = SKAction.run { self.shape2?.removeFromParent() }
        let removeSequence1 = SKAction.sequence([shrinkAction, shape1RemoveAction])
        let removeSequence2 = SKAction.sequence([shrinkAction, shape2RemoveAction])
        let successSequence = SKAction.sequence([musicAction, wait, slowFadeAction, musicStopAction, transitionAction])
        
        // Let the dragging shape go back to to the smallSize
        resetShapeSize()
        
        let matches: [Match?] = [match1, match2]
        for match in matches {
            if let match = match {
                
                if match.isMatched == false || match.matchSprite == nil {
                    if let matchSprite = match.matchSprite {
                        if matchSprite.contains(match.position) {
                            match.isMatched = true
                            matchSprite.run(spinAction)
                            matchSprite.run(fastFadeAction)
                            
                            if theDraggingShape == shape1 {
                                matchSprite.run(removeSequence1)
                            } else if theDraggingShape == shape2 {
                                matchSprite.run(removeSequence2)
                            }
                        }
                    }
                }
            }
        }
        
        
        var allMatched = true
        for match in matches {
            if match?.isMatched == false && match?.matchSprite != nil {
                allMatched = false
            }
        }
        
        if allMatched {
            self.run(successSequence)
        }
        
        theDraggingShape = nil


//        if has2Shapes {
//
//            // Got shape1 correct before shape2
//            if shape1Success {
//                shape1.run(spinAction)
//                shape1.run(fastFadeAction)
//                shape1.run(removeSequence1)
//
//                if shape2Success {
//                    shape2.run(spinAction)
//                    shape2.run(fastFadeAction)
//                    shape2.run(removeSequence2)
//                    self.run(successSequence)
//                }
//            }
//
//            // Got shape2 correct before shape2
//            if shape2Success {
//                shape2.run(spinAction)
//                shape2.run(fastFadeAction)
//                shape2.run(removeSequence2)
//
//                if shape1Success {
//                    shape1.run(spinAction)
//                    shape1.run(fastFadeAction)
//                    shape1.run(removeSequence1)
//                    self.run(successSequence)
//                }
//            }
//
//        } else if shape1Success {
//            shape1.run(spinAction)
//            shape1.removeFromParent()
//            self.run(successSequence)
//        }
    }
}

extension DDLevel {
    
    func loadHomeButton() {
        homeButton = self.childNode(withName: "homeButton") as! SKButton
        homeButton.position = positionFromTop(CGPoint(x: 75.0, y: 75.0))
        homeButton.selectedHandler = { [unowned self] in
            
            if let view = self.view {
                // Stop audio when navigate to home screen
                self.audio?.stop()
                
                if let scene = SKScene(fileNamed: "MainMenuScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFit
                    view.presentScene(scene)
                }
            }
        }
    }
    
    func loadBackButton() {
        backButton = self.childNode(withName: "backButton") as! SKButton
        backButton.position = positionFromTop(CGPoint(x: 75.0, y: 175.0))
        
        if let selector = levelSelector {
            if let current = selector.currentLevel {
                if current < 2 {
                    backButton.isHidden = true
                }
            }
        }
        
        backButton.selectedHandler = { [unowned self] in
            if self.view != nil {
                self.transitionToPreviousScene()
            }
        }
    }
}

