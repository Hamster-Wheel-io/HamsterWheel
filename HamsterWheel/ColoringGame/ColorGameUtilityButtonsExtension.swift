//
//  ColorGameUtilityButtonsExtension.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 3/27/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

extension ColoringGameViewController {
    func setupUtilityButtons() {
        // Clear the whole drawing
        deleteButton = UIButton()
        deleteButton.setImage(#imageLiteral(resourceName: "xButton"), for: .normal)
        deleteButton.clipsToBounds = true
        deleteButton.contentMode = .scaleToFill
        deleteButton.addTarget(self, action: #selector(deleteDrawing), for: .touchUpInside)
        utilityButtons.append(deleteButton)
        
        // Undo last drawn line
        undoButton = UIButton()
        // TODO: Change undo asset
        undoButton.setImage(#imageLiteral(resourceName: "backButton"), for: .normal)
        undoButton.clipsToBounds = true
        undoButton.addTarget(self, action: #selector(undo), for: .touchUpInside)
        utilityButtons.append(undoButton)
        
        // Use a white color as an eraser
        eraserButton = UIButton()
        eraserButton.clipsToBounds = true
        eraserButton.backgroundColor = .white
        eraserButton.setImage(#imageLiteral(resourceName: "homeButton"), for: .normal)
        eraserButton.addTarget(self, action: #selector(colorButtonPressed(button:)), for: .touchUpInside)
        utilityButtons.append(eraserButton)
        
        // Add template
        templateButton = UIButton()
        templateButton.setImage(#imageLiteral(resourceName: "homeButton"), for: .normal)
        templateButton.clipsToBounds = true
        templateButton.addTarget(self, action: #selector(toggleTemplate), for: .touchUpInside)
        utilityButtons.append(templateButton)
    }
    
    func addUtilityButtons() {
        // Make stackview with all utility buttons
        utilityStackView = UIStackView(arrangedSubviews: utilityButtons)
        let stackHeight: CGFloat = (self.view.frame.width / 5) / 3
        let stackSpacing: CGFloat = 10.0
        var stackWidth: CGFloat = 0.0
        
        if let utilityStackView = utilityStackView {
            // Stackview properties
            utilityStackView.axis = .horizontal
            utilityStackView.distribution = .fillEqually
            utilityStackView.alignment = .center
            utilityStackView.translatesAutoresizingMaskIntoConstraints = false
            utilityStackView.spacing = stackSpacing
            
            // Add stackview to view
            self.view.addSubview(utilityStackView)
            
            utilityStackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
            utilityStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16).isActive = true
            utilityStackView.heightAnchor.constraint(equalToConstant: stackHeight).isActive = true
            
            stackWidth = (stackHeight * CGFloat(utilityButtons.count) + (stackSpacing * CGFloat(utilityButtons.count - 1)))
            utilityStackView.widthAnchor.constraint(equalToConstant: stackWidth).isActive = true
        }
    }
}
