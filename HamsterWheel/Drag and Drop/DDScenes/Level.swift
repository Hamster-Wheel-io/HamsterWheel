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
    var player1: SKSpriteNode!
    var player2: SKSpriteNode!
    
    var matchShape1: SKSpriteNode!
    var matchShape2: SKSpriteNode!
    
    var wall: SKSpriteNode!
    
    var homeButton: SKButton!
    var backButton: SKButton!
    
    var player1Dragging = false
    var player2Dragging = false
    
    var player1Success = false
    var player2Success = false
    
    var levelSelector: DragDropLevelSelector?
    
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        loadHomeButton()
        loadBackButton()

        setupPlayer1Physics()
        setupPlayer2Physics()
        setupMatchShape1Physics()
        setupMatchShape2Physics()
        setupWallPhysics()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == PhysicsCategory.Wall | PhysicsCategory.Player1 | PhysicsCategory.Player2 {
            print("some player hit the wall\n")
        } else if collision == PhysicsCategory.MatchShape1 | PhysicsCategory.Player1 {
            print("player1 hit the match\n")
            player1Success = true
        } else if collision == PhysicsCategory.MatchShape2 | PhysicsCategory.Player2 {
            print("player2 hit the match\n")
            player2Success = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        // only perform these actions if the user touches on the shape
        if let touch = touches.first {
            if player1.contains(touch.location(in: self)) {
                
                // increase the player size to que the user that they touches the piece
                player1.size.width += 10
                player1.size.height += 10
                player1Dragging = true
                
                // MARK: cartoon voice here!
                self.playCartoonVoice()
            }
            
            if player2.contains(touch.location(in: self)) {
                
                // increase the player size to que the user that they touches the piece
                player2.size.width += 10
                player2.size.height += 10
                player2Dragging = true
                
                // MARK: cartoon voice here!
                self.playCartoonVoice()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        if player1Dragging {
            if let touch = touches.first {
                move(player: player1, location: touch.location(in: self))
            }
        }
        
        if player2Dragging {
            if let touch = touches.first {
                move(player: player2, location: touch.location(in: self))
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let spinAction = SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 0.5))
        let musicAction = SKAction.run { self.playSuccessMusic()}
        
        let zoomAction = SKAction.scale(by: 2, duration: 1)
        
        let scene = SKScene(fileNamed: "DDLevelSeven")
        
        let transitionAction = SKAction.run {
            self.transition(toScene: scene!)
        }
        
        let wait = SKAction.wait(forDuration: 1)
        let zoomWithTransition = SKAction.sequence([wait, zoomAction, transitionAction])
        
        // only perform these actions if the user touches on the shape
        if let touch = touches.first {
            if player1.contains(touch.location(in: self)) {
                
                // increase the player size to que the user that they touched the piece
                // reset the player size to the original size
                player1.size.width -= 10
                player1.size.height -= 10
                player1Dragging = false

            }
        }
        if let touch = touches.first {
            if player2.contains(touch.location(in: self)) {
                
                // reset the player size to the original size
                player2.size.width -= 10
                player2.size.height -= 10
                player2Dragging = false
            }
        }
        
        if player1Success && player2Success {
            player1.run(spinAction)
            player2.run(spinAction)
            player1.run(musicAction)
            player2.run(musicAction)
            self.run(zoomWithTransition)
        }
    }
    
    // MARK: play sound when user touches the player
    func playCartoonVoice() {
        if let asset = NSDataAsset(name: "yahoo"), let pop = NSDataAsset(name: "pop") {
            do {
                // Use NSDataAssets's data property to access the audio file stored in cartoon voice says yahoo.
                soundEffect = try AVAudioPlayer(data: pop.data, fileTypeHint: ".mp3")
                audio = try AVAudioPlayer(data: asset.data, fileTypeHint: ".mp3")
                // Play the above sound file
                soundEffect?.play()
                audio?.play()
            } catch let error as NSError {
                // Should print...
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: call this function when the user successfully completes the challenges
    func playSuccessMusic() {
        // Fetch the sound data set.
        if let music = NSDataAsset(name: "clown_music") {
            do {
                // Use NSDataAssets's data property to access the audio file stored in cartoon voice says yahoo.
                
                audio = try AVAudioPlayer(data: music.data, fileTypeHint: ".mp3")
                // Play the above sound file
                
                audio?.play()
            } catch let error as NSError {
                // Should print...
                print(error.localizedDescription)
            }
        }
    }
    
    func transition(toScene: SKScene) {
        // FIXME: change to level5
        let one = SKScene(fileNamed: "DDLevelOne")
        let two = SKScene(fileNamed: "DDLevelTwo")
        let three = SKScene(fileNamed: "DDLevelThree")
        let four = SKScene(fileNamed: "DDLevelFour")
        let five = SKScene(fileNamed: "DDLevelFive")
        let six = SKScene(fileNamed: "DDLevelSix")
        let seven = SKScene(fileNamed: "DDLevelSeven")
        
        toScene.scaleMode = .aspectFill
        self.view?.presentScene(toScene)
        print("Success")
    }
    
    func transitionToPreviousScene() {
        if let view = view {
            // Calculates the time spend on the level
            
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

    
    
    func move(player: SKSpriteNode, location: CGPoint) {
        player.position = location
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}


