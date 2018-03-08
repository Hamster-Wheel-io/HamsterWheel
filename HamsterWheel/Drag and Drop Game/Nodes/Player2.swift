//
//  Player2.swift
//  HamsterWheel
//
//  Created by Phyllis Wong on 3/6/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import SpriteKit

class Player2: SKSpriteNode {
    
    init(imageNamed: String) {
        let size = CGSize(width: 100, height: 100)
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: .white, size: size)
        setupPlayer2Physics()
    }
    
    func setupPlayer2Physics() {
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Player2
        self.physicsBody?.collisionBitMask = PhysicsCategory.Wall
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Match2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
