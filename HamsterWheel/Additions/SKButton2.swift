//
//  SKButton2.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 1/30/18.
//  Copyright © 2018 HamsterWheel. All rights reserved.
//

import SpriteKit

class SKButton2: SKNode {
    var defaultButton: SKSpriteNode
    var activeButton: SKSpriteNode
    var action: () -> Void
    
    init(defaultButtonImage: UIImage, activeButtonImage: UIImage, buttonAction: @escaping () -> Void) {
        defaultButton = SKSpriteNode(texture: SKTexture(image: defaultButtonImage))
        activeButton = SKSpriteNode(texture: SKTexture(image: activeButtonImage))
        activeButton.isHidden = true
        action = buttonAction
        
        super.init()
        
        isUserInteractionEnabled = true
        addChild(defaultButton)
        addChild(activeButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        activeButton.isHidden = false
        defaultButton.isHidden = true
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = Array(touches)[0] as UITouch
        let location: CGPoint = touch.location(in: self)
        
        if defaultButton.contains(location) {
            activeButton.isHidden = false
            defaultButton.isHidden = true
        } else {
            activeButton.isHidden = true
            defaultButton.isHidden = false
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = Array(touches)[0] as UITouch
        let location: CGPoint = touch.location(in: self)
        
        if defaultButton.contains(location) {
            action()
        }
        
        activeButton.isHidden = true
        defaultButton.isHidden = false
    }
    
    /**
     Required so XCode doesn't throw warnings
     */
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
