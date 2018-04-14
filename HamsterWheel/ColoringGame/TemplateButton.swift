//
//  TemplateButton.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 4/13/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

class ImageTemplateButton: UIButton {
    var image: UIImage
    
    init(image: UIImage) {
        self.image = image
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class URLTemplateButton: UIButton {
    var url: String
    
    init(url: String) {
        self.url = url
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
