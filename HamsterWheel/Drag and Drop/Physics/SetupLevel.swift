//
//  SetUpLevel.swift
//  HamsterWheel
//
//  Created by Phyllis Wong on 3/1/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import SpriteKit
import AVFoundation

extension DDLevel {

    func loadHomeButton() {
        /* Set UI connections */
        homeButton = self.childNode(withName: "homeButton") as! SKButton
        
        /* Setup button selection handler for homescreen */
        homeButton.selectedHandler = { [unowned self] in
            if let view = self.view {
                
                // FIXME: Load the SKScene from 'MainMenuScene.sks'
                if let scene = SKScene(fileNamed: "MainMenuScene") {
                    
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view.presentScene(scene)
                }
                
                // Debug helpers
                view.showsPhysics = true
            }
        }
    }
    
    func loadBackButton() {
        
        /* Set UI connections */
        backButton = self.childNode(withName: "backButton") as! SKButton
        
        /* Setup button selection handler for homescreen */
        backButton.selectedHandler = { [unowned self] in
            if let view = self.view {
                
                // FIXME: Load the SKScene from before. Hard Code this until I figure out an algorithm.
                self.transitionToPreviousScene()
                // Debug helpers
                view.showsPhysics = true
            }
        }
    }
    
}
