/*
 * Copyright (c) 2013-2014 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import SpriteKit
open class SKTEffect {
    unowned var node: SKNode
    var duration: TimeInterval
    open var timingFunction: ((CGFloat) -> CGFloat)?
    
    public init(node: SKNode, duration: TimeInterval) {
        self.node = node
        self.duration = duration
        timingFunction = SKTTimingFunctionLinear
    }
    
    open func update(_ t: CGFloat) {
    }
}
open class SKTMoveEffect: SKTEffect {
    var startPosition: CGPoint
    var delta: CGPoint
    var previousPosition: CGPoint
    
    public init(node: SKNode, duration: TimeInterval, startPosition: CGPoint, endPosition: CGPoint) {
        previousPosition = node.position
        self.startPosition = startPosition
        delta = endPosition - startPosition
        super.init(node: node, duration: duration)
    }
    
    open override func update(_ t: CGFloat) {
        let newPosition = startPosition + delta*t
        let diff = newPosition - previousPosition
        previousPosition = newPosition
        node.position += diff
    }
}

open class SKTScaleEffect: SKTEffect {
    var startScale: CGPoint
    var delta: CGPoint
    var previousScale: CGPoint
    
    public init(node: SKNode, duration: TimeInterval, startScale: CGPoint, endScale: CGPoint) {
        previousScale = CGPoint(x: node.xScale, y: node.yScale)
        self.startScale = startScale
        delta = endScale - startScale
        super.init(node: node, duration: duration)
    }
    
    open override func update(_ t: CGFloat) {
        let newScale = startScale + delta*t
        let diff = newScale / previousScale
        previousScale = newScale
        node.xScale *= diff.x
        node.yScale *= diff.y
    }
}

open class SKTRotateEffect: SKTEffect {
    var startAngle: CGFloat
    var delta: CGFloat
    var previousAngle: CGFloat
    
    public init(node: SKNode, duration: TimeInterval, startAngle: CGFloat, endAngle: CGFloat) {
        previousAngle = node.zRotation
        self.startAngle = startAngle
        delta = endAngle - startAngle
        super.init(node: node, duration: duration)
    }
    
    open override func update(_ t: CGFloat) {
        let newAngle = startAngle + delta*t
        let diff = newAngle - previousAngle
        previousAngle = newAngle
        node.zRotation += diff
    }
}

public extension SKAction {
    class func actionWithEffect(_ effect: SKTEffect) -> SKAction {
        return SKAction.customAction(withDuration: effect.duration) { node, elapsedTime in
            var t = elapsedTime / CGFloat(effect.duration)
            
            if let timingFunction = effect.timingFunction {
                t = timingFunction(t) 
            }
            
            effect.update(t)
        }
    }
}
