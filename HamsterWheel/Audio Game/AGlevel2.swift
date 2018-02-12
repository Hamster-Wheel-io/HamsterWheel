//
//  AGlevel2.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 2/1/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import SpriteKit
import TTFortuneWheel
import AVFoundation

class AGlevel2: SKScene {
    
    let slices = [ HWheelSlice(title: "Cow"),
                   HWheelSlice(title: "Dog"),
                   HWheelSlice(title: "Duck"),
                   HWheelSlice(title: "Pig"),
                   HWheelSlice(title: "Cat")]
    
    var wheel: TTFortuneWheel?
    var audio: AVAudioPlayer?
    var homeButton: SKButton!
    
    override func didMove(to view: SKView) {
        // Adds the rotating wheel
        addWheel(view: view, width: 337, height: 337)
        // Adds the spin button and the wheel frame
        addWheelImages(view: view)
        addSpinButton(view: view)
    }
    
    // Add both the wheel frame and spin button to the view
    func addWheelImages(view: SKView) {
        // Adds the wheel frame
        addImageToCenter(x: view.bounds.midX, y: view.bounds.midY + 10, height: 382, width: 365, image: #imageLiteral(resourceName: "wheelFrame"))
        // adds the spin button image
        addImageToCenter(x: view.bounds.midX, y: view.bounds.midY + 10, height: 150, width: 150, image: #imageLiteral(resourceName: "spin"))
    }
    
    // Adds the rotating wheel to the view
    func addWheel(view: SKView, width: CGFloat, height: CGFloat) {
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
    
    func navigateToHomeScreen() {
        let home = MainMenuScene(fileNamed: "MainMenuScreen")
        home?.scaleMode = .aspectFill
        self.view?.presentScene(home!)
        print("did navigate to home")
    }
    
    // Start the wheel spinning
    @objc func spinWheel() {
        if let wheel = wheel {
            wheel.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                let index = self.randomIndex()
                self.wheel?.startAnimating(fininshIndex: index) { (finished) in
                    // TODO: Change sound
                    self.playAudio(soundName: "cartoon_voice_says_yahoo", soundExtention: ".mp3")
                }
            }
        }
    }
    
    // Play sound
    func playAudio(soundName: String, soundExtention: String) {
        // Fetch the sound data set.
        if let asset = NSDataAsset(name: soundName) {
            do {
                // Use NSDataAssets's data property to access the audio file stored in cartoon voice says yahoo.
                audio = try AVAudioPlayer(data: asset.data, fileTypeHint: soundExtention)
                // Play the above sound file
                audio?.play()
            } catch let error as NSError {
                // Should print...
                print(error.localizedDescription)
            }
        }
    }
    
    // Adds the center Spin button to the view
    func addSpinButton(view: SKView) {
        let btn = UIButton()
        btn.frame = CGRect(x: view.bounds.midX,
                           y: view.bounds.midY + 10,
                           width: 100,
                           height: 100)
        btn.center = CGPoint(x: view.bounds.midX,
                             y: view.bounds.midY)
        
        
        btn.setTitle("SPIN", for: .normal)
        btn.setTitleColor(.yellow, for: .normal)
        btn.titleLabel?.font = UIFont(name: "AmericanTypewriter-Bold", size: 22)
        btn.addTarget(self, action: #selector(spinWheel), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    // Adds an image to the view on the given location
    func addImageToCenter(x: CGFloat, y: CGFloat, height: CGFloat, width: CGFloat, image: UIImage) {
        let imageView = UIImageView(frame: CGRect(x: x,
                                                  y: y,
                                                  width: width,
                                                  height: height))
        imageView.center = CGPoint(x: x, y: y)
        
        imageView.image = image
        view?.addSubview(imageView)
    }
    
    // Generates a random index based on the length of the slices array
    func randomIndex() -> Int {
        let max = slices.count
        let index = Int(arc4random_uniform(UInt32(max)))
        return index
    }
}
