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
    var presenter: MainMenuPresenterProtocol!
    var scenesViewDelegate: ScenesViewControllerProtocol!
    
    private var iconButtons = [UIButton]()
    private var btnsAndIndexes = [UIButton: Int]()
    
    private weak var alphabetBtn: UIButton!
    private weak var numbersBtn: UIButton!
    private weak var animalsBtn: UIButton!
    private weak var plantsBtn: UIButton!
    private weak var karaokeBtn: UIButton!
    private weak var storyTalesBtn: UIButton!
    private weak var drawingBtn: UIButton!
    
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
        setupArray()
        assignActionsAndIndexes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.updateProgressState()
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        autoLayout = MainMenuAutoLayout(self.view)
    }
    
    private func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
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
    
    
    // MARK:- Array of Buttons
    private func setupArray() {
        iconButtons.append(alphabetBtn)
        iconButtons.append(numbersBtn)
        iconButtons.append(animalsBtn)
        iconButtons.append(plantsBtn)
        iconButtons.append(karaokeBtn)
        iconButtons.append(storyTalesBtn)
        iconButtons.append(drawingBtn)
    }
    
    
    // MARK:- Actions
    private func assignActionsAndIndexes() {
        var index = 0
        for button in iconButtons {
            addTargetToIconBtn(button)
            self.btnsAndIndexes[button] = index
            index += 1
        }
    }
    
    private func addTargetToIconBtn(_ btn: UIButton) {
        btn.addTarget(self, action: #selector(iconButtonsTouched(sender:)), for: .touchUpInside)
    }
    
    @objc func iconButtonsTouched(sender: UIButton) {
        let directionIndex = btnsAndIndexes[sender]
        presenter.iconPressed(with: directionIndex!)
    }
}

extension MainMenuViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator()
    }
}
