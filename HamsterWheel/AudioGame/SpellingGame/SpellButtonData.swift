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
    
    init(word: String, defaultImage: UIImage, pressedImage: UIImage, audioFileName: String, audioFileExtension: String) {
        self.word = word
        self.defaultImage = defaultImage
        self.pressedImage = pressedImage
        self.audioFileName = audioFileName
        self.audioFileExtension = audioFileExtension
    }
}
