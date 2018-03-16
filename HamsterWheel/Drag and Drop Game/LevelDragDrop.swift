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
    var player1: Player1!
    var player2: Player2!
    var match1: Match1!
    var match2: Match2!
    var wall: Wall!

    // Set the texture variables
    var player1Texture: String?
    var player2Texture: String?
    var match1Texture: String?
    var match2Texture: String?
    var wallTexture: String?

    // Hold the player size variable because it increases on touche
    var playerBig = CGSize(width: 110, height: 110)
    var playerSmall = CGSize(width: 100, height: 100)
    
    // Set the position variables because the pieces are placed
    // in different spots on the board in each level
    var player1Position: CGPoint?
    var player2Position: CGPoint?
    var match1Position: CGPoint?
    var match2Position: CGPoint?
    var wallPosition: CGPoint?
    
    // If there are 2 players, there will be 2 matches
    var has2Players = false
    
    // Use this variable for touchesMoved
    var player1Dragging = false
    var player2Dragging = false
    
    // For tracking the success of 2 players on the board
    var player1Success = false
    var player2Success = false
    
    // Variable to fire off the correct level
    var levelSelector: DDLevelSelector?
    

    override func didMove(to view: SKView) {

        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        physicsWorld.contactDelegate = self
        
        setupTextures()

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        setupCollisions(contact)
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        // only perform these actions if the user touches on the shape
        if let touch = touches.first {
            if player1.contains(touch.location(in: self)) {
                
                // Show the user they are touching the piece.
                player1.size = playerBig
                player1Dragging = true
                player2Dragging = false
                
                self.playCartoonVoice()
            }
            
            // Check if there is a second player on the screen
            if let player2 = player2 {
                
                if (player2.contains(touch.location(in: self))) {
                    
                    // Show the user they are touching the piece.
                    player2.size = playerBig
                    player2Dragging = true
                    player1Dragging = false
                    
                    self.playCartoonVoice()
                }
            }
        }
    }
    
    var fingerLocationOnScreen = CGPoint()
    
    // Tells the physicsBody which direction to apply the force
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.fingerLocationOnScreen = touch.location(in: self)
        }
       
    }
    
    func resetPlayerSize() {
        // only perform these actions if the user drags the shape
        player1.size = playerSmall
        player1Dragging = false
        player1.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        player2?.size = playerSmall
        player2Dragging = false
        player2?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let wait = SKAction.wait(forDuration: 2)
        let slowFadeAction = SKAction.fadeOut(withDuration: 0.2)
        let fastFadeAction = SKAction.fadeOut(withDuration: 0.2)
        let transitionAction = SKAction.run { self.transitionToNextScene() }
        let spinAction = SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 0.5))
        let musicAction = SKAction.run { self.playSuccessMusic()}
        let musicStopAction = SKAction.run { self.audio?.stop() }
        let shrinkAction = SKAction.resize(toWidth: 1, height: 1, duration: 0.5)
        let player1RemoveAction = SKAction.run { self.player1.removeFromParent() }
        let player2RemoveAction = SKAction.run { self.player2.removeFromParent() }
        let removeSequence1 = SKAction.sequence([shrinkAction, player1RemoveAction])
        let removeSequence2 = SKAction.sequence([shrinkAction, player2RemoveAction])
        let successSequence = SKAction.sequence([musicAction, wait, slowFadeAction, musicStopAction, transitionAction])
        
        resetPlayerSize()

        if has2Players {
    
            // Got player1 correct before player2
            if player1Success {
                player1.run(spinAction)
                player1.run(fastFadeAction)
                player1.run(removeSequence1)
                
                if player2Success {
                    player2.run(spinAction)
                    player2.run(fastFadeAction)
                    player2.run(removeSequence2)
                    self.run(successSequence)
                }
            }
            
            // Got player2 correct before player2
            if player2Success {
                player2.run(spinAction)
                player2.run(fastFadeAction)
                player2.run(removeSequence2)
                
                if player1Success {
                    player1.run(spinAction)
                    player1.run(fastFadeAction)
                    player1.run(removeSequence1)
                    self.run(successSequence)
                }
            }
            
        } else if player1Success {
            player1.run(spinAction)
            player1.removeFromParent()
            self.run(successSequence)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if player1Dragging {
            move(player: player1, location: fingerLocationOnScreen)
        }
        
        if player2Dragging {
            move(player: player2!, location: fingerLocationOnScreen)
        }
    }
}


