//
//  SpellingLevelSpellingExtension.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 3/22/18.
//  Copyright © 2018 HamsterWheel. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

extension SpellingLevel {
    // Connects the skscene label to spellLabel variable
    func setupSpellLabel() {
        spellLabel = self.childNode(withName: "spellLabel") as? SKLabelNode
        if let spellLabel = spellLabel {
            spellLabel.isHidden = true
            spellLabel.text = ""
        }
    }
    
    func spellWord(word: String) {
        if let spellLabel = spellLabel {
            // Showing spellLabel
            spellLabel.text = ""
            spellLabel.isHidden = false
            
            // Actions for sequence
            var actions: [SKAction] = []
            
            // Adds the audio action
            let audioAction = SKAction.run {
                self.playAudio(soundName: "\(word.lowercased())Spelling")
            }
            actions.append(audioAction)
            
            // Action to wait 1 second
            let waitAction = SKAction.wait(forDuration: 1)
            
            // Wait 1 sec before starting to spell
            actions.append(waitAction)
            
            // Loop over word and add action for each letter
            for c in word.uppercased() {
                let letterAction = SKAction.run {
                    self.spellLabel?.text?.append(c)
                }
                actions.append(SKAction.group([letterAction, waitAction]))
            }
            
            // Wait 1.5 sec before removing the word from the screen
            let longerWaitAction = SKAction.wait(forDuration: 1.5)
            actions.append(longerWaitAction)
            
            // Action to hide spellLabel and grayview
            let doneAction = SKAction.run {
                self.spellingDone()
            }
            actions.append(doneAction)
            
            // Play the full sequence
            let sequence = SKAction.sequence(actions)
            run(sequence)
        }
    }
    
    // Removes the spelling label and sets the text to ""
    func spellingDone() {
        if let spellLabel = spellLabel {
            spellLabel.isHidden = true
            spellLabel.text = ""
            isSpelling = false
        }
    }
    
    // Plays the audio needed for the spelling game
    func playAudio(soundName: String) {
        // Fetch the sound data set.
        if let asset = NSDataAsset(name: soundName) {
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
}
