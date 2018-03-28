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
        // Add the array of buttons to the view
        generateColorButtons()
        addColorButtons()
        
        // Add back, undo and clear button
        generateNavigationButtons()
        addNavButtons()
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
        
        if self.view.frame.width > 750 && self.view.frame.width < 1242 {
            print("iPhoneX")
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
    
    
    func generateNavigationButtons() {
        // Navigation Button
        homeButton = UIButton()
        homeButton.clipsToBounds = true
        homeButton.setImage(#imageLiteral(resourceName: "homeButton"), for: .normal)
        homeButton.addTarget(self, action: #selector(backToMainMenu), for: .touchUpInside)
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        navigationButtons.append(homeButton)
        
        deleteButton = UIButton()
        deleteButton.setImage(#imageLiteral(resourceName: "xButton"), for: .normal)
        deleteButton.clipsToBounds = true
        deleteButton.contentMode = .scaleToFill
        deleteButton.addTarget(self, action: #selector(deleteDrawing), for: .touchUpInside)
        navigationButtons.append(deleteButton)
        
        undoButton = UIButton()
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
        // self.view.addSubview(colorIndicator!)
    }
    
    func addNavButtons() {
        /* Game buttons
         Set StackView height related to the parent view height
         StackView width related to the StackView height to keep the aspect ratio */
 
        let stackView = UIStackView(arrangedSubviews: navigationButtons)
        var stackHeight: CGFloat = 0.0
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            if self.view.frame.width > 750 && self.view.frame.width < 1242 {
                print("iPhoneX")
                stackHeight = self.view.frame.width / 6
            }
            stackHeight = self.view.frame.width / 5
            
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            print("iPad")
            stackHeight = self.view.frame.width / 5.5
        }
        
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        // Autolayout constraints
        let stackSpacing: CGFloat = 10
        stackView.spacing = stackSpacing
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16).isActive = true
        
        if self.view.frame.width > 750 && self.view.frame.width < 1242 {
            print("iPhoneX")
            if #available(iOS 11.0, *) {
                stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: -40).isActive = true
            } else {
                // Fallback on earlier versions
                stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
            }
        }

        stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: (stackHeight - (stackSpacing * 2))/3.0).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: stackHeight).isActive = true
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
    
    @objc func undo() { drawView.removeLastLine() }
    @objc func deleteDrawing() { drawView.clearCanvas() }
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
    func SwiftyDrawDidCancelDrawing(view: SwiftyDrawView) {}
    func SwiftyDrawIsDrawing(view: SwiftyDrawView) {}
}

extension UIButton {
    override open var intrinsicContentSize: CGSize {
        let intrinsicContentSize = super.intrinsicContentSize
        let adjustedWidth = intrinsicContentSize.width
        let adjustedHeight = intrinsicContentSize.height
        return CGSize(width: adjustedWidth, height: adjustedHeight)
    }
}

extension UIDevice {
    
    var isIphoneX: Bool {
        if #available(iOS 11.0, *), isIphone {
            if isLandscape {
                if let leftPadding = UIApplication.shared.keyWindow?.safeAreaInsets.left, leftPadding > 0 {
                    return true
                }
                if let rightPadding = UIApplication.shared.keyWindow?.safeAreaInsets.right, rightPadding > 0 {
                    return true
                }
            } else {
                if let topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.top, topPadding > 0 {
                    return true
                }
                if let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom, bottomPadding > 0 {
                    return true
                }
            }
        }
        return false
    }
    
    var isLandscape: Bool {
        return UIDeviceOrientationIsLandscape(orientation) || UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation)
    }
    
    var isPortrait: Bool {
        return UIDeviceOrientationIsPortrait(orientation) || UIInterfaceOrientationIsPortrait(UIApplication.shared.statusBarOrientation)
    }
    
    var isIphone: Bool {
        return self.userInterfaceIdiom == .phone
    }
    
    var isIpad: Bool {
        return self.userInterfaceIdiom == .pad
    }
}
