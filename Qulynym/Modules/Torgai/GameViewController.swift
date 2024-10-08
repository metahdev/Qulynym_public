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

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: QulynymVC {
    // MARK:- Properties
    private lazy var aspectRatio = view.bounds.size.height / view.bounds.size.width
    
    private lazy var scene: GameScene = {
        let s = GameScene(size: CGSize(width: 320, height: 320 * aspectRatio), stateClass: MainMenuState.self)
        s.scaleMode = .aspectFill
        return s
    }()

    private lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.zPosition = 1
        btn.setImage(UIImage(named: "torg'aiClose"), for: .normal)
        btn.addTarget(self, action: #selector(closeGame), for: .touchUpInside)
        return btn
    }()
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.addSubview(closeBtn)
        NSLayoutConstraint.activate([
            closeBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            closeBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 36),
            closeBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            closeBtn.heightAnchor.constraint(equalTo: closeBtn.widthAnchor)
        ])
    }

    // MARK: - Orientation
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown]
    }

    // MARK: - Actions
    private func setupView() {
        view = SKView(frame: view.bounds)
        
        if let view = self.view as! SKView? {
            view.presentScene(scene)
            
            view.showsPhysics = false
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
    
    @objc func closeGame() {
        guard let vc = self.navigationController?.viewControllers[1] as? MenuViewController else {
            return
        }
        vc.fromGame = true
        self.navigationController?.popToViewController(vc, animated: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + Animator.duration - 0.5, execute: {
            AppUtility.lockOrientation(.landscape, andRotateTo: AppUtility.currentOrientation!)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + Animator.duration, execute: {
            vc.hideBackground(false)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + Animator.duration + 0.25, execute: {
            vc.hideTransitionViews(false)
            vc.fromGame = false
        })
    }
    
    func playerSize() -> CGSize {
        if traitCollection.horizontalSizeClass == .regular {
            return CGSize(width: 32, height: 24)
        } else {
            return CGSize(width: 53.33, height: 40)
        }
    }
    
    func obstacleSize() -> CGSize {
        if traitCollection.horizontalSizeClass == .regular {
            return CGSize(width: 32.4, height: 252.8)
        } else {
            return CGSize(width: 54, height: 316)
        }
    }
}


