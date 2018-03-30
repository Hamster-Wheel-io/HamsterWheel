//
//  ColorButton.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 3/6/18.
//  Copyright © 2018 HamsterWheel. All rights reserved.
//
import Foundation
import UIKit

class ColorButton : UIButton {
    
    var color: UIColor
    
    init(frame: CGRect, color: UIColor) {
        self.color = color
        super.init(frame: frame)
        self.layer.cornerRadius = 0.5 * frame.size.width
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.black.cgColor
        self.clipsToBounds = true
        self.backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
