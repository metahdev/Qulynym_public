/*
* Kulynym
* PreschoolerViewController.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol PreschoolerViewProtocol: class {}

class PreschoolerViewController: UIViewController, PreschoolerViewProtocol {
    // MARK:- Properties
    var presenter: PreschoolerPresenterProtocol!
    weak var scenesViewDelegate: ScenesViewControllerProtocol!
    weak var playlistViewDelegate: PlaylistViewProtocol!
    
    private var iconButtons = [UIButton]()
    private var btnsAndIndexes = [UIButton: Int]()
    
    private weak var logicBtn: UIButton!
    
    private var autoLayout: PreschoolerAutoLayoutProtocol!
    private var configurator: PreschoolerConfiguratorProtocol = PreschoolerConfigurator()
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        initLayout()
        autoLayout.setupLayout()
        assignViews()
        setupArray()
        assignActionsAndIndexes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.updateProgressState()
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        autoLayout = PreschoolerAutoLayout(self.view)
    }
    
    private func assignViews() {
        
    }
    

    // MARK:- Array of Buttons
    private func setupArray() {
        
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

extension PreschoolerViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator()
    }
}
