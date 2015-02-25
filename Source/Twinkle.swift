//
//  Twinkle.swift
//
//  Created by patrick piemonte on 2/20/15.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015-present patrick piemonte (http://patrickpiemonte.com/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit
import Foundation
import CoreGraphics

private let TwinkleLayerEmitterShapeKey = "circle"
private let TwinkleLayerEmitterModeKey = "surface"
private let TwinkleLayerRenderModeKey = "unordered"
private let TwinkleLayerMagnificationFilter = "linear"
private let TwinkleLayerMinificationFilter = "trilinear"

// MARK: - TwinkleLayer

class TwinkleLayer: CAEmitterLayer {
    
    // MARK: object lifecycle
    
    override init() {
        super.init()
        
        // this could be a lot better in terms of performance, but not today
        var twinkleImage: UIImage?
        let resourcePath: String? = NSBundle.mainBundle().resourcePath
        if let filePath = resourcePath?.stringByAppendingPathComponent("TwinkleImage") {
            twinkleImage = UIImage(contentsOfFile: filePath)!
        }

        let emitterCells: [CAEmitterCell] = [CAEmitterCell(), CAEmitterCell()]
        for cell in emitterCells {
            cell.birthRate = 8
            cell.lifetime = 1.25
            cell.lifetimeRange = 0
            cell.emissionRange = CGFloat(M_PI_4)
            cell.velocity = 2
            cell.velocityRange = 18
            cell.scale = 0.65
            cell.scaleRange = 0.7
            cell.scaleSpeed = 0.6
            cell.spin = 0.9
            cell.spinRange = CGFloat(M_PI)
            cell.color = UIColor(white: 1.0, alpha: 0.3).CGColor
            cell.alphaSpeed = -0.8
            cell.contents = twinkleImage?.CGImage
            cell.magnificationFilter = TwinkleLayerMagnificationFilter
            cell.minificationFilter = TwinkleLayerMinificationFilter
            cell.enabled = true
        }
        self.emitterCells = emitterCells

        self.emitterPosition = CGPointMake((bounds.size.width * 0.5), (bounds.size.height * 0.5))
        self.emitterSize = bounds.size
        
        self.emitterShape = TwinkleLayerEmitterShapeKey
        self.emitterMode = TwinkleLayerEmitterModeKey
        self.renderMode = TwinkleLayerRenderModeKey
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
}

// MARK: - TwinkleLayer animations

private let TwinkleLayerPositionAnimationKey = "positionAnimation"
private let TwinkleLayerTransformAnimationKey = "transformAnimation"
private let TwinkleLayerOpacityAnimationKey = "opacityAnimation"

extension TwinkleLayer {

    func addPositionAnimation() {
        CATransaction.begin()
        var keyFrameAnim = CAKeyframeAnimation(keyPath: "position")
        keyFrameAnim.duration = 0.3
        keyFrameAnim.additive = true
        keyFrameAnim.repeatCount = MAXFLOAT
        keyFrameAnim.removedOnCompletion = false
        keyFrameAnim.beginTime = CFTimeInterval(arc4random_uniform(1000) + 1) * 0.2 * 0.25 // random start time, non-zero
        let points: [NSValue] = [NSValue(CGPoint: CGPoint().twinkleRandom(0.25)),
                                 NSValue(CGPoint: CGPoint().twinkleRandom(0.25)),
                                 NSValue(CGPoint: CGPoint().twinkleRandom(0.25)),
                                 NSValue(CGPoint: CGPoint().twinkleRandom(0.25)),
                                 NSValue(CGPoint: CGPoint().twinkleRandom(0.25))]
        keyFrameAnim.values = points
        self.addAnimation(keyFrameAnim, forKey: TwinkleLayerPositionAnimationKey)
        CATransaction.commit()
    }
    
    func addRotationAnimation() {
        CATransaction.begin()
        var keyFrameAnim = CAKeyframeAnimation(keyPath: "transform")
        keyFrameAnim.duration = 0.3
        keyFrameAnim.valueFunction = CAValueFunction(name: kCAValueFunctionRotateZ)
        keyFrameAnim.additive = true
        keyFrameAnim.repeatCount = MAXFLOAT
        keyFrameAnim.removedOnCompletion = false
        keyFrameAnim.beginTime = CFTimeInterval(arc4random_uniform(1000) + 1) * 0.2 * 0.25 // random start time, non-zero
        let radians: Float = 0.104 // ~6 degrees
        keyFrameAnim.values = [-radians, radians, -radians]
        self.addAnimation(keyFrameAnim, forKey: TwinkleLayerTransformAnimationKey)
        CATransaction.commit()
    }
    
    func addFadeInOutAnimation(beginTime: CFTimeInterval) {
        CATransaction.begin()
        var fadeAnimation: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        fadeAnimation.fromValue = 0
        fadeAnimation.toValue = 1
        fadeAnimation.repeatCount = 2
        fadeAnimation.autoreverses = true // fade in then out
        fadeAnimation.duration = 0.4
        fadeAnimation.fillMode = kCAFillModeForwards
        fadeAnimation.beginTime = beginTime
        CATransaction.setCompletionBlock({
            self.removeFromSuperlayer()
        })
        self.addAnimation(fadeAnimation, forKey: TwinkleLayerOpacityAnimationKey)
        CATransaction.commit()
    }
    
}

// MARK: - CGPoint

extension CGPoint {

    func twinkleRandom(range: Float)->CGPoint {
        let x = Int(-range + (Float(arc4random_uniform(1000)) / 1000.0) * 2.0 * range)
        let y = Int(-range + (Float(arc4random_uniform(1000)) / 1000.0) * 2.0 * range)
        return CGPoint(x: x, y: y)
    }

}

// MARK: - UIView

extension UIView {

    func twinkle() {
        var twinkleLayers: [TwinkleLayer]! = []
        
        let upperBound: UInt32 = 10
        let lowerBound: UInt32 = 5
        let count: UInt = UInt(arc4random_uniform(upperBound) + lowerBound)
        
        for i in 0..<count {
            let twinkleLayer: TwinkleLayer = TwinkleLayer()
            let x: Int = Int(arc4random_uniform(UInt32(self.layer.bounds.size.width)))
            let y: Int = Int(arc4random_uniform(UInt32(self.layer.bounds.size.height)))
            twinkleLayer.position = CGPointMake(CGFloat(x), CGFloat(y))
            twinkleLayer.opacity = 0
            twinkleLayers.append(twinkleLayer)
            self.layer.addSublayer(twinkleLayer)
            
            twinkleLayer.addPositionAnimation()
            twinkleLayer.addRotationAnimation()
            twinkleLayer.addFadeInOutAnimation( CACurrentMediaTime() + CFTimeInterval(0.15 * Float(i)) )
        }
        
        twinkleLayers.removeAll(keepCapacity: false)
    }
        
}
