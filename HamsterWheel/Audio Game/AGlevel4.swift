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

class AGlevel4: SKScene {
    
    let slices = [ HWheelSlice(title: "Cow"),
                   HWheelSlice(title: "Dog"),
                   HWheelSlice(title: "Cat"),
                   HWheelSlice(title: "Duck"),
                   HWheelSlice(title: "Sheep"),
                   HWheelSlice(title: "Hamster"),
                   HWheelSlice(title: "Horse")]
    
    var wheel: TTFortuneWheel?
    var audio: AVAudioPlayer?
    
    var menuButton: SKButton!
    var backButton: SKButton!
    
    override func didMove(to view: SKView) {
        // Adds the rotating wheel
        addWheel(view: view, width: 350, height: 350)
        // Adds the spin button and the wheel frame
        addWheelImages(view: view)
        addSpinButton(view: view)
        
        setupHomeButton()
        setupBackButton()
    }
    
    // MARK: UI setup
    
    func setupHomeButton() {
        /* Set UI connections */
        menuButton = self.childNode(withName: "menuButton") as! SKButton
        
        /* Setup button selection handler for homescreen */
        menuButton.selectedHandler = { [unowned self] in
            if let view = self.view {
                
                if let scene = SKScene(fileNamed: "MainMenuScene") {
                    
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view.presentScene(scene)
                }
                
                // Debug helpers
                view.showsFPS = true
                view.showsPhysics = true
                view.showsDrawCount = true
            }
        }
    }
    
    func setupBackButton() {
        /* Set UI connections */
        backButton = self.childNode(withName: "backButton") as! SKButton
        
        /* Setup button selection handler for homescreen */
        backButton.selectedHandler = { [unowned self] in
            if let view = self.view {
                
                // FIXME: Load the SKScene from before. Hard Code this until I figure out an algorithm.
                if let scene = SKScene(fileNamed: "AGlevel3") {
                    
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view.presentScene(scene)
                }
                
                // Debug helpers
                view.showsFPS = true
                view.showsPhysics = true
                view.showsDrawCount = true
            }
        }
    }
    
    // MARK: Wheel
    
    // MARK: UI
    
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
    // MARK: Functionality
    
    // Start the wheel spinning
    @objc func spinWheel() {
        if let wheel = wheel {
            wheel.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                let index = self.randomIndex()
                self.wheel?.startAnimating(fininshIndex: index) { (finished) in
                    self.playSoundForIndex(index: index)
                }
            }
        }
    }
    
    // Play sound
    func playSoundForIndex(index: Int) {
        var sound = String()
        var extention = String()
        print(index)
        switch self.slices[index].title {
        case "Dog":     sound = "dogBark";          extention = ".wav"
        case "Cow":     sound = "cowMoo";           extention = ".mp3"
        case "Cat":     sound = "catMeow";          extention = ".wav"
        case "Duck":    sound = "duckQuacking";     extention = ".wav"
        case "Sheep":   sound = "sheepBaa";         extention = ".wav"
        case "Hamster": sound = "rooster";          extention = ".wav"
        case "Horse":   sound = "horseWhinnying";   extention = ".wav"
        default:        sound  = "cartoon_voice_says_yahoo"; extention = ".mp3"
        }
        self.playAudio(soundName: sound, soundExtention: extention)
    }
    
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
    
    // Generates a random index based on the length of the slices array
    func randomIndex() -> Int {
        let max = slices.count
        let index = Int(arc4random_uniform(UInt32(max)))
        return index
    }
}
