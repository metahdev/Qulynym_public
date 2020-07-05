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
    unowned let gameScene: GameScene
    
    init(scene: SKScene) {
        self.gameScene = scene as! GameScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        gameScene.setupAndAddBackgroundNode()
        gameScene.setupForegroundNode()
        gameScene.setupAndAddPlayer()
        setupMainMenu()
        
        gameScene.player.movementAllowed = false
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is TutorialState.Type
    }
    
    private func setupMainMenu() {
        let logo = SKSpriteNode(imageNamed: "logotype")
        logo.position = CGPoint(x: gameScene.size.width / 2, y: gameScene.size.height * 0.8)
        logo.zPosition = Layer.ui.rawValue
        logo.size = CGSize(width: 276, height: 82)
        gameScene.worldNode.addChild(logo)
        
        let playButton = SKSpriteNode(imageNamed: "long button")
        playButton.position = CGPoint(x: gameScene.size.width * 0.5, y: gameScene.size.height * 0.25)
        playButton.zPosition = Layer.ui.rawValue
        gameScene.worldNode.addChild(playButton)
        
        let playButtonText = SKSpriteNode(imageNamed: "play")
        playButtonText.position = CGPoint.zero
        playButtonText.zPosition = Layer.ui.rawValue
        playButtonText.size = CGSize(width: 74, height: 20)
        playButton.addChild(playButtonText)
    }
}





















