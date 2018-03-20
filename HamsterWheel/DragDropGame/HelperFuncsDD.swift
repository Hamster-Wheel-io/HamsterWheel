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
    
    // Play sound when user touches the shape
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
    
    func playUhOhSound() {
        if let music = NSDataAsset(name: "uh-oh-sound") {
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
    // Use force to move the shape across the screen
//    func move(shape: SKSpriteNode) {
////    func move(shape: SKSpriteNode, location: CGPoint) {
//        // shape.position = location
//        let dx = (location.x - shape.position.x) * 4
//        let dy = (location.y - shape.position.y) * 4
//        let vector = CGVector(dx: dx, dy: dy)
//        shape.physicsBody?.velocity = vector
//        // shape.physicsBody?.applyForce(vector)
//    }
    
}
