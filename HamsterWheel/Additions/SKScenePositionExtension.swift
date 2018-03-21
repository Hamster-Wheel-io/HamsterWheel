//
//  SKScenePositionExtension.swift
//  HamsterWheel
//
//  Created by Phyllis Wong on 3/20/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import SpriteKit

extension SKScene {
    
    //
    // Given a point where the y property is a distance from the top of the view,
    // returns a point in the scene coordinate system for that location.
    //
    func positionFromTop(_ pt: CGPoint) -> CGPoint {
        
        var result = pt
        result.y = viewTop() - result.y
        return result
    }
    
    //
    // Given a point where the y property is a distance from the bottom of the view,
    // returns a point in the scene coordinate system for that location.
    //
    func positionFromBottom(_ pt: CGPoint) -> CGPoint {
        
        var result = pt
        result.y += viewBottom()
        return result
    }
    
    //
    // Returns the y position of the view's top edge in the scene coordinate system
    //
    func viewTop() -> CGFloat {
        
        return convertPoint(fromView: CGPoint.zero).y
    }
    
    //
    // Returns the y position of the view's bottom edge in the scene coordinate system
    //
    func viewBottom() -> CGFloat {
        
        guard let view = view else { return 0.0 }
        
        return convertPoint(fromView: CGPoint(x: 0.0, y: view.bounds.size.height)).y
    }
    
    /*
     Extends the view to the edges of the frame
     Avoiding letter boxing (black bars top and bottom)
     */
    func sceneDidLayoutSubviews() {
        let skView = self.view!
        if let scene = skView.scene {
            var size = scene.size
            let newHeight = skView.bounds.size.height / skView.bounds.width * size.width
            if newHeight > size.height {
                scene.anchorPoint = CGPoint(x: 0, y: (newHeight - scene.size.height) / 2.0 / newHeight)
                size.height = newHeight
                scene.size = size
            }
        }
    }
}
