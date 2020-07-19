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

class PlayerEntity: GKEntity {
    // MARK: - Properties
    var spriteComponent: SpriteComponent!
    var movementComponent: MovementComponent!
    var animationComponent: AnimationComponent!
    var spriteNode: EntityNode!
    private var textures: Array<SKTexture> = []
    
    var movementAllowed = false
    private var numberOfFrames = 2

    // MARK: - Inits
    init (imageName: String) {
        super.init()
        let texture = SKTexture(imageNamed: imageName)
        spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size())
        addComponent(spriteComponent)
        
        movementComponent = MovementComponent(entity: self)
        addComponent(movementComponent)
        appendTextures()
        
        animationComponent = AnimationComponent(entity: self, textures: textures)
        addComponent(animationComponent)
                
        movementComponent.applyInitialImpulse()
        
        setupSpriteNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    private func appendTextures() {
        for i in 0..<numberOfFrames {
            textures.append(SKTexture(imageNamed: "torgai\(i)"))
        }
        
        for i in stride(from: numberOfFrames, through: 0, by: -1) {
            textures.append(SKTexture(imageNamed: "torgai\(i)"))
        }
    }
    
    private func setupSpriteNode() {
        spriteNode = spriteComponent.node
        spriteNode.size = CGSize(width: 53.33, height: 40)
        spriteNode.physicsBody = SKPhysicsBody(texture: spriteNode.texture!, size: spriteNode.frame.size)
        spriteNode.physicsBody?.categoryBitMask = PhysicsCategory.Player
        spriteNode.physicsBody?.collisionBitMask = 0
        spriteNode.physicsBody?.contactTestBitMask = PhysicsCategory.Obstacle | PhysicsCategory.Ground
    }
}
