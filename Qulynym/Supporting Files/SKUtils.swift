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
import CoreGraphics
import Foundation
import AVFoundation

// MARK: - SKColor
public func SKColorWithRGB(_ r: Int, g: Int, b: Int) -> SKColor {
    return SKColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
}

public func SKColorWithRGBA(_ r: Int, g: Int, b: Int, a: Int) -> SKColor {
    return SKColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a)/255.0)
}

// MARK: - CGVector
public extension CGVector {
    init(point: CGPoint) {
        self.init(dx: point.x, dy: point.y)
    }

    init(angle: CGFloat) {
        self.init(dx: cos(angle), dy: sin(angle))
    }
    
    mutating func offset(_ dx: CGFloat, dy: CGFloat) -> CGVector {
        self.dx += dx
        self.dy += dy
        return self
    }

    func length() -> CGFloat {
        return sqrt(dx*dx + dy*dy)
    }
 
    func lengthSquared() -> CGFloat {
        return dx*dx + dy*dy
    }

    func normalized() -> CGVector {
        let len = length()
        return len>0 ? self / len : CGVector.zero
    }
    
    mutating func normalize() -> CGVector {
        self = normalized()
        return self
    }
    
    func distanceTo(_ vector: CGVector) -> CGFloat {
        return (self - vector).length()
    }

    var angle: CGFloat {
        return atan2(dy, dx)
    }
}

public func + (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx + right.dx, dy: left.dy + right.dy)
}

public func += (left: inout CGVector, right: CGVector) {
    left = left + right
}

public func - (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
}

public func -= (left: inout CGVector, right: CGVector) {
    left = left - right
}

public func * (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx * right.dx, dy: left.dy * right.dy)
}

public func *= (left: inout CGVector, right: CGVector) {
    left = left * right
}


public func * (vector: CGVector, scalar: CGFloat) -> CGVector {
    return CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
}

public func *= (vector: inout CGVector, scalar: CGFloat) {
    vector = vector * scalar
}

public func / (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx / right.dx, dy: left.dy / right.dy)
}

public func /= (left: inout CGVector, right: CGVector) {
    left = left / right
}

public func / (vector: CGVector, scalar: CGFloat) -> CGVector {
    return CGVector(dx: vector.dx / scalar, dy: vector.dy / scalar)
}

public func /= (vector: inout CGVector, scalar: CGFloat) {
    vector = vector / scalar
}

public func lerp(_ start: CGVector, end: CGVector, t: CGFloat) -> CGVector {
    return start + (end - start) * t
}

// MARK: - Int 
public extension Int {
    func clamped(_ range: Range<Int>) -> Int {
        return (self < range.lowerBound) ? range.lowerBound : ((self >= range.upperBound) ? range.upperBound - 1: self)
    }
    func clamped(_ range: ClosedRange<Int>) -> Int {
        return (self < range.lowerBound) ? range.lowerBound : ((self > range.upperBound) ? range.upperBound: self)
    }
    mutating func clamp(_ range: Range<Int>) -> Int {
        self = clamped(range)
        return self
    }
    mutating func clamp(_ range: ClosedRange<Int>) -> Int {
        self = clamped(range)
        return self
    }
    func clamped(_ v1: Int, _ v2: Int) -> Int {
        let min = v1 < v2 ? v1 : v2
        let max = v1 > v2 ? v1 : v2
        return self < min ? min : (self > max ? max : self)
    }
    mutating func clamp(_ v1: Int, _ v2: Int) -> Int {
        self = clamped(v1, v2)
        return self
    }
    static func random(_ range: Range<Int>) -> Int {
        return Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound - 1))) + range.lowerBound
    }
    
    static func random(_ range: ClosedRange<Int>) -> Int {
        return Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound))) + range.lowerBound
    }
    static func random(_ n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    static func random(_ min: Int, max: Int) -> Int {
        assert(min < max)
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
}

// MARK: - SKTimingFunctions
public func SKTTimingFunctionLinear(_ t: CGFloat) -> CGFloat {
    return t
}
public func SKTTimingFunctionQuadraticEaseIn(_ t: CGFloat) -> CGFloat {
    return t * t
}
public func SKTTimingFunctionQuadraticEaseOut(_ t: CGFloat) -> CGFloat {
    return t * (2.0 - t)
}
public func SKTTimingFunctionQuadraticEaseInOut(_ t: CGFloat) -> CGFloat {
    if t < 0.5 {
        return 2.0 * t * t
    } else {
        let f = t - 1.0
        return 1.0 - 2.0 * f * f
    }
}
func SKTTimingFunctionCubicEaseIn(_ t: CGFloat) -> CGFloat {
    return t * t * t
}
func SKTTimingFunctionCubicEaseOut(_ t: CGFloat) -> CGFloat {
    let f = t - 1.0
    return 1.0 + f * f * f
}
public func SKTTimingFunctionCubicEaseInOut(_ t: CGFloat) -> CGFloat {
    if t < 0.5 {
        return 4.0 * t * t * t
    } else {
        let f = t - 1.0
        return 1.0 + 4.0 * f * f * f
    }
}
public func SKTTimingFunctionQuarticEaseIn(_ t: CGFloat) -> CGFloat {
    return t * t * t * t
}
public func SKTTimingFunctionQuarticEaseOut(_ t: CGFloat) -> CGFloat {
    let f = t - 1.0
    return 1.0 - f * f * f * f
}
public func SKTTimingFunctionQuarticEaseInOut(_ t: CGFloat) -> CGFloat {
    if t < 0.5 {
        return 8.0 * t * t * t * t
    } else {
        let f = t - 1.0
        return 1.0 - 8.0 * f * f * f * f
    }
}
public func SKTTimingFunctionQuinticEaseIn(_ t: CGFloat) -> CGFloat {
    return t * t * t * t * t
}
public func SKTTimingFunctionQuinticEaseOut(_ t: CGFloat) -> CGFloat {
    let f = t - 1.0
    return 1.0 + f * f * f * f * f
}
func SKTTimingFunctionQuinticEaseInOut(_ t: CGFloat) -> CGFloat {
    if t < 0.5 {
        return 16.0 * t * t * t * t * t
    } else {
        let f = t - 1.0
        return 1.0 + 16.0 * f * f * f * f * f
    }
}
public func SKTTimingFunctionSineEaseIn(_ t: CGFloat) -> CGFloat {
    return sin((t - 1.0) * π/2) + 1.0
}
public func SKTTimingFunctionSineEaseOut(_ t: CGFloat) -> CGFloat {
    return sin(t * π/2)
}
public func SKTTimingFunctionSineEaseInOut(_ t: CGFloat) -> CGFloat {
    return 0.5 * (1.0 - cos(t * π))
}
public func SKTTimingFunctionCircularEaseIn(_ t: CGFloat) -> CGFloat {
    return 1.0 - sqrt(1.0 - t * t)
}
public func SKTTimingFunctionCircularEaseOut(_ t: CGFloat) -> CGFloat {
    return sqrt((2.0 - t) * t)
}
public func SKTTimingFunctionCircularEaseInOut(_ t: CGFloat) -> CGFloat {
    if t < 0.5 {
        return 0.5 * (1.0 - sqrt(1.0 - 4.0 * t * t))
    } else {
        return 0.5 * sqrt(-4.0 * t * t + 8.0 * t - 3.0) + 0.5
    }
}
public func SKTTimingFunctionExponentialEaseIn(_ t: CGFloat) -> CGFloat {
    return (t == 0.0) ? t : pow(2.0, 10.0 * (t - 1.0))
}
public func SKTTimingFunctionExponentialEaseOut(_ t: CGFloat) -> CGFloat {
    return (t == 1.0) ? t : 1.0 - pow(2.0, -10.0 * t)
}
public func SKTTimingFunctionExponentialEaseInOut(_ t: CGFloat) -> CGFloat {
    if t == 0.0 || t == 1.0 {
        return t
    } else if t < 0.5 {
        return 0.5 * pow(2.0, 20.0 * t - 10.0)
    } else {
        return 1.0 - 0.5 * pow(2.0, -20.0 * t + 10.0)
    }
}
public func SKTTimingFunctionElasticEaseIn(_ t: CGFloat) -> CGFloat {
    return sin(13.0 * π/2 * t) * pow(2.0, 10.0 * (t - 1.0))
}
public func SKTTimingFunctionElasticEaseOut(_ t: CGFloat) -> CGFloat {
    return sin(-13.0 * π/2 * (t + 1.0)) * pow(2.0, -10.0 * t) + 1.0
}
public func SKTTimingFunctionElasticEaseInOut(_ t: CGFloat) -> CGFloat {
    if t < 0.5 {
        return 0.5 * sin(13.0 * π * t) * pow(2.0, 20.0 * t - 10.0)
    } else {
        return 0.5 * sin(-13.0 * π * t) * pow(2.0, -20.0 * t + 10.0) + 1.0
    }
}
public func SKTTimingFunctionBackEaseIn(_ t: CGFloat) -> CGFloat {
    let s: CGFloat = 1.70158
    return ((s + 1.0) * t - s) * t * t
}
public func SKTTimingFunctionBackEaseOut(_ t: CGFloat) -> CGFloat {
    let s: CGFloat = 1.70158
    let f = 1.0 - t
    return 1.0 - ((s + 1.0) * f - s) * f * f
}
public func SKTTimingFunctionBackEaseInOut(_ t: CGFloat) -> CGFloat {
    let s: CGFloat = 1.70158
    if t < 0.5 {
        let f = 2.0 * t
        return 0.5 * ((s + 1.0) * f - s) * f * f
    } else {
        let f = 2.0 * (1.0 - t)
        return 1.0 - 0.5 * ((s + 1.0) * f - s) * f * f
    }
}
public func SKTTimingFunctionExtremeBackEaseIn(_ t: CGFloat) -> CGFloat {
    return (t * t - sin(t * π)) * t
}
public func SKTTimingFunctionExtremeBackEaseOut(_ t: CGFloat) -> CGFloat {
    let f = 1.0 - t
    return 1.0 - (f * f - sin(f * π)) * f
}
public func SKTTimingFunctionExtremeBackEaseInOut(_ t: CGFloat) -> CGFloat {
    if t < 0.5 {
        let f = 2.0 * t
        return 0.5 * (f * f - sin(f * π)) * f
    } else {
        let f = 2.0 * (1.0 - t)
        return 1.0 - 0.5 * (f * f - sin(f * π)) * f
    }
}
public func SKTTimingFunctionBounceEaseIn(_ t: CGFloat) -> CGFloat {
    return 1.0 - SKTTimingFunctionBounceEaseOut(1.0 - t)
}
public func SKTTimingFunctionBounceEaseOut(_ t: CGFloat) -> CGFloat {
    if t < 1.0 / 2.75 {
        return 7.5625 * t * t
    } else if t < 2.0 / 2.75 {
        let f = t - 1.5 / 2.75
        return 7.5625 * f * f + 0.75
    } else if t < 2.5 / 2.75 {
        let f = t - 2.25 / 2.75
        return 7.5625 * f * f + 0.9375
    } else {
        let f = t - 2.625 / 2.75
        return 7.5625 * f * f + 0.984375
    }
}
public func SKTTimingFunctionBounceEaseInOut(_ t: CGFloat) -> CGFloat {
    if t < 0.5 {
        return 0.5 * SKTTimingFunctionBounceEaseIn(t * 2.0)
    } else {
        return 0.5 * SKTTimingFunctionBounceEaseOut(t * 2.0 - 1.0) + 0.5
    }
}
public func SKTTimingFunctionSmoothstep(_ t: CGFloat) -> CGFloat {
    return t * t * (3 - 2 * t)
}
public func SKTCreateShakeFunction(_ oscillations: Int) -> (CGFloat) -> CGFloat {
    return {t in -pow(2.0, -10.0 * t) * sin(t * π * CGFloat(oscillations) * 2.0) + 1.0}
}

// MARK: - SKAction
public extension SKAction {
    class func afterDelay(_ delay: TimeInterval, performAction action: SKAction) -> SKAction {
        return SKAction.sequence([SKAction.wait(forDuration: delay), action])
    }
    class func afterDelay(_ delay: TimeInterval, runBlock block: @escaping () -> Void) -> SKAction {
        return SKAction.afterDelay(delay, performAction: SKAction.run(block))
    }
    class func removeFromParentAfterDelay(_ delay: TimeInterval) -> SKAction {
        return SKAction.afterDelay(delay, performAction: SKAction.removeFromParent())
    }
    class func jumpToHeight(_ height: CGFloat, duration: TimeInterval, originalPosition: CGPoint) -> SKAction {
        return SKAction.customAction(withDuration: duration) {(node, elapsedTime) in
            let fraction = elapsedTime / CGFloat(duration)
            let yOffset = height * 4 * fraction * (1 - fraction)
            node.position = CGPoint(x: originalPosition.x, y: originalPosition.y + yOffset)
        }
    }
}

// MARK: - SKAction+SpecialEffects
public extension SKAction {
    class func screenShakeWithNode(_ node: SKNode, amount: CGPoint, oscillations: Int, duration: TimeInterval) -> SKAction {
        let oldPosition = node.position
        let newPosition = oldPosition + amount
        
        let effect = SKTMoveEffect(node: node, duration: duration, startPosition: newPosition, endPosition: oldPosition)
        effect.timingFunction = SKTCreateShakeFunction(oscillations)
        
        return SKAction.actionWithEffect(effect)
    }
    class func screenRotateWithNode(_ node: SKNode, angle: CGFloat, oscillations: Int, duration: TimeInterval) -> SKAction {
        let oldAngle = node.zRotation
        let newAngle = oldAngle + angle
        
        let effect = SKTRotateEffect(node: node, duration: duration, startAngle: newAngle, endAngle: oldAngle)
        effect.timingFunction = SKTCreateShakeFunction(oscillations)
        
        return SKAction.actionWithEffect(effect)
    }
    class func screenZoomWithNode(_ node: SKNode, amount: CGPoint, oscillations: Int, duration: TimeInterval) -> SKAction {
        let oldScale = CGPoint(x: node.xScale, y: node.yScale)
        let newScale = oldScale * amount
        
        let effect = SKTScaleEffect(node: node, duration: duration, startScale: newScale, endScale: oldScale)
        effect.timingFunction = SKTCreateShakeFunction(oscillations)
        
        return SKAction.actionWithEffect(effect)
    }
    class func colorGlitchWithScene(_ scene: SKScene, originalColor: SKColor, duration: TimeInterval) -> SKAction {
        return SKAction.customAction(withDuration: duration) {(node, elapsedTime) in
            if elapsedTime < CGFloat(duration) {
                scene.backgroundColor = SKColorWithRGB(Int.random(0...255), g: Int.random(0...255), b: Int.random(0...255))
            } else {
                scene.backgroundColor = originalColor
            }
        }
    }
}

// MARK: - SKNode
public extension SKNode {
    var scaleAsPoint: CGPoint {
        get {
            return CGPoint(x: xScale, y: yScale)
        }
        set {
            xScale = newValue.x
            yScale = newValue.y
        }
    }
    func afterDelay(_ delay: TimeInterval, runBlock block: @escaping () -> Void) {
        run(SKAction.sequence([SKAction.wait(forDuration: delay), SKAction.run(block)]))
    }
    func bringToFront() {
        if let parent = self.parent{
            removeFromParent()
            parent.addChild(self)
        }
    }
    func rotateToVelocity(_ velocity: CGVector, rate: CGFloat) {
        let newAngle = atan2(velocity.dy, velocity.dx) - π/2
        if newAngle - zRotation > π {
            zRotation += π * 2.0
        } else if zRotation - newAngle > π {
            zRotation -= π * 2.0
        }
        zRotation += (newAngle - zRotation) * rate
    }
}

// MARK: - CGPoint
public extension CGPoint {
    init(vector: CGVector) {
        self.init(x: vector.dx, y: vector.dy)
    }
    init(angle: CGFloat) {
        self.init(x: cos(angle), y: sin(angle))
    }
    mutating func offset(_ dx: CGFloat, dy: CGFloat) -> CGPoint {
        x += dx
        y += dy
        return self
    }
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    func lengthSquared() -> CGFloat {
        return x*x + y*y
    }
    func normalized() -> CGPoint {
        let len = length()
        return len>0 ? self / len : CGPoint.zero
    }
    mutating func normalize() -> CGPoint {
        self = normalized()
        return self
    }
    func distanceTo(_ point: CGPoint) -> CGFloat {
        return (self - point).length()
    }
    var angle: CGFloat {
        return atan2(y, x)
    }
}

public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}
public func += (left: inout CGPoint, right: CGPoint) {
    left = left + right
}
public func + (left: CGPoint, right: CGVector) -> CGPoint {
    return CGPoint(x: left.x + right.dx, y: left.y + right.dy)
}
public func += (left: inout CGPoint, right: CGVector) {
    left = left + right
}
public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}
public func -= (left: inout CGPoint, right: CGPoint) {
    left = left - right
}
public func - (left: CGPoint, right: CGVector) -> CGPoint {
    return CGPoint(x: left.x - right.dx, y: left.y - right.dy)
}
public func -= (left: inout CGPoint, right: CGVector) {
    left = left - right
}
public func * (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}
public func *= (left: inout CGPoint, right: CGPoint) {
    left = left * right
}
public func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}
public func *= (point: inout CGPoint, scalar: CGFloat) {
    point = point * scalar
}
public func * (left: CGPoint, right: CGVector) -> CGPoint {
    return CGPoint(x: left.x * right.dx, y: left.y * right.dy)
}
public func *= (left: inout CGPoint, right: CGVector) {
    left = left * right
}
public func / (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x / right.x, y: left.y / right.y)
}
public func /= (left: inout CGPoint, right: CGPoint) {
    left = left / right
}
public func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}
public func /= (point: inout CGPoint, scalar: CGFloat) {
    point = point / scalar
}
public func / (left: CGPoint, right: CGVector) -> CGPoint {
    return CGPoint(x: left.x / right.dx, y: left.y / right.dy)
}
public func /= (left: inout CGPoint, right: CGVector) {
    left = left / right
}
public func lerp(_ start: CGPoint, end: CGPoint, t: CGFloat) -> CGPoint {
    return start + (end - start) * t
}

// MARK: - SKTEffects
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

// MARK: - SKTAudio
open class SKTAudio {
    open var backgroundMusicPlayer: AVAudioPlayer?
    open var soundEffectPlayer: AVAudioPlayer?
    
    open class func sharedInstance() -> SKTAudio {
        return SKTAudioInstance
    }
    
    open func playBackgroundMusic(_ filename: String) {
        let url = Bundle.main.url(forResource: filename, withExtension: nil)
        if (url == nil) {
            return
        }
        
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url!)
        } catch {
            backgroundMusicPlayer = nil
        }
        if let player = backgroundMusicPlayer {
            player.numberOfLoops = -1
            player.prepareToPlay()
            player.play()
        } else {
        }
    }
    
    open func pauseBackgroundMusic() {
        if let player = backgroundMusicPlayer {
            if player.isPlaying {
                player.pause()
            }
        }
    }
    
    open func resumeBackgroundMusic() {
        if let player = backgroundMusicPlayer {
            if !player.isPlaying {
                player.play()
            }
        }
    }
    
    open func playSoundEffect(_ filename: String) {
        let url = Bundle.main.url(forResource: filename, withExtension: nil)
        if (url == nil) {
            return
        }
        
        do {
            soundEffectPlayer = try AVAudioPlayer(contentsOf: url!)
        } catch {
            soundEffectPlayer = nil
        }
        if let player = soundEffectPlayer {
            player.numberOfLoops = 0
            player.prepareToPlay()
            player.play()
        } else {
        }
    }
}

private let SKTAudioInstance = SKTAudio()

// MARK: - Vector3
public struct Vector3: Equatable {
    public var x: CGFloat
    public var y: CGFloat
    public var z: CGFloat
    
    public init(x: CGFloat, y: CGFloat, z: CGFloat) {
        self.x = x
        self.y = y
        self.z = z
    }
}

public func == (lhs: Vector3, rhs: Vector3) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
}

public func == (lhs: Vector3, rhs: CGFloat) -> Bool {
    return lhs.x == rhs && lhs.y == rhs && lhs.z == rhs
}

extension Vector3 {
   
    static var zeroVector: Vector3 {
        return Vector3(x: 0, y: 0, z: 0)
    }

    public func equalToScalar(_ value: CGFloat) -> Bool {
        return x == value && y == value && z == value
    }
    public func length() -> CGFloat {
        return sqrt(x*x + y*y + z*z)
    }
    public func normalized() -> Vector3 {
        let scale = 1.0/length()
        return Vector3(x: x * scale, y: y * scale, z: z * scale)
    }
    public mutating func normalize() {
        let scale = 1.0/length()
        x *= scale
        y *= scale
        z *= scale
    }
    public func dot(_ vector: Vector3) -> CGFloat {
        return Vector3.dotProduct(self, right: vector)
    }
    public func cross(_ vector: Vector3) -> Vector3 {
        return Vector3.crossProduct(self, right: vector)
    }
    public static func dotProduct(_ left: Vector3, right: Vector3) -> CGFloat {
        return left.x * right.x + left.y * right.y + left.z * right.z
    }
    public static func crossProduct(_ left: Vector3, right: Vector3) -> Vector3 {
        let crossProduct = Vector3(x: left.y * right.z - left.z * right.y,
                                   y: left.z * right.x - left.x * right.z,
                                   z: left.x * right.y - left.y * right.x)
        return crossProduct
    }
}

public func + (left: Vector3, right: Vector3) -> Vector3 {
    return Vector3(x: left.x + right.x, y: left.y + right.y, z: left.z + right.z)
}
public func += (left: inout Vector3, right: Vector3) {
    left = left + right
}
public func - (left: Vector3, right: Vector3) -> Vector3 {
    return Vector3(x: left.x - right.x, y: left.y - right.y, z: left.z - right.z)
}
public func -= (left: inout Vector3, right: Vector3) {
    left = left - right
}
public func * (left: Vector3, right: Vector3) -> Vector3 {
    return Vector3(x: left.x * right.x, y: left.y * right.y, z: left.z * right.z)
}
public func *= (left: inout Vector3, right: Vector3) {
    left = left * right
}
public func * (vector: Vector3, scalar: CGFloat) -> Vector3 {
    return Vector3(x: vector.x * scalar, y: vector.y * scalar, z: vector.z * scalar)
}
public func *= (vector: inout Vector3, scalar: CGFloat) {
    vector = vector * scalar
}
public func / (left: Vector3, right: Vector3) -> Vector3 {
    return Vector3(x: left.x / right.x, y: left.y / right.y, z: left.z / right.z)
}
public func /= (left: inout Vector3, right: Vector3) {
    left = left / right
}
public func / (vector: Vector3, scalar: CGFloat) -> Vector3 {
    return Vector3(x: vector.x / scalar, y: vector.y / scalar, z: vector.z / scalar)
}
public func /= (vector: inout Vector3, scalar: CGFloat) {
    vector = vector / scalar
}
public func lerp(_ start: Vector3, end: Vector3, t: CGFloat) -> Vector3 {
    return start + (end - start) * t
}

// MARK: - CGFloat
let π = CGFloat(Double.pi)

public extension CGFloat {
    func degreesToRadians() -> CGFloat {
        return π * self / 180.0
    }
}

public func shortestAngleBetween(_ angle1: CGFloat, angle2: CGFloat) -> CGFloat {
    let twoπ = π * 2.0
    var angle = (angle2 - angle1).truncatingRemainder(dividingBy: twoπ)
    if (angle >= π) {
        angle = angle - twoπ
    }
    if (angle <= -π) {
        angle = angle + twoπ
    }
    return angle
}

