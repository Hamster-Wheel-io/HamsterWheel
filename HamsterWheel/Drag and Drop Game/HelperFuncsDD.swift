//
//  HelperFuncsDD.swift
//  HamsterWheel
//
//  Created by Phyllis Wong on 3/8/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import SpriteKit
import AVFoundation

extension DDLevel {
    
    // Play sound when user touches the player
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
    
    // Play ssuccess music when user completes the challenge(s)
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
    
    
    // MARK: Friction Physics.
    // Use force to move the player across the screen
    func move(player: SKSpriteNode, location: CGPoint) {
        // player.position = location
        let dx = (location.x - player.position.x) * 4
        let dy = (location.y - player.position.y) * 4
        let vector = CGVector(dx: dx, dy: dy)
        player.physicsBody?.velocity = vector
        // player.physicsBody?.applyForce(vector)
    }
    
}
