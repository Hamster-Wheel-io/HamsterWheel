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
    
    let colorDictionary = [UIColor.yellow,
                           UIColor.orange,
                           UIColor.red,
                           UIColor.green,
                           UIColor.blue,
                           UIColor.purple]
    
    var drawView : SwiftyDrawView!
    
    var colorButtons: [UIButton] = []
    var colorStackView: UIStackView?
    
    var homeButton: UIButton!
    // TODO: Remove
    var navigationButtons: [UIButton] = []
    var navigationStackView: UIStackView?
    
    var deleteButton : UIButton!
    var undoButton: UIButton!
    var eraserButton: UIButton!
    var templateButton: UIButton!
    var hasTemplate: Bool = false
    
    var utilityButtons: [UIButton] = []
    var utilityStackView: UIStackView?
    
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
    
    var selectedButton: UIButton? {
        didSet {
            // Exclude white because it is the eraser
            if selectedColor != .white {
                if let prevButton = oldValue {
                    if prevButton.backgroundColor != .white {
                        prevButton.layer.borderWidth = 3
                        prevButton.layer.borderColor = UIColor.gray.cgColor
                    }
                }
                if let button = selectedButton {
                    button.layer.borderWidth = 5
                    button.layer.borderColor = UIColor.black.cgColor
                }
            }
        }
    }
    
    var templateView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        // Initialize drawview
        drawView = SwiftyDrawView(frame: self.view.frame)
        drawView.delegate = self
        drawView.backgroundColor = .clear
        
        drawView.lineColor = .green
        selectedColor = .green
        
        self.view.addSubview(drawView)
        setupButtons()
    }
    
    func setupButtons() {
        // Generates an array of color buttons
        // Add the array of buttons to the view using a stackview
        generateColorButtons()
        addColorButtons()
        
        // Add home button
        addHomeButton()
        
        // Setup utility buttons
        setupUtilityButtons()
        addUtilityButtons()
    }
    
    func addHomeButton() {
        // Navigation Button
        homeButton = UIButton()
        homeButton.clipsToBounds = true
        homeButton.setImage(#imageLiteral(resourceName: "homeButton"), for: .normal)
        homeButton.addTarget(self, action: #selector(backToMainMenu), for: .touchUpInside)
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(homeButton)
        
        homeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16).isActive = true
        homeButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        let width = (self.view.frame.width / 5) / 3
        homeButton.heightAnchor.constraint(equalToConstant: width).isActive = true
        homeButton.widthAnchor.constraint(equalToConstant: width).isActive = true
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
    
    @objc func undo() { drawView.removeLastLine() }
    @objc func deleteDrawing() { drawView.clearCanvas() }
}


extension ColoringGameViewController: SwiftyDrawViewDelegate {
    
    func SwiftyDrawDidBeginDrawing(view: SwiftyDrawView) {
        UIView.animate(withDuration: 0.3, animations: {
            self.colorStackView?.alpha = 0.0
            self.utilityStackView?.alpha = 0.0
            self.homeButton.alpha = 0.0
            self.colorIndicator?.alpha = 0.0
        })
    }
    
    func SwiftyDrawDidFinishDrawing(view: SwiftyDrawView) {
        UIView.animate(withDuration: 0.3, animations: {
            self.colorStackView?.alpha = 1.0
            self.utilityStackView?.alpha = 1.0
            self.homeButton.alpha = 1.0
            self.colorIndicator?.alpha = 1.0
        })
    }
    
    // Needed to conform to SwiftyDrawViewDelegate, not being implemented
    func SwiftyDrawDidCancelDrawing(view: SwiftyDrawView) {}
    func SwiftyDrawIsDrawing(view: SwiftyDrawView) {}
}
