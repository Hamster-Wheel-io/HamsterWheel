//
//  HWheelSlise.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 2/9/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import TTFortuneWheel

public class HWheelSlice: FortuneWheelSliceProtocol {
    
    public enum Style {
        case brickRed
        case sandYellow
        case babyBlue
        case deepBlue
    }
    
    public var title: String
    public var degree: CGFloat = 0.0
    
    
    public var backgroundColor: UIColor? {
        switch style {
        case .brickRed: return TTUtils.uiColor(from:0xE27230)
        case .sandYellow: return TTUtils.uiColor(from:0xF7D565)
        case .babyBlue: return TTUtils.uiColor(from:0x93D0C4)
        case .deepBlue: return TTUtils.uiColor(from:0x2A7F7F)
        }
    }
    
    public var fontColor: UIColor {
        return UIColor.white
    }
    
    public var offsetFromExterior:CGFloat {
        return 10.0
    }
    
    public var font: UIFont {
        switch style {
        case .brickRed: return UIFont(name: "AmericanTypewriter-Bold", size: 22.0)!
        case .sandYellow: return UIFont(name: "AmericanTypewriter-Bold", size: 22.0)!
        case .babyBlue: return UIFont(name: "AmericanTypewriter-Bold", size: 22.0)!
        case .deepBlue: return UIFont(name: "AmericanTypewriter-Bold", size: 22.0)!
        }
    }
    
    public var stroke: StrokeInfo? {
        return StrokeInfo(color: UIColor.white, width: 1.0)
    }
    
    public var style:Style = .brickRed
    
    public init(title:String) {
        self.title = title
    }
    
    public convenience init(title:String, degree:CGFloat) {
        self.init(title:title)
        self.degree = degree
    }
    
    public func drawAdditionalGraphics(in context:CGContext, circularSegmentHeight:CGFloat,radius:CGFloat,sliceDegree:CGFloat) {
        var image: UIImage?
        // TODO: Change images
        switch title {
        case "Cow":
            image = UIImage(named: "cowHead")
        case "Dog":
            image = UIImage(named: "cowHead")
        case "Duck":
            image = UIImage(named: "cowHead")
        case "Pig":
            image = UIImage(named: "cowHead")
        case "Cat":
            image = UIImage(named: "cowHead")
        default:
            return
        }
        if let image = image {
            let centerOffset = CGPoint(x: -150, y: -20)
            let additionalGraphicRect = CGRect(x: centerOffset.x, y: centerOffset.y, width: 75, height: 60)
            let additionalGraphicPath = UIBezierPath(rect: additionalGraphicRect)
            context.saveGState()
            additionalGraphicPath.addClip()
            context.scaleBy(x: 1, y: -1)
            context.draw(image.cgImage!, in: CGRect(x: additionalGraphicRect.minX, y: -additionalGraphicRect.minY, width: additionalGraphicRect.width, height: additionalGraphicRect.height), byTiling: true)
            context.restoreGState()

        }
    }
}
