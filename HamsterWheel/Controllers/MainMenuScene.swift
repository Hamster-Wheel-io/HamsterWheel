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
        playButtonGame1.selectedHandler = { [unowned self] in
            if let view = self.view {
                let selector = DDLevelSelector()
                selector.currentLevel = 1
                
                view.presentScene(selector)
            }
        }
        
        playButtonGame2 = self.childNode(withName: "playButton2") as! SKButton
        playButtonGame2.selectedHandler = { [unowned self] in
            if let view = self.view {
                let selector = AudioGameLevelSelector()
                selector.currentLevel = 1
                
                view.presentScene(selector)
            }
        }
        
        playButtonGame3 = self.childNode(withName: "playButton3") as! SKButton
    }
}
