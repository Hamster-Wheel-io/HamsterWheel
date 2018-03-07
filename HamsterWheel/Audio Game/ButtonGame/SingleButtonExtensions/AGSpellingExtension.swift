//
//  AGSpellingExtension.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 3/1/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//
<<<<<<< HEAD
=======

>>>>>>> development
import Foundation
import SpriteKit

extension SingleButtonAudioLevel {
    // Connects the skscene label to spellLabel variable
    func setupSpellLabel() {
        spellLabel = self.childNode(withName: "spellLabel") as? SKLabelNode
        spellLabel.isHidden = true
        spellLabel.text = ""
    }
    
    // Connects the skscene gray view to the grayOutView variable
    func setupGrayOutView() {
        grayOutView = self.childNode(withName: "grayOutView")
        grayOutView?.isHidden = true
    }
    
    func spellWord(word: String) {
        // Showing grayout and spellLabel
        grayOutView.isHidden = false
        spellLabel.text = ""
        spellLabel.isHidden = false
        
        // Actions for sequence
        var actions: [SKAction] = []
        
        // Action to wait 1 second
        let waitAction = SKAction.wait(forDuration: 1)
        
        // Loop over word and add action for each letter
        for c in word.uppercased() {
            let letterAction = SKAction.run {
                self.spellLabel.text?.append(c)
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
    
    func spellingDone() {
        spellLabel.isHidden = true
        spellLabel.text = ""
        grayOutView.isHidden = true
    }
}
