//
//  Match.swift
//  HamsterWheel
//
//  Created by Phyllis Wong on 3/6/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import SpriteKit

class Match1: SKSpriteNode {
    
    init(imageNamed: String) {
        let size = CGSize(width: 150, height: 150)
        let texture = SKTexture(imageNamed: imageNamed)
        
        super.init(texture: texture, color: .white, size: size)
        setupMatch1Physics()
    }
    
    func setupMatch1Physics() {
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Match1
        self.physicsBody?.collisionBitMask = PhysicsCategory.Wall
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Shape1
    }

    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}

class Match2: SKSpriteNode {
    
    init(imageNamed: String) {
        let size = CGSize(width: 150, height: 150)
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: .white, size: size)
        setupMatch2Physics()
    }
    
    func setupMatch2Physics() {
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Match2
        self.physicsBody?.collisionBitMask = PhysicsCategory.Wall
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Shape2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
