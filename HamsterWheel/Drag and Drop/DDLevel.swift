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
    var player1: Player1!
    var player2: Player2!
    
    var match1: Match1!
    var match2: Match2!
    
    var wall: Wall!
    
    var homeButton: SKButton!
    var backButton: SKButton!
    
    var has2Players = false
    
    var player1Dragging = false
    var player2Dragging = false
    
    var player1Success = false
    var player2Success = false
    
    var playerBig = CGSize(width: 110, height: 110)
    var playerSmall = CGSize(width: 100, height: 100)
    var matchSize = CGSize(width: 150, height: 150)
    
    
    var player1Texture: String?
    var player2Texture: String?
    
    var match1Texture: String?
    var match2Texture: String?
    
    var wallTexture: String?
    var wallPosition: CGPoint?
    
    var player1Position: CGPoint?
    var player2Position: CGPoint?
    var match1Position: CGPoint?
    var match2Position: CGPoint?
    
    
    var levelSelector: DDLevelSelector?
    
    
    override func didMove(to view: SKView) {

        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        physicsWorld.contactDelegate = self
        
        
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
                
                // increase the player size to que the user that they touches the piece
                player1.size = playerBig
                player1Dragging = true
                player2Dragging = false
                
                self.playCartoonVoice()
            }
            
            if let player2 = player2 {
                if (player2.contains(touch.location(in: self))) {
                    
                    // increase the player size to que the user that they touches the piece
                    player2.size = playerBig
                    player2Dragging = true
                    player1Dragging = false
                    
                    self.playCartoonVoice()
                }
            }
        }
    }
    
    var fingerLocationOnScreen = CGPoint()
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.fingerLocationOnScreen = touch.location(in: self)
        }
       
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let spinAction = SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 0.5))
        let musicAction = SKAction.run { self.playSuccessMusic()}
        
        let zoomAction = SKAction.scale(by: 2, duration: 1)
        
        let scene = SKScene(fileNamed: "DDLevelSeven")
        
        
        let wait = SKAction.wait(forDuration: 1)
        
        // only perform these actions if the user touches on the shape
        player1.size = playerSmall
        player1Dragging = false
        player1.physicsBody?.velocity = CGVector(dx: 0, dy: 0)

        player2?.size = playerSmall
        player2Dragging = false
        player2?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)

        
        if player1Success && player2Success {
            player1.run(spinAction)
            player2?.run(spinAction)
            player1.run(musicAction)
            player2?.run(musicAction)
            self.transitionToNextScene()

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
    
    // Setup title label and add it to the scene
    func setupPlayer1(texture: String, position: CGPoint) {
        player1 = Player1(imageNamed: texture)
        player1.size = playerSmall
        player1.position = position
        player1.zPosition = 2
        
        addChild(player1)
    }
    
    func setupMatch1(texture: String, position: CGPoint) {
        match1 = Match1(imageNamed: texture)
        match1.size = matchSize
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
        match2.size = matchSize
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

}


