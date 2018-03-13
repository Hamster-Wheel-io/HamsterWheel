//
//  Player.swift
//  HamsterWheel
//
//  Created by Phyllis Wong on 3/6/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    
    init(imageNamed: String) {
        let size = CGSize(width: 100, height: 100)
        let texture = SKTexture(imageNamed: imageNamed)
        
        func setupPlayerPhysics() {
            self.physicsBody = SKPhysicsBody(circleOfRadius: 50)
            self.physicsBody?.affectedByGravity = false
            self.physicsBody?.allowsRotation = false
            self.physicsBody?.linearDamping = 0.7
        }
        
        super.init(texture: texture, color: .white, size: size)
        setupPlayerPhysics()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class Player1: Player {
    
    override init(imageNamed: String) {
        super.init(imageNamed: imageNamed)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Player1
        self.physicsBody?.collisionBitMask = PhysicsCategory.Wall
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Match1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Player2: Player {
    
    override init(imageNamed: String) {
        super.init(imageNamed: imageNamed)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Player2
        self.physicsBody?.collisionBitMask = PhysicsCategory.Wall
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Match2
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

