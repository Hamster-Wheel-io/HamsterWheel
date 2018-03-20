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
    var backButton: UIButton!
    var undoButton: UIButton!
    
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
    }
    
    func setupButtons() {
        // Generates an array of color buttons
        generateColorButtons()
        
        // Add the array of buttons to the view
        addColorButtons()
        
        // Add back, undo and clear button
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
    
    func addLeftButtons() {
        
        // Navigation Button
        backButton = UIButton(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
        backButton.clipsToBounds = true
        backButton.setImage(#imageLiteral(resourceName: "homeButton"), for: .normal)
        backButton.addTarget(self, action: #selector(backToMainMenu), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        // Game buttons
        deleteButton = UIButton(frame: CGRect(x: 10, y: 70, width: 50, height: 50))
        deleteButton.setImage(#imageLiteral(resourceName: "xButton"), for: .normal)
        deleteButton.clipsToBounds = true
        deleteButton.addTarget(self, action: #selector(deleteDrawing), for: .touchUpInside)
        self.view.addSubview(deleteButton)
        
        undoButton = UIButton(frame: CGRect(x: 10, y: 130, width: 50, height: 50))
        undoButton.setImage(#imageLiteral(resourceName: "leftArrow"), for: .normal)
        undoButton.clipsToBounds = true
        undoButton.addTarget(self, action: #selector(undo), for: .touchUpInside)
        self.view.addSubview(undoButton)
        
        // Indicates the selected color
        colorIndicator = UIView(frame: CGRect(x: 10, y: 190, width: 50, height: 50))
        colorIndicator!.layer.borderWidth = 3
        colorIndicator!.layer.borderColor = UIColor.black.cgColor
        colorIndicator!.backgroundColor = .green
        colorIndicator!.layer.cornerRadius = colorIndicator!.frame.width * 0.5
        self.view.addSubview(colorIndicator!)
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
                self.backButton.alpha = 0.0
                self.deleteButton.alpha = 0.0
                self.undoButton.alpha = 0.0
                self.colorIndicator?.alpha = 0.0
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.backButton.alpha = 0.0
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
                self.backButton.alpha = 1.0
                self.deleteButton.alpha = 1.0
                self.undoButton.alpha = 1.0
                self.colorIndicator?.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.backButton.alpha = 1.0
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
