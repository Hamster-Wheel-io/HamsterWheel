//
//  Physics.swift
//  HamsterWheel
//
//  Created by Phyllis Wong on 2/26/18.
//  Copyright © 2018 HamsterWheel. All rights reserved.
//

import Foundation

// MARK: Physics Category

// This struct holds all physics categories
// Using a struct like this allows you to give each category a name.
// These physics categories are also used to generate collisions
// and contacts in an easy and intuitive way, see comments below.

// FIXME: Correct to match game pieces
struct PhysicsCategory {
    static let None: UInt32 = 0              // 0000000
    static let Shape1: UInt32 = 0b1         // 0000001
    static let Shape2: UInt32 = 0b10        // 0000010
    static let Wall: UInt32 = 0b100          // 0000100
    static let Match1: UInt32 = 0b1000       // 0001000
    static let Match2: UInt32 = 0b10000      // 0010000
    // 00000000000000000000000000000000 32 zeros
}

