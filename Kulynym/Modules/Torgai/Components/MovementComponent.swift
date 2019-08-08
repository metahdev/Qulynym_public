/*
 * Copyright (c) 2017 Razeware LLC
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
import GameplayKit

class MovementComponent: GKComponent {
    let spriteComponent: SpriteComponent
    
    let flapAction = SKAction.playSoundFileNamed("flapping.wav", waitForCompletion: false)
    
    let impulse: CGFloat = 400
    var velocity = CGPoint.zero
    let gravity: CGFloat = -1500
    
    var velocityModifier: CGFloat = 1000.0
    var angularVelocity: CGFloat = 0.0
    let minDegrees: CGFloat = -90
    let maxDegrees: CGFloat = 25
    
    var lastTouchTime: TimeInterval = 0
    var lasyTouchY: CGFloat = 0.0
    
    var playableStart: CGFloat = 0
    
    init(entity: GKEntity) {
        self.spriteComponent = entity.component(ofType: SpriteComponent.self)!
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyInitialImpulse() {
        velocity = CGPoint(x: 0, y: impulse * 2)
    }
    
    func applyImpulse(_ lastUpdateTime: TimeInterval) {
        spriteComponent.node.run(flapAction)
        
        velocity = CGPoint(x: 0, y: impulse)
        
        angularVelocity = velocityModifier.degreesToRadians()
        lastTouchTime = lastUpdateTime
        lasyTouchY = spriteComponent.node.position.y
    }
    
    func applyMovement(_ seconds: TimeInterval) {
        let spriteNode = spriteComponent.node
        
        let gravityStep = CGPoint(x: 0, y: gravity) * CGFloat(seconds)
        velocity += gravityStep
        
        let velocityStep = velocity * CGFloat(seconds)
        spriteNode.position += velocityStep
        
        if spriteNode.position.y < lasyTouchY {
            angularVelocity = -velocityModifier.degreesToRadians()
        }
        
        let angularStep = angularVelocity * CGFloat(seconds)
        spriteNode.zRotation += angularStep
        spriteNode.zRotation = min(max(spriteNode.zRotation, minDegrees.degreesToRadians()), maxDegrees.degreesToRadians())
        
        if spriteNode.position.y - spriteNode.size.height / 2 < playableStart {
            spriteNode.position = CGPoint(x: spriteNode.position.x, y: playableStart + spriteNode.size.height / 2)
        }
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        if let player = entity as? PlayerEntity {
            if player.movementAllowed {
                applyMovement(seconds)
            }
        }
    }
}















