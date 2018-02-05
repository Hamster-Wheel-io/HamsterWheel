//
//  LevelTwo.swift
//  TestDragDrop
//
//  Created by Phyllis Wong on 1/22/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import SpriteKit
import AVFoundation

class DDLevelTwo: SKScene {
    
    
    
    var audio: AVAudioPlayer?
    var player: SKSpriteNode!
    var matchShape: SKSpriteNode!
    
    var isDragging = false
    
    
    override func didMove(to view: SKView) {
        
        player = childNode(withName: "player") as! SKSpriteNode
        matchShape = childNode(withName: "matchShape") as! SKSpriteNode!
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // only perform these actions if the user touches on the shape
        if let touch = touches.first {
            if player.contains(touch.location(in: self)) {
                
                // increase the player size to que the user that they touches the piece
                player.size = CGSize(width: 250, height: 250)
                isDragging = true
                
                // MARK: cartoon voice here!
                self.playCartoonVoice()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isDragging {
            if let touch = touches.first {
                movePlayerTo(location: touch.location(in: self))
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let spinAction = SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 0.5))
        let musicAction = SKAction.run { self.playSuccessMusic()}
        let fadeAction = SKAction.fadeOut(withDuration: 2)
        //let fadeWithDelay = SKAction.sequence([SKAction.wait(forDuration: 2), fadeAction])
        
        let spinWithSound = SKAction.group([spinAction, musicAction])
        
        let zoomAction = SKAction.scale(by: 2, duration: 1)
        let transitionAction = SKAction.run {
            self.transitionToScene()
        }
        let wait = SKAction.wait(forDuration: 1)
        let zoomWithTransition = SKAction.sequence([wait, zoomAction, transitionAction])
        
        isDragging = false
        
        // reset the player size to the original size
        player.size = CGSize(width: 230, height: 230)
        
        // Get the coordinates of the player when touch ends
        let xCoord = player.position.x
        let yCoord = player.position.y
        
        // Get the range around the matchShape
        let upperBoundx = matchShape.position.x + 30
        let upperBoundy = matchShape.position.y + 30
        let lowerBoundx = matchShape.position.x - 30
        let lowerBoundy = matchShape.position.y - 30
        
        // Check if the player is within the range of coordinates of the matchShape
        if lowerBoundx <= xCoord && xCoord <= upperBoundx {
            if lowerBoundy <= yCoord && yCoord <= upperBoundy {
                
                player.run(spinAction)
                player.run(musicAction)
                self.run(zoomWithTransition)
                
            }
        }
    }
    
    // MARK: call this func when the user touches the player
    func playCartoonVoice() {
        if let asset = NSDataAsset(name: "cartoon_voice_says_yahoo") {
            do {
                // Use NSDataAssets's data property to access the audio file stored in cartoon voice says yahoo.
                audio = try AVAudioPlayer(data: asset.data, fileTypeHint: ".mp3")
                // Play the above sound file
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
        if let asset = NSDataAsset(name: "mr_clown_music") {
            do {
                // Use NSDataAssets's data property to access the audio file stored in cartoon voice says yahoo.
                audio = try AVAudioPlayer(data: asset.data, fileTypeHint: ".mp3")
                // Play the above sound file
                audio?.play()
            } catch let error as NSError {
                // Should print...
                print(error.localizedDescription)
            }
        }
    }
    
    
    func transitionToScene() {
        let levelThree = DDLevelThree(fileNamed: "DDLevelThree")
        levelThree?.scaleMode = .aspectFill
        self.view?.presentScene(levelThree!)
        print("Success")
    }
    
    
    func movePlayerTo(location: CGPoint) {
        player.position = location
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}
