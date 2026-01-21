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

// MARK: - Twinkle

/// ✨ Twinkle, a Swift and easy way to make any UIView twinkle.
@MainActor
public enum Twinkle {
    
    /// Configuration for twinkle appearance and behavior
    public struct Configuration: Sendable {
        public var minCount: Int
        public var maxCount: Int
        public var birthRate: Float
        public var lifetime: Float
        public var velocity: CGFloat
        public var velocityRange: CGFloat
        public var scale: CGFloat
        public var scaleRange: CGFloat
        public var scaleSpeed: CGFloat
        public var spin: CGFloat
        public var spinRange: CGFloat
        public var alphaSpeed: Float
        public var fadeInDuration: TimeInterval
        public var positionAnimationDuration: TimeInterval
        public var rotationAnimationDuration: TimeInterval

        public init(
            minCount: Int = 5,
            maxCount: Int = 10,
            birthRate: Float = 8,
            lifetime: Float = 1.25,
            velocity: CGFloat = 2,
            velocityRange: CGFloat = 18,
            scale: CGFloat = 0.65,
            scaleRange: CGFloat = 0.7,
            scaleSpeed: CGFloat = 0.6,
            spin: CGFloat = 0.9,
            spinRange: CGFloat = .pi,
            alphaSpeed: Float = -0.8,
            fadeInDuration: TimeInterval = 0.4,
            positionAnimationDuration: TimeInterval = 0.3,
            rotationAnimationDuration: TimeInterval = 0.3
        ) {
            self.minCount = minCount
            self.maxCount = maxCount
            self.birthRate = birthRate
            self.lifetime = lifetime
            self.velocity = velocity
            self.velocityRange = velocityRange
            self.scale = scale
            self.scaleRange = scaleRange
            self.scaleSpeed = scaleSpeed
            self.spin = spin
            self.spinRange = spinRange
            self.alphaSpeed = alphaSpeed
            self.fadeInDuration = fadeInDuration
            self.positionAnimationDuration = positionAnimationDuration
            self.rotationAnimationDuration = rotationAnimationDuration
        }
    }
    
    /// Casts a spell on the provided view allowing it to twinkle.
    ///
    /// - Parameters:
    ///   - view: UIView that will twinkle
    ///   - image: Optional twinkle image
    ///   - configuration: Configuration for twinkle behavior
    public static func twinkle(_ view: UIView, image: UIImage? = nil, configuration: Configuration = Configuration()) {
        let count = Int.random(in: configuration.minCount...configuration.maxCount)
        
        let twinkleLayers = (0..<count).compactMap { index -> TwinkleLayer? in
            let twinkleLayer = TwinkleLayer(image: image, configuration: configuration)
            let x = CGFloat.random(in: 0..<view.bounds.width)
            let y = CGFloat.random(in: 0..<view.bounds.height)
            twinkleLayer.position = CGPoint(x: x, y: y)
            twinkleLayer.opacity = 0
            return twinkleLayer
        }
        
        twinkleLayers.forEach { layer in
            view.layer.addSublayer(layer)
            layer.addAnimations(beginTime: CACurrentMediaTime() + TimeInterval(0.15 * Float(twinkleLayers.firstIndex(where: { $0 === layer }) ?? 0)))
        }
    }
}

// MARK: - TwinkleLayer

@MainActor
internal final class TwinkleLayer: CAEmitterLayer {
    
    private let configuration: Twinkle.Configuration
    
    // MARK: object lifecycle
    
    internal init(image: UIImage? = nil, configuration: Twinkle.Configuration = Twinkle.Configuration()) {
        self.configuration = configuration
        super.init()
        self.setupEmitter(with: image)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        self.configuration = Twinkle.Configuration()
        super.init(coder: aDecoder)
        self.setupEmitter()
    }
    
    private func setupEmitter(with customImage: UIImage? = nil) {
        let twinkleImage: UIImage? = customImage ?? {
            guard let resourcePath = Bundle.module.path(forResource: "TwinkleImage", ofType: "png") else {
                return nil
            }
            return UIImage(contentsOfFile: resourcePath)
        }()
        
        let emitterCells = (0..<2).map { _ -> CAEmitterCell in
            let cell = CAEmitterCell()
            cell.birthRate = configuration.birthRate
            cell.lifetime = configuration.lifetime
            cell.lifetimeRange = 0
            cell.emissionRange = (.pi / 4)
            cell.velocity = configuration.velocity
            cell.velocityRange = configuration.velocityRange
            cell.scale = configuration.scale
            cell.scaleRange = configuration.scaleRange
            cell.scaleSpeed = configuration.scaleSpeed
            cell.spin = configuration.spin
            cell.spinRange = configuration.spinRange
            cell.color = UIColor(white: 1.0, alpha: 0.3).cgColor
            cell.alphaSpeed = configuration.alphaSpeed
            cell.contents = twinkleImage?.cgImage
            cell.magnificationFilter = CALayerContentsFilter.linear.rawValue
            cell.minificationFilter = CALayerContentsFilter.trilinear.rawValue
            cell.isEnabled = true
            return cell
        }
        
        self.emitterCells = emitterCells
        self.emitterPosition = CGPoint(x: bounds.midX, y: bounds.midY)
        self.emitterSize = bounds.size
        self.emitterShape = .circle
        self.emitterMode = .surface
        self.renderMode = .unordered
    }
    
    override init(layer: Any) {
        if let layer = layer as? TwinkleLayer {
            self.configuration = layer.configuration
        } else {
            self.configuration = Twinkle.Configuration()
        }
        super.init(layer: layer)
    }
}

// MARK: - Animations

extension TwinkleLayer {
    
    func addAnimations(beginTime: CFTimeInterval) {
        addPositionAnimation()
        addRotationAnimation()
        addFadeInOutAnimation(beginTime)
    }
    
    private func addPositionAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = configuration.positionAnimationDuration
        animation.isAdditive = true
        animation.repeatCount = .greatestFiniteMagnitude
        animation.isRemovedOnCompletion = false
        animation.beginTime = CFTimeInterval.random(in: 0.2...1.0) * 0.25
        
        let range: CGFloat = 0.25
        animation.values = (0..<5).map { _ in
            NSValue(cgPoint: CGPoint(
                x: CGFloat.random(in: -range...range),
                y: CGFloat.random(in: -range...range)
            ))
        }
        
        add(animation, forKey: "twinkle.position")
    }
    
    private func addRotationAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform")
        animation.duration = configuration.rotationAnimationDuration
        animation.valueFunction = CAValueFunction(name: .rotateZ)
        animation.isAdditive = true
        animation.repeatCount = .greatestFiniteMagnitude
        animation.isRemovedOnCompletion = false
        animation.beginTime = CFTimeInterval.random(in: 0.2...1.0) * 0.25
        
        let radians: CGFloat = 0.104
        animation.values = [-radians, radians, -radians]
        
        add(animation, forKey: "twinkle.rotation")
    }
    
    private func addFadeInOutAnimation(_ beginTime: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fromValue = 0
        animation.toValue = 1
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.duration = configuration.fadeInDuration
        animation.fillMode = .forwards
        animation.beginTime = beginTime
        animation.isRemovedOnCompletion = false
        
        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            self?.removeFromSuperlayer()
        }
        add(animation, forKey: "twinkle.opacity")
        CATransaction.commit()
    }
}

// MARK: - UIView Extension

extension UIView {
    
    /// UIView extension that provides a convenient means for triggering a twinkle effect.
    @MainActor
    public func twinkle(image: UIImage? = nil, configuration: Twinkle.Configuration = Twinkle.Configuration()) {
        Twinkle.twinkle(self, image: image, configuration: configuration)
    }
}

// MARK: - Bundle Extension

extension Bundle {
    #if !SWIFT_PACKAGE
    private final class BundleToken {}
    #endif

    static var module: Bundle {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        return Bundle(for: BundleToken.self)
        #endif
    }
}
