//  Shape.swift
//  HamsterWheel
//
//  Created by Phyllis Wong on 3/6/18.
//  Copyright © 2018 HamsterWheel. All rights reserved.


import Foundation
import SpriteKit

class Shape: SKSpriteNode {
    
    static let maxVelocity: CGFloat = 10000
    static let velocityMutiplier: CGFloat = 30
    
    let label = SKLabelNode()
    var home = CGPoint()
    
    init(imageNamed: String) {
        let size = CGSize(width: 100, height: 100)
        let texture = SKTexture(imageNamed: imageNamed)
        
        super.init(texture: texture, color: .white, size: size)
//        self.isUserInteractionEnabled = true
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.mass = 0
        self.physicsBody?.friction = 0
        self.physicsBody?.restitution = 0
        self.physicsBody?.linearDamping = 0.0
//        label.zPosition = 100
//        label.fontColor = UIColor.black
//        label.fontName = "HelveticaNeue-Bold"
        addChild(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Shape1: Shape {
    
    override init(imageNamed: String) {
        super.init(imageNamed: imageNamed)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Shape1
        self.physicsBody?.collisionBitMask = PhysicsCategory.Wall
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Match1 | PhysicsCategory.Match2
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Shape2: Shape {
    
    override init(imageNamed: String) {
        super.init(imageNamed: imageNamed)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Shape2
        self.physicsBody?.collisionBitMask = PhysicsCategory.Wall
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Match2 | PhysicsCategory.Match1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

