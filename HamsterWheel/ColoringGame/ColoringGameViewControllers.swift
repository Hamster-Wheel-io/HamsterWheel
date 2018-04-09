//
//  ColoringGameViewController.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 3/6/18.
//  Copyright © 2018 HamsterWheel. All rights reserved.
//
import UIKit
import SwiftyDraw
import SpriteKit

class ColoringGameViewController: UIViewController {
    
    // Color to be used as drawing colors
    let colorDictionary = [UIColor.yellow,
                           UIColor.orange,
                           UIColor.red,
                           UIColor.green,
                           UIColor.blue,
                           UIColor.purple]
    
    // Available templates, nil being an emty view to draw on
    let colorPages = [nil, #imageLiteral(resourceName: "fishPage"), #imageLiteral(resourceName: "babyAnimalsPage"), #imageLiteral(resourceName: "hamsterOnWheelPage")]
    
    // Drawing view
    var drawView: SwiftyDrawView!
    
    // Array of all the color buttons to be used
    var colorButtons: [UIButton] = []
    // Stack view for all color buttons
    var colorStackView: UIStackView?
    
    // Return to main menu button
    var homeButton: UIButton!
    
    // Utility Section
    var utilityButtons: [UIButton] = []     // Stores all buttons in the utility section
    var utilityStackView: UIStackView?      // Displays all buttons in the utility section
    
    var deleteButton : UIButton!            // Clear drawing
    var undoButton: UIButton!               // Undo last stroke
    var eraserButton: UIButton!             // Use a thick white stroke as the eraser
    var templateButton: UIButton!           // Loops over available templates
    var templateView: UIImageView?          // Used to display the templates
    
    // Used to determine next template
    var selectedTemplateIndex = 0
    
    var selectedColor: UIColor! {
        /*
         Sets the desired stroke width for the selected color.
         Sets the stroke color of the draw view to the selected color.
         */
        didSet {
            // Change the line stroke when selected color is white because it is the eraser.
            switch selectedColor {
            case UIColor.white?:
                drawView.lineWidth = 25
            default:
                drawView.lineWidth = 10
            }
            drawView.lineColor = selectedColor
        }
    }
    
    /*
     Used to create a border around the selected color button,
     Also takes into account that white is the eraser and should not get a border.
     */
    var selectedButton: UIButton? {
        didSet {
            if let prevButton = oldValue {
                if prevButton.backgroundColor != .white {
                    prevButton.layer.borderWidth = 3
                    prevButton.layer.borderColor = UIColor.gray.cgColor
                }
            }
            // Exclude white because it is the eraser
            if selectedColor != .white {
                if let button = selectedButton {
                    button.layer.borderWidth = 5
                    button.layer.borderColor = UIColor.black.cgColor
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // Initialize drawview
        drawView = SwiftyDrawView(frame: self.view.frame)
        drawView.delegate = self
        drawView.backgroundColor = .clear
        
        // Setup default values
        drawView.lineColor = .green
        selectedColor = .green
        
        // Display drawing view
        self.view.addSubview(drawView)
        /* Sets up:
                - Color buttons
                - Navigation buttons (home button)
                - Utility buttons
         */
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
        })
    }
    
    func SwiftyDrawDidFinishDrawing(view: SwiftyDrawView) {
        UIView.animate(withDuration: 0.3, animations: {
            self.colorStackView?.alpha = 1.0
            self.utilityStackView?.alpha = 1.0
            self.homeButton.alpha = 1.0
        })
    }
    
    // Needed to conform to SwiftyDrawViewDelegate, not being implemented
    func SwiftyDrawDidCancelDrawing(view: SwiftyDrawView) {}
    func SwiftyDrawIsDrawing(view: SwiftyDrawView) {}
}
