//
//  ColorButtonExtension.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 3/27/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

extension ColoringGameViewController {
    
    func colorButton(withColor color: UIColor) -> UIButton {
        let newButton = UIButton(type: .system)
        
        // Design
        newButton.backgroundColor = color
        newButton.layer.borderWidth = 3
        newButton.layer.borderColor = UIColor.gray.cgColor
        newButton.clipsToBounds = true
        newButton.backgroundColor = color
        newButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Target
        newButton.addTarget(self, action: #selector(colorButtonPressed(button:)), for: .touchUpInside)
        return newButton
    }
    
    func generateColorButtons() {
        var buttonArray = [UIButton]()
        for item in colorDictionary {
            buttonArray.append(colorButton(withColor: item))
        }
        colorButtons = buttonArray
    }
    
    func addColorButtons() {
        let stackView = UIStackView(arrangedSubviews: colorButtons)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        colorStackView = stackView
        self.view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true
        
        if self.view.frame.width > 750 && self.view.frame.width < 1242 {
            if #available(iOS 11.0, *) {
                stackView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -12).isActive = true
            } else {
                // Fallback on earlier versions
                stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
            }
        }
        stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    @objc func colorButtonPressed(button: ColorButton) {
        // Sets the stroke color and stroke width in case of white
        if let color = button.backgroundColor {
            selectedColor = color
        } else {
            selectedColor = .green
        }
        
        // Set the newly selected button
        selectedButton = button
    }
}
