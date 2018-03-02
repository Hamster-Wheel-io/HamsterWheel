//
//  SetupPhysics.swift
//  HamsterWheel
//
//  Created by Phyllis Wong on 3/1/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import SpriteKit

extension DDLevel {
    
    func setupPlayer1Physics() {
        player1 = childNode(withName: "player1") as! SKSpriteNode
        player1.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        player1.physicsBody?.affectedByGravity = false
        player1.physicsBody?.categoryBitMask = PhysicsCategory.Player1
        player1.physicsBody?.collisionBitMask = PhysicsCategory.Wall
        player1.physicsBody?.contactTestBitMask = PhysicsCategory.MatchShape1
    }
    
    func setupPlayer2Physics() {
        player2 = childNode(withName: "player2") as! SKSpriteNode
        player2.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        player2.physicsBody?.affectedByGravity = false
        player2.physicsBody?.categoryBitMask = PhysicsCategory.Player2
        player2.physicsBody?.collisionBitMask = PhysicsCategory.Wall
        player2.physicsBody?.contactTestBitMask = PhysicsCategory.MatchShape2
    }
    
    func setupMatchShape1Physics() {
        matchShape1 = childNode(withName: "matchShape1") as! SKSpriteNode!
        matchShape1.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        matchShape1.physicsBody?.affectedByGravity = false
        matchShape1.physicsBody?.isDynamic = false
        matchShape1.physicsBody?.categoryBitMask = PhysicsCategory.MatchShape1
        matchShape1.physicsBody?.collisionBitMask = 0
        matchShape1.physicsBody?.contactTestBitMask = PhysicsCategory.Player1
    }
    
    func setupMatchShape2Physics() {
        matchShape2 = childNode(withName: "matchShape2") as! SKSpriteNode!
        matchShape2.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        matchShape2.physicsBody?.affectedByGravity = false
        matchShape2.physicsBody?.isDynamic = false
        matchShape2.physicsBody?.categoryBitMask = PhysicsCategory.MatchShape2
        matchShape2.physicsBody?.collisionBitMask = PhysicsCategory.None
        matchShape2.physicsBody?.contactTestBitMask = PhysicsCategory.Player2
    }
    
    func setupWallPhysics() {
        wall = childNode(withName: "wall") as! SKSpriteNode!
        wall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        wall.physicsBody?.collisionBitMask = PhysicsCategory.Player1 | PhysicsCategory.Player2
        wall.physicsBody?.contactTestBitMask = PhysicsCategory.Player1 | PhysicsCategory.Player2
    }
}
