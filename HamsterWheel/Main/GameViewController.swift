//
//  GameViewController.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 1/22/18.
//  Copyright © 2018 HamsterWheel. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "MainMenuScene") {
                // Set the scale mode to scale to fit iPad
                scene.scaleMode = .aspectFit
                view.presentScene(scene)
            }
            // Increase performance by not having the scene render the children in order
            view.ignoresSiblingOrder = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
