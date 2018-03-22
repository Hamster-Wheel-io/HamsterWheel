//
//  ColoringGameViewController.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 3/6/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//
import UIKit
import SwiftyDraw
import SpriteKit

class ColoringGameViewController: UIViewController {
    
    let colorDictionary = [UIColor.white,
                           UIColor.yellow,
                           UIColor.orange,
                           UIColor.red,
                           UIColor.purple,
                           UIColor.blue,
                           UIColor.green]
    
    var drawView : SwiftyDrawView!
    
    var colorButtons: [UIButton] = []
    var colorStackView: UIStackView?
    
    var deleteButton : UIButton!
    var homeButton: UIButton!
    var undoButton: UIButton!
    var navigationButtons: [UIButton] = []
    var navigationStackView: UIStackView?
    
//    var widthMultiplier = 0.0
//    var heightMultiplier = 0.0
    
    var colorIndicator: UIView?
    
    var selectedColor: UIColor! {
        didSet {
            switch selectedColor {
            case UIColor.white?:
                drawView.lineWidth = 25
            default:
                drawView.lineWidth = 10
            }
            
            colorIndicator?.backgroundColor = selectedColor
            drawView.lineColor = selectedColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawView = SwiftyDrawView(frame: self.view.frame)
        drawView.lineColor = .green
        selectedColor = .green
        drawView.delegate = self
        drawView.backgroundColor = .white
        
        self.view.addSubview(drawView)
        setupButtons()
        
//        // Size for the SE Logical Resolution
//        widthMultiplier = Double(self.view.frame.size.width) / 320
//        heightMultiplier = Double(self.view.frame.size.height) / 568
        
    }
    
    func setupButtons() {
        // Generates an array of color buttons
        generateColorButtons()
        
        // Add the array of buttons to the view
        addColorButtons()
        
        // Add back, undo and clear button
        generateNavigationButtons()
        addLeftButtons()
    }
    
    func colorButton(withColor color: UIColor) -> UIButton {
        let newButton = UIButton(type: .system)
        
        // Design
        newButton.backgroundColor = color
        newButton.layer.borderWidth = 3
        newButton.layer.borderColor = UIColor.black.cgColor
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
        stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func generateNavigationButtons() {
        // Navigation Button
        homeButton = UIButton(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        homeButton.clipsToBounds = true
        homeButton.setImage(#imageLiteral(resourceName: "homeButton"), for: .normal)
        homeButton.addTarget(self, action: #selector(backToMainMenu), for: .touchUpInside)
        navigationButtons.append(homeButton)
        
        deleteButton = UIButton(frame: CGRect(x: 10, y: 50, width: 30, height: 30))
        deleteButton.setImage(#imageLiteral(resourceName: "xButton"), for: .normal)
        deleteButton.clipsToBounds = true
        deleteButton.contentMode = .scaleToFill
        deleteButton.addTarget(self, action: #selector(deleteDrawing), for: .touchUpInside)
        navigationButtons.append(deleteButton)
        
        undoButton = UIButton(frame: CGRect(x: 10, y: 90, width: 30, height: 30))
        undoButton.setImage(#imageLiteral(resourceName: "backButton"), for: .normal)
        undoButton.clipsToBounds = true
        undoButton.addTarget(self, action: #selector(undo), for: .touchUpInside)
        navigationButtons.append(undoButton)
        
        // Indicates the selected color
        colorIndicator = UIView(frame: CGRect(x: 10, y: 130, width: 30, height: 30))
        colorIndicator!.layer.borderWidth = 3
        colorIndicator!.layer.borderColor = UIColor.black.cgColor
        colorIndicator!.backgroundColor = .green
        colorIndicator!.layer.cornerRadius = colorIndicator!.frame.width * 0.5
        self.view.addSubview(colorIndicator!)
    }
    
    func addLeftButtons() {
        // Game buttons
        /*
         FIXME: Add buttons in a stack view
         Give one button a height constraint
        */
        let stackView = UIStackView(arrangedSubviews: navigationButtons)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        // stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -200).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        
    }
    
    @objc func colorButtonPressed(button: ColorButton) {
        if let color = button.backgroundColor {
            selectedColor = color
        } else {
            selectedColor = .green
        }
    }
    
    @objc func backToMainMenu() {
        self.view = SKView()
        
        if let scene = SKScene(fileNamed: "MainMenuScene") {
            if let skView = self.view as? SKView {
                
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .aspectFit
                
                // TODO: Figure out how to transition nice
                skView.presentScene(scene, transition: .fade(withDuration: 1))
            } else {
                print("View is not a scene")
            }
        }
    }
    
    @objc func undo() {
        drawView.removeLastLine()
    }
    
    @objc func deleteDrawing() {
        drawView.clearCanvas()
    }
}


extension ColoringGameViewController: SwiftyDrawViewDelegate {
    
    func SwiftyDrawDidBeginDrawing(view: SwiftyDrawView) {
        if let stackView = colorStackView {
            UIView.animate(withDuration: 0.3, animations: {
                stackView.alpha = 0.0
                self.homeButton.alpha = 0.0
                self.deleteButton.alpha = 0.0
                self.undoButton.alpha = 0.0
                self.colorIndicator?.alpha = 0.0
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.homeButton.alpha = 0.0
                self.deleteButton.alpha = 0.0
                self.undoButton.alpha = 0.0
                self.colorIndicator?.alpha = 0.0
            })
        }
    }
    
    func SwiftyDrawDidFinishDrawing(view: SwiftyDrawView) {
        if let stackView = colorStackView {
            UIView.animate(withDuration: 0.3, animations: {
                stackView.alpha = 1.0
                self.homeButton.alpha = 1.0
                self.deleteButton.alpha = 1.0
                self.undoButton.alpha = 1.0
                self.colorIndicator?.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.homeButton.alpha = 1.0
                self.deleteButton.alpha = 1.0
                self.undoButton.alpha = 1.0
                self.colorIndicator?.alpha = 1.0
            })
        }
    }
    
    // Needed to conform to SwiftyDrawViewDelegate, not being implemented
    func SwiftyDrawDidCancelDrawing(view: SwiftyDrawView) {
        
    }
    
    func SwiftyDrawIsDrawing(view: SwiftyDrawView) {
        
    }
}
