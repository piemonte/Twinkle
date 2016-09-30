//
//  Radom.swift
//  Twinkle
//
//  Created by admin on 16/8/30.
//  Copyright © 2016年 patrickpiemonte. All rights reserved.
//

// MARK: - Extensions of Int, UInt32, Bool, Float, Double, CGFloat, UIColor, CGPoint, Array, ArraySlice to add vars or methods about random.

import UIKit

public extension Int {
    /**
     - parameter lower: default -> 0
     - parameter upper: default -> 100
     - returns: lower <= value <= upper
     */
    public static func random(_ lower: Int = 0, _ upper: Int = 100) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    /**
     - returns: range.startIndex <= value <= range.endIndex
     */
    public static func random(_ range: Range<Int>) -> Int {
        return Int.random(range.lowerBound, range.upperBound - 1)
    }
    
    /// if self == 0, 0; else if self > 0, 0 <= value <= self; else self <= value <= 0
    public var random: Int {
        return Int.random(0, self)
    }
}

public extension UInt32 {
    /**
     - parameter lower: default -> 0
     - parameter upper: default -> 100
     - returns: lower <= value <= upper
     */
    public static func random(_ lower: UInt32 = 0, _ upper: UInt32 = 100) -> UInt32 {
        return lower + UInt32(arc4random_uniform(upper - lower + 1))
    }
    /**
     - returns: range.startIndex <= value <= range.endIndex
     */
    public static func random(_ range: Range<UInt32>) -> UInt32 {
        return UInt32.random(range.lowerBound, range.upperBound - 1)
    }
    /// 0 <= value <= self
    public var random: UInt32 {
        return UInt32.random(0, self)
    }
}

public extension Bool {
    /// true or false, randomly~
    public static var random: Bool {
        return arc4random_uniform(2) == 1
    }
}

public extension Double {
    /**
     - parameter lower: default -> 0
     - parameter upper: default -> 100
     - returns: lower <= value <= upper
     */
    public static func random(_ lower: Double = 0, _ upper: Double = 100) -> Double {
        return (Double(arc4random()) / Double(UINT32_MAX)) * (upper - lower) + lower
    }
    
    /// if self == 0, 0; else if self > 0, 0 <= value <= self; else self <= value <= 0
    public var random: Double {
        return Double.random(0, self)
    }
}

public extension Float {
    /**
     - parameter lower: default -> 0
     - parameter upper: default -> 100
     - returns: lower <= value <= upper
     */
    public static func random(_ lower: Float = 0, _ upper: Float = 100) -> Float {
        return (Float(arc4random()) / Float(UINT32_MAX)) * (upper - lower) + lower
    }
    
    /// if self == 0, 0; else if self > 0, 0 <= value <= self; else self <= value <= 0
    public var random: Float {
        return Float.random(0, self)
    }
}

public extension CGFloat {
    /**
     - parameter lower: default -> 0
     - parameter upper: default -> 100
     - returns: lower <= value <= upper
     */
    public static func random(_ lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat(CGFloat(arc4random()) / CGFloat(UINT32_MAX)) * (upper - lower) + lower
    }
    
    /// if self == 0, 0; else if self > 0, 0 <= value <= self; else self <= value <= 0
    public var random: CGFloat {
        return CGFloat.random(0, self)
    }
}

public extension UIColor {
    /// A color of random red, green and blue, alpha is 1.
    public static var random: UIColor {
        return UIColor(red: CGFloat.random(0, 1),
                     green: CGFloat.random(0, 1),
                     blue: CGFloat.random(0, 1),
                     alpha: 1)
    }
}

public extension CGPoint {
    /**
     - parameter lower: default -> 0
     - parameter upper: default -> 100
     - returns: lower.x <= value.x <= upper.x && lower.y <= value.y <= upper.y
     */
    public static func random(_ lower: CGFloat = 0, _ upper: CGFloat = 100) -> CGPoint {
        let x = CGFloat.random(lower, upper)
        let y = CGFloat.random(lower, lower)
        return CGPoint(x: x, y: y)
    }
}

public extension Array {
    /// a random item in array
    public var randomItem: Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

public extension ArraySlice {
    /// a random item in array slice
    public var randomItem: Element {
        let index = Int.random(self.startIndex, self.endIndex - 1)
        return self[index]
    }
}

