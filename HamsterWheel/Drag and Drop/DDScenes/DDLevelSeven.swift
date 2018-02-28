//
//  DDLevelSeven.swift
//  HamsterWheel
//
//  Created by Phyllis Wong on 2/26/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import SpriteKit
import AVFoundation

class DDLevelSeven: SKScene, SKPhysicsContactDelegate {

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
    
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        print("Level 7 did move to view")
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
                view.showsFPS = true
                view.showsPhysics = true
                view.showsDrawCount = true
            }
        }
        
        /* Set UI connections */
        backButton = self.childNode(withName: "backButton") as! SKButton
        
        /* Setup button selection handler for homescreen */
        backButton.selectedHandler = { [unowned self] in
            if let view = self.view {
                
                // FIXME: Load the SKScene from before. Hard Code this until I figure out an algorithm.
                if let scene = SKScene(fileNamed: "DDLevelThree") {
                    
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view.presentScene(scene)
                }
                
                // Debug helpers
                view.showsFPS = true
                view.showsPhysics = true
                view.showsDrawCount = true
            }
        }

        
        player1 = childNode(withName: "player1") as! SKSpriteNode
        player1.physicsBody = SKPhysicsBody(circleOfRadius: 60)
        player1.physicsBody?.affectedByGravity = false
        player1.physicsBody?.categoryBitMask = PhysicsCategory.Player1
        player1.physicsBody?.collisionBitMask = PhysicsCategory.Wall
        player1.physicsBody?.contactTestBitMask = PhysicsCategory.MatchShape1
        
        player2 = childNode(withName: "player2") as! SKSpriteNode
        player2.physicsBody = SKPhysicsBody(circleOfRadius: 60)
        player2.physicsBody?.affectedByGravity = false
        player2.physicsBody?.categoryBitMask = PhysicsCategory.Player2
        player2.physicsBody?.collisionBitMask = PhysicsCategory.Wall
        player2.physicsBody?.contactTestBitMask = PhysicsCategory.MatchShape2
        
        matchShape1 = childNode(withName: "matchShape1") as! SKSpriteNode!
        matchShape1.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        matchShape1.physicsBody?.affectedByGravity = false
        matchShape1.physicsBody?.isDynamic = false
        matchShape1.physicsBody?.categoryBitMask = PhysicsCategory.MatchShape1
        matchShape1.physicsBody?.collisionBitMask = 0
        matchShape1.physicsBody?.contactTestBitMask = PhysicsCategory.Player1
        
        matchShape2 = childNode(withName: "matchShape2") as! SKSpriteNode!
        matchShape2.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        matchShape2.physicsBody?.affectedByGravity = false
        matchShape2.physicsBody?.isDynamic = false
        matchShape2.physicsBody?.categoryBitMask = PhysicsCategory.MatchShape2
        matchShape2.physicsBody?.collisionBitMask = PhysicsCategory.None
        matchShape2.physicsBody?.contactTestBitMask = PhysicsCategory.Player2
        
        wall = childNode(withName: "wall") as! SKSpriteNode!
        wall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        wall.physicsBody?.collisionBitMask = PhysicsCategory.Player1 | PhysicsCategory.Player2
        wall.physicsBody?.contactTestBitMask = PhysicsCategory.Player1 | PhysicsCategory.Player2
        
       
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == PhysicsCategory.Wall | PhysicsCategory.Player1 | PhysicsCategory.Player2 {
            print("some player hit the wall\n")
        } else if collision == PhysicsCategory.MatchShape1 | PhysicsCategory.Player1 {
            print("player1 hit the match\n")
        } else if collision == PhysicsCategory.MatchShape2 | PhysicsCategory.Player2 {
            print("player2 hit the match\n")
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
        let transitionAction = SKAction.run {
            self.transitionToScene()
        }
        
        let wait = SKAction.wait(forDuration: 1)
        let zoomWithTransition = SKAction.sequence([wait, zoomAction, transitionAction])
        
        // only perform these actions if the user touches on the shape
        if let touch = touches.first {
            if player1.contains(touch.location(in: self)) {
                
                // increase the player size to que the user that they touches the piece
                // reset the player size to the original size
                player1.size.width -= 10
                player1.size.height -= 10
                player1Dragging = false

            }
        }
        if let touch = touches.first {
            if player2.contains(touch.location(in: self)) {
                
                // increase the player size to que the user that they touches the piece
                // reset the player size to the original size
                player2.size.width -= 10
                player2.size.height -= 10
                player2Dragging = false
                
            }
        }
        
        
        

        
        // Get the coordinates of the player when touch ends
        let xCoord = player1.position.x
        let yCoord = player1.position.y
        
        // Get the range around the matchShape
        let upperBoundx = matchShape1.position.x + 30
        let upperBoundy = matchShape1.position.y + 30
        let lowerBoundx = matchShape1.position.x - 30
        let lowerBoundy = matchShape1.position.y - 30
        
        // Check if the player is within the range of coordinates of the matchShape
        if lowerBoundx <= xCoord && xCoord <= upperBoundx {
            if lowerBoundy <= yCoord && yCoord <= upperBoundy {
                
                player1.run(spinAction)
                player1.run(musicAction)
                self.run(zoomWithTransition)
                
            }
        }
    }
    
    // MARK: call this func when the user touches the player
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
    
    func transitionToScene() {
        // FIXME: change to level5
        let levelFive = DDLevelFive(fileNamed: "DDLevelSeven")
        levelFive?.scaleMode = .aspectFill
        self.view?.presentScene(levelFive!)
        print("Success")
    }
    
    
    func move(player: SKSpriteNode, location: CGPoint) {
        player.position = location
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
}


