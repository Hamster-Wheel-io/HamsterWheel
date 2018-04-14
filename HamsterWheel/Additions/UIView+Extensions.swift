//
//  UIView+Extensions.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 4/13/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 2, height: 3)
        layer.shadowRadius = 2
    }
}
