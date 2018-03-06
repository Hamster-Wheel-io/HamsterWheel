//
//  AGAudioExtension.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 3/1/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//
import Foundation
import UIKit
import AVFoundation

extension SingleButtonAudioLevel {
    func setupAudioButton() {
        guard let normal = defaultButtonImage else {
            print("Default button was not set")
            return
        }
        
        guard let pressed = pressedButtonImage else {
            print("Pressed button image was not set")
            return
        }
        // Creates button to play audio
        audioButton = SKButton2(defaultButtonImage: normal, activeButtonImage: pressed, buttonAction: { [unowned self] in
            self.audioButtonPressed()
        })
        // Position in center of the screen
        audioButton.position = CGPoint(x: 680, y: -385)
        
        // Add button to view
        addChild(audioButton)
    }
    
    func audioButtonPressed() {
        self.playAudio(soundName: self.audioFileName!, soundExtention: self.audioFileExtension!)
        self.nextButton.isHidden = false
        
        // Check if we need to show the spelling of the animal
        if let hasSpelling = hasSpelling {
            if hasSpelling {
                spellWord(word: animal!)
            }
        }
    }
    
    // Audio
    func playAudio(soundName: String, soundExtention: String) {
        // Fetch the sound data set.
        if let asset = NSDataAsset(name: soundName) {
            do {
                // Use NSDataAssets's data property to access the audio file stored in cartoon voice says yahoo.
                audio = try AVAudioPlayer(data: asset.data, fileTypeHint: soundExtention)
                // Play the above sound file
                audio?.play()
            } catch let error as NSError {
                // Should print...
                print(error.localizedDescription)
            }
        }
    }
}
