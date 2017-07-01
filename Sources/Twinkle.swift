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

// MARK: - Twinkle

/// ✨ Twinkle, a Swift and easy way to make any UIView twinkle.
public class Twinkle {
    
    /// Casts a spell on the provided view allowing it to twinkle.
    ///
    /// - Parameters:
    ///   - view: UIView that will twinkle
    ///   - image: Optional twinkle image
    ///   - color: Optional color for the default twinkle image
    public class func twinkle(_ view: UIView, image: UIImage? = nil) {
        var twinkleLayers: [TwinkleLayer] = []
        
        let upperBound: UInt32 = 10
        let lowerBound: UInt32 = 5
        let count: UInt = UInt(arc4random_uniform(upperBound) + lowerBound)
        
        for i in 0..<count {
            let twinkleLayer: TwinkleLayer = image == nil ? TwinkleLayer() : TwinkleLayer(image: image!)
            let x: Int = Int(arc4random_uniform(UInt32(view.layer.bounds.size.width)))
            let y: Int = Int(arc4random_uniform(UInt32(view.layer.bounds.size.height)))
            twinkleLayer.position = CGPoint(x: CGFloat(x), y: CGFloat(y))
            twinkleLayer.opacity = 0
            twinkleLayers.append(twinkleLayer)
            view.layer.addSublayer(twinkleLayer)
            
            twinkleLayer.addPositionAnimation()
            twinkleLayer.addRotationAnimation()
            twinkleLayer.addFadeInOutAnimation( CACurrentMediaTime() + CFTimeInterval(0.15 * Float(i)))
        }
        
        twinkleLayers.removeAll(keepingCapacity: false)
    }
    
}

// MARK: - TwinkleLayer

internal class TwinkleLayer: CAEmitterLayer {
    
    // MARK: object lifecycle
    
    internal convenience init(image: UIImage) {
        self.init()
        self.commonInit(image)
    }
    
    internal override init() {
        super.init()
        self.commonInit()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    internal func commonInit(_ image: UIImage? = nil) {
        var twinkleImage: UIImage? = nil
        if let customImage = image {
            twinkleImage = customImage
        } else {
            let frameworkBundle = Bundle(for: self.classForCoder)
            if let imagePath = frameworkBundle.path(forResource: "TwinkleImage", ofType: "png") {
                twinkleImage = UIImage(contentsOfFile: imagePath)
            }
        }
        
        self.emitterCells?.removeAll()
        
        let emitterCells: [CAEmitterCell] = [CAEmitterCell(), CAEmitterCell()]
        for cell in emitterCells {
            cell.birthRate = 8
            cell.lifetime = 1.25
            cell.lifetimeRange = 0
            cell.emissionRange = (.pi / 4)
            cell.velocity = 2
            cell.velocityRange = 18
            cell.scale = 0.65
            cell.scaleRange = 0.7
            cell.scaleSpeed = 0.6
            cell.spin = 0.9
            cell.spinRange = .pi
            cell.color = UIColor(white: 1.0, alpha: 0.3).cgColor
            cell.alphaSpeed = -0.8
            cell.contents = twinkleImage?.cgImage
            cell.magnificationFilter = TwinkleLayerMagnificationFilter
            cell.minificationFilter = TwinkleLayerMinificationFilter
            cell.isEnabled = true
        }
        
        self.emitterCells = emitterCells
        self.emitterPosition = CGPoint(x: (bounds.size.width * 0.5), y: (bounds.size.height * 0.5))
        self.emitterSize = bounds.size
        self.emitterShape = TwinkleLayerEmitterShapeKey
        self.emitterMode = TwinkleLayerEmitterModeKey
        self.renderMode = TwinkleLayerRenderModeKey
    }
    
}

fileprivate let TwinkleLayerPositionAnimationKey = "positionAnimation"
fileprivate let TwinkleLayerTransformAnimationKey = "transformAnimation"
fileprivate let TwinkleLayerOpacityAnimationKey = "opacityAnimation"

extension TwinkleLayer {
    
    // MARK: animation support
    
    internal func addPositionAnimation() {
        CATransaction.begin()
        let keyFrameAnim = CAKeyframeAnimation(keyPath: "position")
        keyFrameAnim.duration = 0.3
        keyFrameAnim.isAdditive = true
        keyFrameAnim.repeatCount = MAXFLOAT
        keyFrameAnim.isRemovedOnCompletion = false
        keyFrameAnim.beginTime = CFTimeInterval(arc4random_uniform(1000) + 1) * 0.2 * 0.25 // random start time, non-zero
        let points: [NSValue] = [NSValue(cgPoint: CGPoint.random(0.25)),
                                 NSValue(cgPoint: CGPoint.random(0.25)),
                                 NSValue(cgPoint: CGPoint.random(0.25)),
                                 NSValue(cgPoint: CGPoint.random(0.25)),
                                 NSValue(cgPoint: CGPoint.random(0.25))]
        keyFrameAnim.values = points
        self.add(keyFrameAnim, forKey: TwinkleLayerPositionAnimationKey)
        CATransaction.commit()
    }
    
    internal func addRotationAnimation() {
        CATransaction.begin()
        let keyFrameAnim = CAKeyframeAnimation(keyPath: "transform")
        keyFrameAnim.duration = 0.3
        keyFrameAnim.valueFunction = CAValueFunction(name: kCAValueFunctionRotateZ)
        keyFrameAnim.isAdditive = true
        keyFrameAnim.repeatCount = MAXFLOAT
        keyFrameAnim.isRemovedOnCompletion = false
        keyFrameAnim.beginTime = CFTimeInterval(arc4random_uniform(1000) + 1) * 0.2 * 0.25 // random start time, non-zero
        let radians: Float = 0.104 // ~6 degrees
        keyFrameAnim.values = [-radians, radians, -radians]
        self.add(keyFrameAnim, forKey: TwinkleLayerTransformAnimationKey)
        CATransaction.commit()
    }
    
    internal func addFadeInOutAnimation(_ beginTime: CFTimeInterval) {
        CATransaction.begin()
        let fadeAnimation: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
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
        self.add(fadeAnimation, forKey: TwinkleLayerOpacityAnimationKey)
        CATransaction.commit()
    }
    
}

// MARK: - CGPoint

extension CGPoint {
    
    internal static func random(_ range: Float) -> CGPoint {
        let x = Int(-range + (Float(arc4random_uniform(1000)) / 1000.0) * 2.0 * range)
        let y = Int(-range + (Float(arc4random_uniform(1000)) / 1000.0) * 2.0 * range)
        return CGPoint(x: x, y: y)
    }
    
}

// MARK: - UIView

extension UIView {
    
    /// UIView extension that provides a convenient means for triggering a twinkle effect.
    public func twinkle() {
        Twinkle.twinkle(self)
    }
    
}
