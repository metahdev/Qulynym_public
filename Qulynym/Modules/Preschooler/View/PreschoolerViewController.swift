/*
* Kulynym
* PreschoolerViewController.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol PreschoolerViewControllerProtocol: class {}

class PreschoolerViewController: UIViewController, PreschoolerViewControllerProtocol {
    // MARK:- Properties
    var presenter: PreschoolerPresenterProtocol!
    weak var scenesViewDelegate: ScenesViewControllerProtocol!
    
    private var iconButtons = [UIButton]()
    private var btnsAndIndexes = [UIButton: Int]()
    
    private weak var seasonsBtn: UIButton!
    private weak var profBtn: UIButton!
    private weak var closeBtn: UIButton!
    private weak var mainScrollView: UIScrollView!
    
    private var preschoolerView: PreschoolerViewProtocol!
    private var configurator: PreschoolerConfiguratorProtocol = PreschoolerConfigurator()
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        initLayout()
        preschoolerView.setupLayout()
        assignViews()
        setupArray()
        assignActions()
        assignActionsAndIndexes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.updateProgressState()
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        preschoolerView = PreschoolerView(self.view)
    }
    
    private func assignViews() {
        self.closeBtn = preschoolerView.closeBtn
        self.mainScrollView = preschoolerView.scrollView
        self.seasonsBtn = preschoolerView.seasonsBtn
        self.profBtn = preschoolerView.profBtn
    }
    

    // MARK:- Array of Buttons
    private func setupArray() {
        iconButtons.append(seasonsBtn)
        iconButtons.append(profBtn)
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
    }
    
    private func assignActionsAndIndexes() {
        // **
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
    
    @objc private func closeBtnPressed() {
        presenter.closeView()
    }
    
    @objc private func iconButtonsTouched(sender: UIButton) {
        let directionIndex = btnsAndIndexes[sender]
        presenter.iconPressed(with: directionIndex!)
    }
}

extension PreschoolerViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator()
    }
}

