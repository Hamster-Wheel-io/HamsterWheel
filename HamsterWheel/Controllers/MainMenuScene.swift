//
//  MainMenuScene.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 1/22/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    
    /* UI Connections */
    var playButtonGame1: SKButton!
    var playButtonGame2: SKButton!
    var playButtonGame3: SKButton!
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        playButtonGame1 = self.childNode(withName: "playButton1") as! SKButton
        
        /* Setup button selection handler */
        playButtonGame1.selectedHandler = { [unowned self] in
            if let view = self.view {
                
                // FIXME: Chamge for testing
                // Load the SKScene from 'GameScene.sks'
                
                if let scene = SKScene(fileNamed: "DDLevelSeven") {
                    
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view.presentScene(scene)
                }
                
                // Debug helpers
                view.showsFPS = true
                view.showsPhysics = true
                view.showsDrawCount = true
            }
        }
        
        playButtonGame2 = self.childNode(withName: "playButton2") as! SKButton
        playButtonGame2.selectedHandler = { [unowned self] in
            if let view = self.view {
                
                // Load the SKScene from 'AGlevel1.sks'
                if let scene = SKScene(fileNamed: "AGlevel1") {
                    
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view.presentScene(scene)
                }
                
                // Debug helpers
                view.showsFPS = true
                view.showsPhysics = true
                view.showsDrawCount = true
            }
        }
        
        playButtonGame3 = self.childNode(withName: "playButton3") as! SKButton
    }
}
