/*
* Qulynym
* ScenesViewController.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol ScenesViewControllerProtocol: class {
    var manager: ScenesManagerProtocol! { get set }
}

class ScenesViewController: UIViewController, ScenesViewControllerProtocol {
    // MARK:- Properties
    var presenter: ScenesPresenterProtocol!
    
    var manager: ScenesManagerProtocol!
    
    weak var sceneImageView: UIImageView!
    private weak var skipBtn: UIButton!
    
    private var scenesView: ScenesViewProtocol!
    private var configurator: ScenesConfiguratorProtocol = ScenesConfigurator()
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        initLayout()
        scenesView.setupLayout()
        assignViews()
        assignActions()
        
        presenter.playAudio()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if manager.instruction.hasSuffix("Passed") {
            sceneImageView.loadGif(name: "congratulationsGif")
            return 
        }
        sceneImageView.loadGif(name: manager.instruction + "Gif")
    }
    
    // MARK:- Layout
    private func initLayout() {
        scenesView = ScenesView(self.view)
    }
    
    private func assignViews() {
        self.sceneImageView = scenesView.sceneImageView
        self.skipBtn = scenesView.skipBtn
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        skipBtn.addTarget(self, action: #selector(skipBtnPressed), for: .touchUpInside)
    }
    
    @objc func skipBtnPressed() {
        presenter.skipBtnPressed()
    }
}

//extension ScenesViewController: UIViewControllerTransitioningDelegate {
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//    }
//}
