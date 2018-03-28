//
//  ButtonExtension.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 3/27/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    override open var intrinsicContentSize: CGSize {
        let intrinsicContentSize = super.intrinsicContentSize
        let adjustedWidth = intrinsicContentSize.width
        let adjustedHeight = intrinsicContentSize.height
        return CGSize(width: adjustedWidth, height: adjustedHeight)
    }
}
