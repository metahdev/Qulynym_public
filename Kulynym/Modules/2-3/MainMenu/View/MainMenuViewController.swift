/*
* Kulynym
* MainMenuViewController.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol MainMenuViewControllerProtocol: class {}

class MainMenuViewController: UIViewController, MainMenuViewControllerProtocol {
    // MARK:- Properties
    weak var alphabetBtn: UIButton!
    weak var numbersBtn: UIButton!
    weak var animalsBtn: UIButton!
    weak var plantsBtn: UIButton!
    weak var karaokeBtn: UIButton!
    weak var storyTalesBtn: UIButton!
    weak var drawingBtn: UIButton!
    
    var presenter: MainMenuPresenterProtocol!
    var scenesViewDelegate: ScenesViewControllerProtocol!
    private var autoLayout: MainMenuAutoLayoutProtocol!
    private var configurator: MainMenuConfiguratorProtocol = MainMenuConfigurator()
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        initLayout()
        autoLayout.setupLayout()
        hideNavigationBar()
        assignViews()
        assignActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.updateProgressState()
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        autoLayout = MainMenuAutoLayout(self.view)
    }
    
    private func assignViews() {
        self.alphabetBtn = autoLayout.alphabetBtn
        self.numbersBtn = autoLayout.numbersBtn
        self.animalsBtn = autoLayout.animalsBtn
        self.plantsBtn = autoLayout.plantsBtn
        self.karaokeBtn = autoLayout.karaokeBtn
        self.storyTalesBtn = autoLayout.storyTalesBtn
        self.drawingBtn = autoLayout.drawingBtn
    }
    
    private func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        addTargetToIconBtn(btn: alphabetBtn)
        addTargetToIconBtn(btn: numbersBtn)
        addTargetToIconBtn(btn: animalsBtn)
        addTargetToIconBtn(btn: plantsBtn)
        addTargetToIconBtn(btn: karaokeBtn)
        addTargetToIconBtn(btn: storyTalesBtn)
        addTargetToIconBtn(btn: drawingBtn)
    }
    
    private func addTargetToIconBtn(btn: UIButton) {
        btn.addTarget(self, action: #selector(iconButtonsTouched(sender:)), for: .touchUpInside)
    }
    
    @objc func iconButtonsTouched(sender: UIButton) {
        let direction = compareSender(sender: sender)
        presenter.iconPressed(with: direction)
    }
    
    private func compareSender(sender: UIButton) -> String {
        switch sender {
        case alphabetBtn: return "alphabetIcon"
        default: return ""
        }
    }
}

extension MainMenuViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator()
    }
}
