//
//  ColorGameTemplateExample.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 3/27/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

extension ColoringGameViewController {
    
    @objc func toggleTemplate() {
        if hasTemplate {
            deleteDrawing()
            removeTemplate()
            hasTemplate = false
        } else {
            deleteDrawing()
            // TODO: Change template
            addTemplate(template: #imageLiteral(resourceName: "fishPage"))
            hasTemplate = true
        }
    }
    
    func addTemplate(template: UIImage) {
        // Check if there already is a template view
        if let templateView = templateView {
            // If there is a template view change the image
            templateView.image = template
        } else {
            // Else create and setup UIImageView
            let imageView = UIImageView(image: template)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = self.view.frame
            templateView = imageView
            
            // Check if there is a drawView
            drawView != nil ?
                // If there is insert it below
                self.view.insertSubview(templateView!, belowSubview: drawView!) :
                // Else just add subview
                self.view.addSubview(templateView!)
        }
    }
    
    func removeTemplate() {
        if let templateView = templateView {
            templateView.removeFromSuperview()
        }
        templateView = nil
    }
}
