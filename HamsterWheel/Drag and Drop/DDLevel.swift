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
    
    
    var levelSelector: DDLevelSelector?
    
    
    override func didMove(to view: SKView) {

        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        physicsWorld.contactDelegate = self
        
        
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == PhysicsCategory.Wall | PhysicsCategory.Player1 | PhysicsCategory.Player2 {
            print("some player hit the wall\n")
        } else if collision == PhysicsCategory.Match1 | PhysicsCategory.Player1 {
            print("player1 hit the match\n")
            player1Success = true
        } else if collision == PhysicsCategory.Match2 | PhysicsCategory.Player2 {
            print("player2 hit the match\n")
            player2Success = true
        }
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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let spinAction = SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 0.5))
        let musicAction = SKAction.run { self.playSuccessMusic()}
        
        
        // only perform these actions if the user drags the shape
        player1.size = playerSmall
        player1Dragging = false
        player1.physicsBody?.velocity = CGVector(dx: 0, dy: 0)

        player2?.size = playerSmall
        player2Dragging = false
        player2?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)

        if has2Players {
            if player1Success && player2Success {
                player1.run(spinAction)
                player2?.run(spinAction)
                player1.run(musicAction)
                player2?.run(musicAction)
                self.transitionToNextScene()
                
            }
        } else if player1Success {
            player1.run(spinAction)
            player1.run(musicAction)
            self.transitionToNextScene()
        }
    }
    
    // MARK: play sound when user touches the player
    func playCartoonVoice() {
        if let asset = NSDataAsset(name: "yahoo"), let pop = NSDataAsset(name: "pop") {
            do {
                // Use NSDataAssets's data property to access the yahoo voice.
                soundEffect = try AVAudioPlayer(data: pop.data, fileTypeHint: ".mp3")
                audio = try AVAudioPlayer(data: asset.data, fileTypeHint: ".mp3")
                soundEffect?.play()
                audio?.play()
            } catch let error as NSError {
                // Should print...
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: play ssuccess music when user completes the challenge(s)
    func playSuccessMusic() {
        // Fetch the sound data set
        if let music = NSDataAsset(name: "clown_music") {
            do {
                // Use NSDataAssets' data property to access success music
                audio = try AVAudioPlayer(data: music.data, fileTypeHint: ".mp3")
                audio?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    
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
    
    

    // Use force to move the player across the screen
    func move(player: SKSpriteNode, location: CGPoint) {
        // player.position = location
        let dX = location.x - player.position.x
        let dY = location.y - player.position.y
        let vector = CGVector(dx: dX, dy: dY)
        
        player.physicsBody?.applyForce(vector)
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


