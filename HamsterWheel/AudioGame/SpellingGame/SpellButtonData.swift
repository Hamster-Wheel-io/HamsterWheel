//
//  SpellButtonData.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 3/22/18.
//  Copyright © 2018 HamsterWheel. All rights reserved.
//

import Foundation
import UIKit

class SpellButtonData {
    var word: String
    
    var defaultImage: UIImage
    var pressedImage: UIImage
    
    var audioFileName: String
    var audioFileExtension: String
    
    var scale: Double = 1
    
    init(word: String, defaultImage: UIImage, pressedImage: UIImage, audioFileName: String, audioFileExtension: String, imageScale: Double = 1) {
        self.word = word
        self.defaultImage = defaultImage
        self.pressedImage = pressedImage
        self.audioFileName = audioFileName
        self.audioFileExtension = audioFileExtension
        self.scale = imageScale
    }
}
