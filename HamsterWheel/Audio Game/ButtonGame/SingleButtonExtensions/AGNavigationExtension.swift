//
//  AGNavigationExtension.swift
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
    
    // MARK: Navigation buttons setup
    
    func connectNextLevelButton() {
        nextButton = self.childNode(withName: "nextButton") as! SKButton
        nextButton.selectedHandler = transitionToNextScene
        nextButton.isHidden = true
    }
    
    func setupHomeButton() {
        /* Set UI connections */
        menuButton = self.childNode(withName: "menuButton") as! SKButton
        
        /* Setup button selection handler for homescreen */
        menuButton.selectedHandler = { [unowned self] in
            if let view = self.view {
                self.setEndTimeAndCalculateDifference()
                if let scene = SKScene(fileNamed: "MainMenuScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    // Present the scene
                    view.presentScene(scene)
                }
                
                // Debug helpers
<<<<<<< HEAD

                view.showsPhysics = true
               
=======
                view.showsFPS = true
                view.showsPhysics = true
                view.showsDrawCount = true
>>>>>>> development
            }
        }
    }
    
    func setupBackButton() {
        /* Set UI connections */
        backButton = self.childNode(withName: "backButton") as! SKButton
        if let selector = levelSelector {
            if let current = selector.currentLevel {
                if current < 2 {
                    backButton.isHidden = true
                }
            }
        }
        /* Setup button selection handler for homescreen */
        backButton.selectedHandler = { [unowned self] in
            if let view = self.view {
                // Calculates the time spend on the level
                self.setEndTimeAndCalculateDifference()
                
                if let selector = self.levelSelector {
                    if selector.currentLevel != nil {
                        selector.currentLevel! -= 1
                    } else {
                        selector.currentLevel = 1
                    }
                    
                    view.presentScene(selector)
                }
            }
        }
    }
    
    func transitionToNextScene() {
        if let view = view {
            // Calculates the time spend on the level
            setEndTimeAndCalculateDifference()
            
            if let selector = levelSelector {
                if selector.currentLevel != nil {
                    selector.currentLevel! += 1
                } else {
                    selector.currentLevel = 1
                }
                view.presentScene(selector)
            }
        }
    }
}
