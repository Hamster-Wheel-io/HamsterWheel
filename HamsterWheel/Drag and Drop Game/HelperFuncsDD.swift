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
    
    
    // Use force to move the player across the screen
    func move(player: SKSpriteNode, location: CGPoint) {
        // player.position = location
        let dX = (location.x - player.position.x) * 3
        let dY = (location.y - player.position.y) * 3
        let vector = CGVector(dx: dX, dy: dY)
        
        player.physicsBody?.applyForce(vector)
    }
    
}
