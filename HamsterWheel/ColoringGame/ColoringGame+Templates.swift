//
//  ColorGameTemplateExample.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 3/27/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

extension ColoringGameViewController: UIScrollViewDelegate {
    /*
     Checks if there already is a menu or not
        if there is one move it in
        else get templates from the api
            if there are templates populate the menu
            else populate the menu with locally stores templates
     */
    @objc func openTemplateMenu() {
        if scrollView != nil {
            moveTemplateMenuIn()
        } else {
            DispatchQueue.main.async {
                self.addTemplateMenu(links: nil, images: self.colorPages)
                self.moveTemplateMenuIn()
            }
        }
    }
    
    // Moves template menu into place
    func moveTemplateMenuIn() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25) {
                self.scrollView?.frame.origin = CGPoint(x: 5, y: 5)
                self.colorView?.frame.origin = CGPoint(x: 5, y: 5)
            }
        }
    }
    
    // Moves template menu out of screen
    func moveTemplateMenuOut() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25) {
                self.scrollView?.frame.origin = CGPoint(x: -((UIScreen.main.bounds.width / 4.0) + 20), y: 5)
                self.colorView?.frame.origin = CGPoint(x: -(self.scrollView!.frame.width - 20), y: 5)
            }
        }
    }
    
    // Populates the templateView with either a url or a UIImage
    @objc func templateButtonPressed(sender: UIButton) {
        deleteDrawing()
        if let sender = sender as? URLTemplateButton {
            addTemplate(link: sender.url)
        } else if let sender = sender as? ImageTemplateButton {
            addTemplate(template: sender.image)
        }
        moveTemplateMenuOut()
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
    
    // Adds/Replaces template with a given url
    func addTemplate(link: String) {
        // Check if there already is a template view
        if let templeteView = templateView {
            // If there is a template view change the image
            templeteView.downloadedFrom(link: link)
        } else {
            // Else create and setup UIImageView
            let imageView = UIImageView(frame: self.view.frame)
            imageView.contentMode = .scaleAspectFit
            templateView = imageView
            templateView?.downloadedFrom(link: link)
            
            // Check if there is a drawView
            drawView != nil ?
                // If there is insert it below
                self.view.insertSubview(templateView!, belowSubview: drawView!) :
                // Else just add subview
                self.view.addSubview(templateView!)
        }
    }
    
    // Removes the template from the view
    @objc func removeTemplate() {
        moveTemplateMenuOut()
        deleteDrawing()
        if let templateView = templateView {
            templateView.removeFromSuperview()
        }
        templateView = nil
    }
    
    func addTemplateMenu(links: [String]?, images: [UIImage]?) {
        var count = 0
        if let links = links {
            count = links.count
        } else if let images = images {
            count = images.count
        }
        
        // Variables
        let viewWidth = (UIScreen.main.bounds.width / 4.0)
        let viewHeight = (UIScreen.main.bounds.height)
        let buttonHeight: CGFloat = UIScreen.main.bounds.height / 3
        let contentHeight: CGFloat = CGFloat(count) * buttonHeight
        
        // Scroll view
        scrollView = UIScrollView()
        scrollView!.frame = CGRect(x: -(viewWidth + 20), y: 5.0, width: viewWidth + 10, height: viewHeight)
        scrollView!.delegate = self
        scrollView!.isScrollEnabled = true
        scrollView!.contentSize = CGSize(width: viewWidth, height: contentHeight + 20)
        scrollView!.showsVerticalScrollIndicator = false
        scrollView!.dropShadow()
        
        // Images view
        colorView = UIView()
        colorView!.frame = CGRect(x: -(scrollView!.frame.width - 20), y: 5.0, width: scrollView!.frame.width - 10, height: contentHeight)
        colorView!.layer.cornerRadius = 8
        colorView!.backgroundColor = .purple
        colorView!.clipsToBounds = true
        colorView!.isUserInteractionEnabled = true
        
        // Create Template Array
        var templateButtons: [UIButton] = []
        
        // Create a clear template button in the list
        let clearTemplateButton = UIButton()
        clearTemplateButton.setImage(#imageLiteral(resourceName: "X"), for: .normal)
        clearTemplateButton.imageView?.contentMode = .scaleAspectFit
        clearTemplateButton.imageEdgeInsets = UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0)
        clearTemplateButton.backgroundColor = .white
        clearTemplateButton.addTarget(self, action: #selector(removeTemplate), for: .touchUpInside)
        
        // Add the clear template button at the top of the list
        templateButtons.append(clearTemplateButton)
        
        if let links = links {
            for link in links {
                let button = URLTemplateButton(url: link)
                button.withImageDownloadedFrom(link: link)
                button.backgroundColor = .white
                button.addTarget(self, action: #selector(templateButtonPressed(sender:)), for: .touchUpInside)
                templateButtons.append(button)
            }
        } else if let images = images {
            for image in images {
                let button = ImageTemplateButton(image: image)
                button.setImage(image, for: .normal)
                button.backgroundColor = .white
                button.addTarget(self, action: #selector(templateButtonPressed(sender:)), for: .touchUpInside)
                templateButtons.append(button)
            }
        }
        
        // Create Stack View
        // Make stackview with all template buttons
        let templateStackView = UIStackView(arrangedSubviews: templateButtons)
        let stackSpacing: CGFloat = 10.0
        let stackWidth: CGFloat = colorView!.frame.width - 20
        
        // Stackview properties
        templateStackView.axis = .vertical
        templateStackView.distribution = .fillEqually
        templateStackView.alignment = .center
        templateStackView.translatesAutoresizingMaskIntoConstraints = false
        templateStackView.spacing = stackSpacing
        
        // Add stackview to view
        colorView!.addSubview(templateStackView)
        
        templateStackView.leftAnchor.constraint(equalTo: colorView!.leftAnchor, constant: 10).isActive = true
        templateStackView.rightAnchor.constraint(equalTo: colorView!.rightAnchor, constant: -10).isActive = true
        templateStackView.topAnchor.constraint(equalTo: colorView!.topAnchor, constant: 10).isActive = true
        templateStackView.bottomAnchor.constraint(equalTo: colorView!.bottomAnchor, constant: -10).isActive = true
        
        templateStackView.heightAnchor.constraint(equalToConstant: contentHeight - 20).isActive = true
        
        templateStackView.widthAnchor.constraint(equalToConstant: stackWidth).isActive = true
        
        // Add templateStackView to the scroll view
        scrollView!.addSubview(colorView!)
        // Add the scroll view to the view
        view.addSubview(scrollView!)
    }
}
