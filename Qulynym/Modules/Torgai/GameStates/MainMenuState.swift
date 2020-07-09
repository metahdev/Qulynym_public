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

class MainMenuState: GKState {
    // MARK: - Properties
    unowned let gameScene: GameScene
    
    private lazy var logoNode: SKSpriteNode = {
        let sn = SKSpriteNode(imageNamed: "logotype")
        sn.position = CGPoint(x: gameScene.size.width / 2, y: gameScene.size.height * 0.8)
        sn.zPosition = Layer.ui.rawValue
        sn.size = CGSize(width: 276, height: 82)
        return sn
    }()
    private lazy var playButtonNode: SKSpriteNode = {
        let sn = SKSpriteNode(imageNamed: "long button")
        sn.position = CGPoint(x: gameScene.size.width * 0.5, y: gameScene.size.height * 0.25)
        sn.zPosition = Layer.ui.rawValue
        return sn
    }()
    private lazy var playTextNode: SKSpriteNode = {
        let sn = SKSpriteNode(imageNamed: "play")
        sn.position = CGPoint.zero
        sn.zPosition = Layer.ui.rawValue
        sn.size = CGSize(width: 74, height: 20)
        return sn
    }()
    
    // MARK: - View Lifecycle
    init(scene: SKScene) {
        self.gameScene = scene as! GameScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        gameScene.setupAndAddBackgroundNode()
        gameScene.setupForegroundNode()
        gameScene.setupAndAddPlayer()
        addChilds()
        
        gameScene.player.movementAllowed = false
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is TutorialState.Type
    }
    
    // MARK: - Layout
    private func addChilds() {
        gameScene.worldNode.addChild(logoNode)
        gameScene.worldNode.addChild(playButtonNode)
        playButtonNode.addChild(playTextNode)
    }
}





















