//
//  HelperFuncsDD.swift
//  HamsterWheel
//
//  Created by Phyllis Wong on 3/8/18.
//  Copyright © 2018 HamsterWheel. All rights reserved.
//

import SpriteKit
import AVFoundation

extension DDLevel {
    
    // Play sound when user touches the shape
    func playCartoonVoice() {
        if let pop = NSDataAsset(name: "pop") {
            do {
                // Use NSDataAssets's data property to access the yahoo voice.
                soundEffect = try AVAudioPlayer(data: pop.data, fileTypeHint: ".mp3")
                soundEffect?.play()
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
                audioPlayer = try AVAudioPlayer(data: music.data, fileTypeHint: ".mp3")
                audioPlayer?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func playUhOhSound() {
        if let music = NSDataAsset(name: "uh-oh-sound") {
            do {
                // Use NSDataAssets' data property to access success music
                audioPlayer = try AVAudioPlayer(data: music.data, fileTypeHint: ".mp3")
                
                // Reduce the volume of this audio file as it is louder than the rest
                audioPlayer?.prepareToPlay()
                audioPlayer?.volume = 0.4
                audioPlayer?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }

        }
    }
}
