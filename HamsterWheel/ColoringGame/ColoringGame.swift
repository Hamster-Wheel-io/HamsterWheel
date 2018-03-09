////
////  ColoringGame.swift
////  HamsterWheel
////
////  Created by Bob De Kort on 3/6/18.
////  Copyright © 2018 Bob De Kort. All rights reserved.
////
//
//import UIKit
//import SpriteKit
//import SwiftyDraw
//
//class ColoringGame: SKScene {
//    var drawView: SwiftyDrawView!
//
//    // Color Buttons
//    var yellowButton : ColorButton!
//    var orangeButton : ColorButton!
//    var redButton : ColorButton!
//    var greenButton : ColorButton!
//    var blueButton : ColorButton!
//    var purpleButton : ColorButton!
//    var brownButton : ColorButton!
//    var blackButton : ColorButton!
//
//
//    // Utility Butttons
//    var eraser: SKButton!
//    var clear: SKButton!
//    var undo: SKButton!
//
//    override func didMove(to view: SKView) {
//        setupDrawingView()
//        setupColorButtons()
//    }
//
//    func setupDrawingView() {
//        if let view = self.view {
//            drawView = SwiftyDrawView(frame: view.frame)
//
//            drawView.backgroundColor = .white
//            drawView.layer.zPosition = 1
//
//            view.addSubview(drawView)
//            //view.insertSubview(drawView, belowSubview: yellowButton.inputView)
//        }
//    }
//
//    func setupColorButtons() {
//        yellowButton = self.childNode(withName: "yellowButton") as! ColorButton
//        yellowButton.selectionColor = UIColor.yellow
//        yellowButton.selectedHandler = { [unowned self] in
//            self.colorButtonPressed(button: self.yellowButton)
//        }
//
//        orangeButton = self.childNode(withName: "orangeButton") as! ColorButton
//        orangeButton.selectionColor = UIColor.orange
//        orangeButton.selectedHandler = { [unowned self] in
//            self.colorButtonPressed(button: self.orangeButton)
//        }
//
//        redButton = self.childNode(withName: "redButton") as! ColorButton
//        redButton.selectionColor = UIColor.red
//        orangeButton.selectedHandler = { [unowned self] in
//            self.colorButtonPressed(button: self.redButton)
//        }
//
//        greenButton = self.childNode(withName: "greenButton") as! ColorButton
//        greenButton.selectionColor = UIColor.green
//        greenButton.selectedHandler = { [unowned self] in
//            self.colorButtonPressed(button: self.greenButton)
//        }
//
//        blueButton = self.childNode(withName: "blueButton") as! ColorButton
//        blueButton.selectionColor = UIColor.blue
//        blueButton.selectedHandler = { [unowned self] in
//            self.colorButtonPressed(button: self.blueButton)
//        }
//
//        purpleButton = self.childNode(withName: "purpleButton") as! ColorButton
//        purpleButton.selectionColor = UIColor.purple
//        purpleButton.selectedHandler = { [unowned self] in
//            self.colorButtonPressed(button: self.purpleButton)
//        }
//
//        brownButton = self.childNode(withName: "brownButton") as! ColorButton
//        brownButton.selectionColor = UIColor.brown
//        brownButton.selectedHandler = { [unowned self] in
//            self.colorButtonPressed(button: self.brownButton)
//        }
//
//        blackButton = self.childNode(withName: "blackButton") as! ColorButton
//        blackButton.selectionColor = UIColor.black
//        blackButton.selectedHandler = { [unowned self] in
//            self.colorButtonPressed(button: self.blackButton)
//        }
//    }
//
//    func colorButtonPressed(button: ColorButton) {
//        drawView.lineColor = button.selectionColor!
//    }
//}
//
//
