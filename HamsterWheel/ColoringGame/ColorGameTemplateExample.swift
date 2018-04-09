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
    
    // Loops over the colorPages array continuously , index 0 being nil (no template)
    @objc func toggleTemplate() {
        selectedTemplateIndex += 1
        let templateIndex = selectedTemplateIndex % colorPages.count
        
        deleteDrawing()
        
        if let template = colorPages[templateIndex] {
            addTemplate(template: template)
        } else {
            removeTemplate()
        }
    }
    
    // Adds/Replaces template with a given image
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
    
    // Removes the template from the view
    func removeTemplate() {
        if let templateView = templateView {
            templateView.removeFromSuperview()
        }
        templateView = nil
    }
}
