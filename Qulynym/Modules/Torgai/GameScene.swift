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
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    // MARK: - Properties
    var scoreFontName = "Arial Rounded MT Bold"
    var scoreNumber = 0
    
    private let numberOfForegrounds = 2
    
    var playableStart: CGFloat = 0
    static var playableHeight: CGFloat = 0
    
    private let groundSpeed: CGFloat = 150
    
    private let bottomObstacleMinFraction: CGFloat = 0.1
    private let bottomObstacleMaxFraction: CGFloat = 0.6
    private let gapMultiplier: CGFloat = 4.5
    
    var margin: CGFloat = 28.0
    
    private let firstSpawnDelay: TimeInterval = 1.75
    private let everySpawnDelay: TimeInterval = 1.5
    
    private var deltaTime: TimeInterval = 0
    private var lastUpdateTimeInterval: TimeInterval = 0
    
    private let backgroundNode = SKSpriteNode(imageNamed: "background")
    
    let worldNode = SKNode()
        
    lazy var player = PlayerEntity(imageName: "torgai0")
    
    private lazy var playerNode = player.spriteComponent.node
    
    private var initialState: AnyClass
    
    private lazy var stateMachine: GKStateMachine = GKStateMachine(states: [
        MainMenuState(scene: self),
        TutorialState(scene: self),
        PlayingState(scene: self),
        FallingState(scene: self),
        GameOverState(scene: self)
        ])
    
    private lazy var scoreLabel = SKLabelNode(fontNamed: scoreFontName)
    private let pointAction = SKAction.playSoundFileNamed("coin.wav", waitForCompletion: false)
    
    // MARK: - Inits
    init(size: CGSize, stateClass: AnyClass) {
        initialState = stateClass
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override funcs
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        addChild(worldNode)
        stateMachine.enter(initialState)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch stateMachine.currentState {
            case is MainMenuState:
                restartGame(TutorialState.self)
            case is TutorialState:
                stateMachine.enter(PlayingState.self)
            case is PlayingState:
                player.movementComponent.applyImpulse(lastUpdateTimeInterval)
            case is GameOverState:
                restartGame(TutorialState.self)
            default:
                break
            }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTimeInterval == 0 {
            lastUpdateTimeInterval = currentTime
        }
        
        deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        stateMachine.update(deltaTime: deltaTime)
        
        player.update(deltaTime: deltaTime)
    }
        
    // MARK: - Layout
    func setupAndAddBackgroundNode() {
        setupBackgroundNodeParameters()
        setupBackgroundPhysicsBody()
        worldNode.addChild(backgroundNode)
    }
    
    private func setupBackgroundNodeParameters() {
        backgroundNode.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        backgroundNode.position = CGPoint(x: size.width / 2, y: size.height)
        backgroundNode.zPosition = Layer.background.rawValue
        backgroundNode.size.height = size.height * 0.72
        playableStart = size.height - backgroundNode.size.height
        GameScene.playableHeight = size.height
    }
    
    private func setupBackgroundPhysicsBody() {
        let lowerLeft = CGPoint(x: 0, y: playableStart)
        let lowerRight = CGPoint(x: size.width, y: playableStart)
        
        let topLimitLeft = CGPoint(x: 0, y: frame.height + 200)
        let topLimitRight = CGPoint(x: size.width, y: frame.height + 200)
        
        physicsBody = SKPhysicsBody(bodies: [SKPhysicsBody(edgeFrom: lowerLeft, to: lowerRight), SKPhysicsBody(edgeFrom: topLimitLeft, to: topLimitRight)])
        physicsBody?.categoryBitMask = PhysicsCategory.Ground
        physicsBody?.collisionBitMask = 0
        physicsBody?.contactTestBitMask = PhysicsCategory.Player
    }
    
    func setupForegroundNode() {
        for i in 0..<numberOfForegrounds {
            let foregroundNode = SKSpriteNode(imageNamed: "foreground")
            foregroundNode.anchorPoint = CGPoint(x: 0.0, y: 1.0)
            foregroundNode.size.width = size.width
            foregroundNode.position = CGPoint(x: CGFloat(i) * foregroundNode.size.width, y: playableStart)
            foregroundNode.zPosition = Layer.foreground.rawValue
            foregroundNode.name = "foreground"
            foregroundNode.size.height = size.height - backgroundNode.size.height
            worldNode.addChild(foregroundNode)
        }
    }
    
    func setupAndAddPlayer() {
        setupPlayer()
        worldNode.addChild(playerNode)
    }
    
    private func setupPlayer() {
        playerNode.position = CGPoint(x: size.width * 0.2, y: GameScene.playableHeight * 0.4 + playableStart)
        playerNode.zPosition = Layer.player.rawValue
        
        player.movementComponent.playableStart = playableStart
        player.animationComponent.startWobble()
    }
    
    func setupAndAddScoreLabel() {
        setupScoreLabel()
        worldNode.addChild(scoreLabel)
    }
    
    private func setupScoreLabel() {
        scoreLabel.fontColor = SKColor(red: 101.0/255.0, green: 71.0/255.0, blue: 73.0/255.0, alpha: 1.0)
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height - margin)
        scoreLabel.verticalAlignmentMode = .top
        scoreLabel.zPosition = Layer.ui.rawValue
        scoreLabel.text = "\(scoreNumber)"
    }
    
    private func createObstacle() -> SKSpriteNode {
        let obstacle = ObstacleEntity(imageName: "obstacle")
        let obstacleNode = obstacle.spriteComponent.node
        obstacleNode.zPosition = Layer.obstacle.rawValue
        obstacleNode.name = "obstacle"
        obstacleNode.userData = NSMutableDictionary()
        
        return obstacle.spriteComponent.node
    }
    
    func stopSpawning() {
        removeAction(forKey: "spawn")
        worldNode.enumerateChildNodes(withName: "obstacle", using: { node, stop in node.removeAllActions()
        })
    }
    
    func startSpawning() {
        let firstDelay = SKAction.wait(forDuration: firstSpawnDelay)
        let spawn = SKAction.run(spawnObstacle)
        let everyDelay = SKAction.wait(forDuration: everySpawnDelay)
        
        let spawnSequence = SKAction.sequence([spawn, everyDelay])
        let foreverSpawn = SKAction.repeatForever(spawnSequence)
        let overallSequence = SKAction.sequence([firstDelay, foreverSpawn])
        
        run(overallSequence, withKey: "spawn")
    }
    
    private func spawnObstacle() {
        let bottomObstacle = createObstacle()
        let startX = size.width + bottomObstacle.size.width / 2
        
        let bottomObstacleMin = (playableStart - bottomObstacle.size.height / 2) + backgroundNode.size.height * bottomObstacleMinFraction
        let bottomObstacleMax = (playableStart - bottomObstacle.size.height / 2) + backgroundNode.size.height * bottomObstacleMaxFraction
        
        let randomDistribution = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: Int(round(bottomObstacleMin)), highestValue: Int(round(bottomObstacleMax)))
        let randomValue = randomDistribution.nextInt()
        
        bottomObstacle.position = CGPoint(x: startX, y: CGFloat(randomValue))
        worldNode.addChild(bottomObstacle)
        
        let topObstacle = createObstacle()
        topObstacle.zRotation = CGFloat(180).degreesToRadians()
        topObstacle.position = CGPoint(x: startX, y: bottomObstacle.position.y + bottomObstacle.size.height / 2 + topObstacle.size.height / 2 + player.spriteComponent.node.size.height * gapMultiplier)
        worldNode.addChild(topObstacle)
        
        let moveX = size.width + topObstacle.size.width
        let moveDuration = moveX / groundSpeed
        
        let sequence = SKAction.sequence([
            SKAction.moveBy(x: -moveX, y: 0, duration: TimeInterval(moveDuration)),
            SKAction.removeFromParent()
            ])
        
        topObstacle.run(sequence)
        bottomObstacle.run(sequence)
    }
    
    func updateForeground() {
        worldNode.enumerateChildNodes(withName: "foreground", using:
            { node, stop in
                if let ground = node as? SKSpriteNode {
                    let moveAmount = CGPoint(x: -self.groundSpeed * CGFloat(self.deltaTime),
                                             y: 0)
                    ground.position += moveAmount
                    
                    if ground.position.x < -ground.size.width {
                        ground.position += CGPoint(x: ground.size.width * CGFloat(self.numberOfForegrounds), y: 0)
                    }
                }
        })
    }
    
    func updateScore() {
        worldNode.enumerateChildNodes(withName: "obstacle", using: { node, stop in
            if let barrier = node as? SKSpriteNode {
                if let passed = barrier.userData?["Passed"] as? NSNumber {
                    if passed.boolValue {
                        return
                    }
                }
                
                if self.player.spriteComponent.node.position.x > barrier.position.x + barrier.size.width / 2 {
                    self.scoreNumber += 1
                    self.scoreLabel.text = "\(self.scoreNumber / 2)"
                    barrier.userData?["Passed"] = NSNumber(value: true as Bool)
                    self.run(self.pointAction)
                }
            }
        })
    }
    
    private func restartGame(_ stateClass: AnyClass) {
        let newGameScene = GameScene(size: size, stateClass: stateClass)
        let transition = SKTransition.fade(with: SKColor.black, duration: 0.02)
        view?.presentScene(newGameScene, transition: transition)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let other = contact.bodyA.categoryBitMask == PhysicsCategory.Player ? contact.bodyB : contact.bodyA
        
        if other.categoryBitMask == PhysicsCategory.Ground {
            stateMachine.enter(GameOverState.self)
        }
        
        if other.categoryBitMask == PhysicsCategory.Obstacle {
            stateMachine.enter(FallingState.self)
        }
    }
}
