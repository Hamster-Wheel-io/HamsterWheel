//
//  SpellingLevelSpellingExtension.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 3/22/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import SpriteKit

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
            
            // Action to wait 1 second
            let waitAction = SKAction.wait(forDuration: 1)
            
            // Loop over word and add action for each letter
            for c in word.uppercased() {
                let letterAction = SKAction.run {
                    self.spellLabel?.text?.append(c)
                }
                // FIXME: Add audio for letters
                let soundAction = SKAction.playSoundFileNamed("", waitForCompletion: false)
                
                // FIXME: Add sound Action
                actions.append(SKAction.group([letterAction, waitAction]))
            }
            
            // Action to hide spellLabel and grayview
            let doneAction = SKAction.run {
                self.spellingDone()
            }
            actions.append(doneAction)
            
            let sequence = SKAction.sequence(actions)
            run(sequence)
        }
    }
    
    func spellingDone() {
        if let spellLabel = spellLabel {
            spellLabel.isHidden = true
            spellLabel.text = ""
            isSpelling = false
        }
    }
}
