//
//  Match.swift
//  HamsterWheel
//
//  Created by Phyllis Wong on 3/6/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import SpriteKit

class Match: SKSpriteNode {
    
    var matchSprite: SKSpriteNode? = nil
    var isMatched = false
    
    init(imageNamed: String) {
        let size = CGSize(width: 150, height: 150)
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: .white, size: size)
        self.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        self.physicsBody?.affectedByGravity = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class Match1: Match {
    
    override init(imageNamed: String) {
        super.init(imageNamed: imageNamed)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Match1
        self.physicsBody?.collisionBitMask = PhysicsCategory.Wall
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Shape1
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Match2: Match {
    
    override init(imageNamed: String) {
        super.init(imageNamed: imageNamed)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Match2
        self.physicsBody?.collisionBitMask = PhysicsCategory.Wall
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Shape2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
