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

class FallingState: GKState {
    // MARK: - Properties
    unowned let gameScene: GameScene
    
    private let whackAction = SKAction.playSoundFileNamed("whack.wav", waitForCompletion: false)
    private let fallingAction = SKAction.playSoundFileNamed("falling.wav", waitForCompletion: false)
    private lazy var shakeAction = SKAction.screenShakeWithNode(gameScene.worldNode, amount: CGPoint(x: 0, y: 7.0), oscillations: 10, duration: 1.0)
    
    private lazy var shokNode: SKSpriteNode = {
        let sn = SKSpriteNode(color: SKColor.white, size: gameScene.size)
        sn.position = CGPoint(x: gameScene.size.width / 2, y: gameScene.size.height / 2)
        sn.zPosition = Layer.flash.rawValue
        return sn
    }()
    
    // MARK: - View Lifecycle
    init(scene: SKScene) {
        self.gameScene = scene as! GameScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        gameScene.worldNode.run(shakeAction)
        
        gameScene.worldNode.addChild(shokNode)
        shokNode.run(SKAction.removeFromParentAfterDelay(0.01))
        
        gameScene.run(SKAction.sequence([whackAction, SKAction.wait(forDuration: 0.1), fallingAction]))
        gameScene.stopSpawning()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is GameOverState.Type
    }
    
    
}
