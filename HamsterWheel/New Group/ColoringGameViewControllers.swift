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

class ColoringGameViewController: UIViewController, SwiftyDrawViewDelegate {
    
    var drawView : SwiftyDrawView!
    var redButton : ColorButton!
    var greenButton : ColorButton!
    var blueButton : ColorButton!
    var orangeButton : ColorButton!
    var purpleButton : ColorButton!
    var yellowButton : ColorButton!
    
    var deleteButton : UIButton!
    var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawView = SwiftyDrawView(frame: self.view.frame)
        drawView.delegate = self
        drawView.backgroundColor = .white
        
        self.view.addSubview(drawView)
        addButtons()
    }
    
    func addButtons() {
        redButton = ColorButton(frame: CGRect(x: self.view.frame.width - 60, y: self.view.frame.height - 50, width: 40, height: 40), color: UIColor.red)
        redButton.addTarget(self, action: #selector(colorButtonPressed(button:)), for: .touchUpInside)
        self.view.addSubview(redButton)
        
        greenButton = ColorButton(frame: CGRect(x: self.view.frame.width - 60, y: self.view.frame.height - 100, width: 40, height: 40), color: UIColor.green)
        greenButton.addTarget(self, action: #selector(colorButtonPressed(button:)), for: .touchUpInside)
        self.view.addSubview(greenButton)
        
        blueButton = ColorButton(frame: CGRect(x: self.view.frame.width - 60, y: self.view.frame.height - 150, width: 40, height: 40), color: UIColor.blue)
        blueButton.addTarget(self, action: #selector(colorButtonPressed(button:)), for: .touchUpInside)
        self.view.addSubview(blueButton)
        
        orangeButton = ColorButton(frame: CGRect(x: self.view.frame.width - 60, y: self.view.frame.height - 200, width: 40, height: 40), color: UIColor.orange)
        orangeButton.addTarget(self, action: #selector(colorButtonPressed(button:)), for: .touchUpInside)
        self.view.addSubview(orangeButton)
        
        purpleButton = ColorButton(frame: CGRect(x: self.view.frame.width - 60, y: self.view.frame.height - 250, width: 40, height: 40), color: UIColor.purple)
        purpleButton.addTarget(self, action: #selector(colorButtonPressed(button:)), for: .touchUpInside)
        self.view.addSubview(purpleButton)
        
        yellowButton = ColorButton(frame: CGRect(x: self.view.frame.width - 60, y: self.view.frame.height - 300, width: 40, height: 40), color: UIColor.yellow)
        yellowButton.addTarget(self, action: #selector(colorButtonPressed(button:)), for: .touchUpInside)
        self.view.addSubview(yellowButton)
        
        backButton = UIButton(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
        backButton.clipsToBounds = true
        
        backButton.setImage(#imageLiteral(resourceName: "homeButton"), for: .normal)
        backButton.addTarget(self, action: #selector(backToMainMenu), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        deleteButton = UIButton(frame: CGRect(x: 10, y: 70, width: 50, height: 50))
        deleteButton.setImage(#imageLiteral(resourceName: "xButton"), for: .normal)
        deleteButton.clipsToBounds = true
        deleteButton.addTarget(self, action: #selector(deleteDrawing), for: .touchUpInside)
        self.view.addSubview(deleteButton)
    }
    
    @objc func backToMainMenu() {
        self.view = SKView()
        
        if let scene = SKScene(fileNamed: "MainMenuScene") {
            if let skView = self.view as? SKView {
                
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .aspectFill
                
                // TODO: Figure out how to transition nice
                skView.presentScene(scene, transition: .fade(withDuration: 1))
            } else {
                print("View is not a scene")
            }
        }
    }
    
    @objc func colorButtonPressed(button: ColorButton) {
        drawView.lineColor = button.color
    }
    
    @objc func undo() {
        drawView.removeLastLine()
    }
    
    @objc func deleteDrawing() {
        drawView.clearCanvas()
    }
    
    func SwiftyDrawDidBeginDrawing(view: SwiftyDrawView) {
        UIView.animate(withDuration: 0.5, animations: {
            self.redButton.alpha = 0.0
            self.blueButton.alpha = 0.0
            self.greenButton.alpha = 0.0
            self.orangeButton.alpha = 0.0
            self.purpleButton.alpha = 0.0
            self.yellowButton.alpha = 0.0
            self.backButton.alpha = 0.0
            self.deleteButton.alpha = 0.0
        })
    }
    
    func SwiftyDrawIsDrawing(view: SwiftyDrawView) {
        
    }
    
    func SwiftyDrawDidFinishDrawing(view: SwiftyDrawView) {
        UIView.animate(withDuration: 0.5, animations: {
            self.redButton.alpha = 1.0
            self.blueButton.alpha = 1.0
            self.greenButton.alpha = 1.0
            self.orangeButton.alpha = 1.0
            self.purpleButton.alpha = 1.0
            self.yellowButton.alpha = 1.0
            self.backButton.alpha = 1.0
            self.deleteButton.alpha = 1.0
        })
    }
    
    func SwiftyDrawDidCancelDrawing(view: SwiftyDrawView) {
        
    }
}
