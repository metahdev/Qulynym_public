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

class GameViewController: UIViewController {
    // MARK:- Properties
    lazy var closeBtn: UIButton = {
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
        view = SKView(frame: view.bounds)
        
        if let view = self.view as! SKView? {
            let aspectRatio = view.bounds.size.height / view.bounds.size.width
            let scene = GameScene(size: CGSize(width: 320, height: 320 * aspectRatio), stateClass: MainMenuState.self)

            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            
            // Scene properties
            view.showsPhysics = false
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
        }
        
        view.addSubview(closeBtn)
        NSLayoutConstraint.activate([
            closeBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            closeBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            closeBtn.heightAnchor.constraint(equalTo: closeBtn.widthAnchor)
        ])
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown]
    }

    
    @objc func closeGame() {
        AppUtility.lockOrientation(.landscape, andRotateTo: .landscapeRight)
        self.navigationController?.popViewController(animated: true)
    }
}
