//
//  RandomWheelWheelExtension.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 3/22/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//
import SpriteKit
import TTFortuneWheel
import Foundation

extension RandomWheel {
    // MARK: Wheel
    
    // MARK: UI
    
    func addWheel(view: SKView) {
        // Adds the rotating wheel
        addTTWheel(view: view, width: view.bounds.height * 0.9, height: view.bounds.height * 0.9)
        
        // Adds the spin button and the wheel frame
        addWheelImages(view: view)
        addSpinButton(view: view)
    }
    
    // Add both the wheel frame and spin button to the view
    func addWheelImages(view: SKView) {
        // Adds the wheel frame
        frameImage = addImageToCenter(x: view.bounds.midX,
                                      y: view.bounds.midY,
                                      height: view.bounds.height * 0.92,
                                      width: view.bounds.height * 0.92,
                                      image: #imageLiteral(resourceName: "frameWButton"))
    }
    
    // Adds the rotating wheel to the view
    func addTTWheel(view: SKView, width: CGFloat, height: CGFloat) {
        // Define wheels frame
        let wheelFrame = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: width, height: height)
        
        // Initiate wheel
        let fortuneWheel = TTFortuneWheel(frame: wheelFrame, slices: slices)
        wheel = fortuneWheel
        
        // Set the center point of the wheel
        fortuneWheel.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        
        // Sets all the slices to equal sizes
        fortuneWheel.equalSlices = true
        
        // Has a black background by default so changing it to clear
        fortuneWheel.backgroundColor = UIColor.clear
        
        // Setting individual styles on the slices
        fortuneWheel.slices.enumerated().forEach { (pair) in
            let slice = pair.element as! HWheelSlice
            let offset = pair.offset
            switch offset % 4 {
            case 0: slice.style = .brickRed
            case 1: slice.style = .sandYellow
            case 2: slice.style = .babyBlue
            case 3: slice.style = .deepBlue
            default: slice.style = .brickRed
            }
        }
        
        // Add wheel to view
        view.addSubview(fortuneWheel)
    }
    
    func removeWheel() {
        wheel?.removeFromSuperview()
        frameImage?.removeFromSuperview()
        spinButtonImage?.removeFromSuperview()
        spinButton?.removeFromSuperview()
    }
    
    // Adds the center Spin button to the view
    func addSpinButton(view: SKView) {
        let btn = UIButton()
        btn.frame = CGRect(x: view.bounds.midX,
                           y: view.bounds.midY,
                           width: view.bounds.width * 0.7,
                           height: view.bounds.height)
        
        btn.addTarget(self, action: #selector(spinWheel), for: .touchUpInside)
        spinButton = btn
        view.addSubview(btn)
    }
    
    // Adds an image to the view on the given location
    func addImageToCenter(x: CGFloat, y: CGFloat, height: CGFloat, width: CGFloat, image: UIImage) -> UIImageView{
        let imageView = UIImageView(frame: CGRect(x: x,
                                                  y: y,
                                                  width: width,
                                                  height: height))
        imageView.center = CGPoint(x: x, y: y)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        view?.addSubview(imageView)
        return imageView
    }
}
