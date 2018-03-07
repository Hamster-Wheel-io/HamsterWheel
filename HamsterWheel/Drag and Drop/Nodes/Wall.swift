//
//  Wall.swift
//  HamsterWheel
//
//  Created by Phyllis Wong on 3/6/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import SpriteKit

class Wall: SKSpriteNode {
    
    init(imageNamed: String) {
        let size = CGSize(width: 100, height: 100)
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: .white, size: size)
        setupWallPhysics()
    }
    
    func setupWallPhysics() {
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        self.physicsBody?.collisionBitMask = PhysicsCategory.Player1 | PhysicsCategory.Player2
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Player1 | PhysicsCategory.Player2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

