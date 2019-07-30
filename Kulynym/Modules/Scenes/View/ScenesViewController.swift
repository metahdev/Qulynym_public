/*
* Kulynym
* ScenesViewController.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol ScenesViewControllerProtocol: class {
    var section: EduSection! { get set }
    
    func fillContent(image named: String)
}

class ScenesViewController: UIViewController, ScenesViewControllerProtocol {
    // MARK:- Properties
    var presenter: ScenesPresenterProtocol!
    weak var itemViewDelegate: ItemVCProtocol!
    
    var section: EduSection!
    
    private weak var sceneImageView: UIImageView!
    private weak var skipBtn: UIButton!
    
    private var autoLayout: ScenesAutoLayoutProtocol!
    private var configurator: ScenesConfiguratorProtocol = ScenesConfigurator()
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        initLayout()
        autoLayout.setupLayout()
        assignViews()
        assignActions()
        
        presenter.playAudio()
        presenter.startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.getScenes()
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        autoLayout = ScenesAutoLayout(self.view)
    }
    
    private func assignViews() {
        self.sceneImageView = autoLayout.sceneImageView
        self.skipBtn = autoLayout.skipBtn
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        skipBtn.addTarget(self, action: #selector(skipBtnPressed), for: .touchUpInside)
    }
    
    @objc func skipBtnPressed() {
        presenter.skipBtnPressed()
    }
}

extension ScenesViewController {
    func fillContent(image named: String) {
        sceneImageView.image = UIImage(named: named)
    }
}

extension ScenesViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator()
    }
}
