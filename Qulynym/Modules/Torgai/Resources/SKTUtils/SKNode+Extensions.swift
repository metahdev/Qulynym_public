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
