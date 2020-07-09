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

class GameOverState: GKState {
    // MARK: - Properties
    unowned let gameScene: GameScene
    
    private lazy var  hitGroundAction = SKAction.playSoundFileNamed("hitGround.wav", waitForCompletion: false)
    private lazy var  animationDelay = 0.3
    private lazy var animationGroup: SKAction = {
        let group = SKAction.group([
            SKAction.fadeIn(withDuration: animationDelay),
            SKAction.scale(to: 1.0, duration: animationDelay)
        ])
        group.timingMode = .easeInEaseOut
        return group
    }()
    private lazy var moveToAction: SKAction = {
        let action = SKAction.move(to: CGPoint(x: gameScene.size.width / 2, y: gameScene.size.height / 2), duration: animationDelay)
        action.timingMode = .easeInEaseOut
        return action
    }()
    private lazy var fadeIn = SKAction.sequence([
        SKAction.wait(forDuration: animationDelay * 3),
        SKAction.fadeIn(withDuration: animationDelay)
    ])
    
    private lazy var scorecardNode: SKSpriteNode = {
        let sn = SKSpriteNode(imageNamed: "score card")
        sn.position = CGPoint(x: gameScene.size.width * 0.5, y: gameScene.size.height * 0.5)
        sn.name = "Tutorial"
        sn.zPosition = Layer.ui.rawValue
        sn.size = CGSize(width: 272, height: 104)
        return sn
    }()
    private lazy var lastScoreLabelNode: SKLabelNode = {
        let lbl = SKLabelNode(fontNamed: gameScene.scoreFontName)
        lbl.fontColor = SKColor(red: 101.0/255.0, green: 71.0/255.0, blue: 73.0/255.0, alpha: 1.0)
        lbl.zPosition = Layer.ui.rawValue
        lbl.text = "\(gameScene.scoreNumber / 2)"
        lbl.position = CGPoint(x: -scorecardNode.size.width * 0.25, y: -scorecardNode.size.height * 0.2)
        return lbl
    }()
    private lazy var bestScoreLabelNode: SKLabelNode = {
        let lbl = SKLabelNode(fontNamed: gameScene.scoreFontName)
        lbl.fontColor = SKColor(red: 101.0/255.0, green: 71.0/255.0, blue: 73.0/255.0, alpha: 1.0)
        lbl.zPosition = Layer.ui.rawValue
        lbl.text = "\(getBestScore() / 2)"
        lbl.position = CGPoint(x: scorecardNode.size.width * 0.25, y: -scorecardNode.size.height * 0.2)
        return lbl
    }()
    private lazy var gameOverNode: SKSpriteNode = {
        let sn = SKSpriteNode(imageNamed: "game over")
        sn.zPosition = Layer.ui.rawValue
        sn.size = CGSize(width: 186, height: 82)
        sn.setScale(0)
        sn.alpha = 0
        sn.position = CGPoint(x: gameScene.size.width / 2, y: gameScene.size.height * 0.8)
        return sn
    }()
    private lazy var okButtonNode: SKSpriteNode = {
        let sn  = SKSpriteNode(imageNamed: "long button")
        sn.zPosition = Layer.ui.rawValue
        sn.alpha = 0
        sn.position = CGPoint(x: gameScene.size.width * 0.5, y: gameScene.size.height / 2 - scorecardNode.size.height / 2 - gameScene.margin - sn.size.height / 2)
        return sn
    }()
    private lazy var okTextNode: SKSpriteNode = {
        let sn = SKSpriteNode(imageNamed: "ok")
        sn.position = CGPoint.zero
        sn.zPosition = Layer.ui.rawValue
        sn.size = CGSize(width: 38, height: 20)
        return sn
    }()
    
    // MARK: - View Lifecycle
    init(scene: SKScene) {
        self.gameScene = scene as! GameScene
        super.init()
    }

    override func didEnter(from previousState: GKState?) {
        gameScene.run(hitGroundAction)
        gameScene.stopSpawning()
        gameScene.player.movementAllowed = false
        showScorecard()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is PlayingState.Type
    }
    
    
    // MARK: - Layout
    private func showScorecard() {
        if gameScene.scoreNumber > getBestScore() {
            setBestScore(gameScene.scoreNumber)
        }
        
        addChilds()
        
        gameOverNode.run(SKAction.sequence([
            SKAction.wait(forDuration: animationDelay),
            animationGroup
        ]))
        
        changeScorecardPosition()
        
        scorecardNode.run(SKAction.sequence([
            SKAction.wait(forDuration: animationDelay * 2),
            moveToAction
        ]))
        okButtonNode.run(fadeIn)
    }
    
    func addChilds() {
        gameScene.worldNode.addChild(scorecardNode)
        scorecardNode.addChild(lastScoreLabelNode)
        scorecardNode.addChild(bestScoreLabelNode)
        gameScene.worldNode.addChild(gameOverNode)
        gameScene.worldNode.addChild(okButtonNode)
        okButtonNode.addChild(okTextNode)
    }
    
    func changeScorecardPosition() {
        scorecardNode.position = CGPoint(x: gameScene.size.width * 0.5, y: -scorecardNode.size.height / 2)
    }
    
    // MARK: - Actions
    private func setBestScore(_ bestScore: Int) {
        UserDefaults.standard.set(bestScore, forKey: "BestScore")
        UserDefaults.standard.synchronize()
    }
    
    private func getBestScore() -> Int {
        return UserDefaults.standard.integer(forKey: "BestScore")
    }
}
