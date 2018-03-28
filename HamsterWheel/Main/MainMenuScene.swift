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
        playButtonGame1 = self.childNode(withName: "shapesButton") as! SKButton
        playButtonGame1.selectedHandler = { [unowned self] in
            if let view = self.view {
                let selector = DDLevelSelector()
                selector.currentLevel = 1
                // Set the scale mode to scale to fit the window
                selector.scaleMode = .aspectFit
                view.presentScene(selector)
            }
        }
        
        playButtonGame2 = self.childNode(withName: "audioButton") as! SKButton
        playButtonGame2.selectedHandler = { [unowned self] in
            if let view = self.view {
                let selector = AudioGameLevelSelector()
                selector.currentLevel = 1
                
                view.presentScene(selector)
            }
        }
        
        playButtonGame3 = self.childNode(withName: "coloringButton") as! SKButton
        playButtonGame3.selectedHandler = { [unowned self] in
            if let view = self.view {
                let vc = ColoringGameViewController()
                
                UIView.transition(with: view, duration: 0.3, options: .transitionFlipFromRight, animations: {
                    view.window?.rootViewController = vc
                }, completion: nil)
            }
        }
        // Avoids letter 
        sceneDidLayoutSubviews()
        // Avoids letter boxing on iPhoneX
        iPhoneXLetterBoxing()
    }
    
    /*
     Extends the view to the edges of the frame
     Avoiding letter boxing (black bars top and bottom)
     */
    func sceneDidLayoutSubviews(skView: SKView) {
        if let scene = skView.scene {
            var size = scene.size
            let newHeight = skView.bounds.size.height / skView.bounds.width * size.width
            if newHeight > size.height {
                scene.anchorPoint = CGPoint(x: 0, y: (newHeight - scene.size.height) / 2.0 / newHeight)
                size.height = newHeight
                scene.size = size
            }
        }
    }
}
