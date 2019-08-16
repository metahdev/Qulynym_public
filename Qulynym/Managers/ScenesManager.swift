/*
* Kulynym
* ScenesManager.swift
*
* Created by: Metah on 6/5/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol ScenesManagerProtocol: class {
    var instruction: String { get set }
    var visualEffectView: UIVisualEffectView! { get set }
}

// ** - references to each other
class ScenesManager: ScenesManagerProtocol {
    // MARK:- Properties
    var visualEffectView: UIVisualEffectView!
    var instruction: String
    private var scenesView = ScenesViewController()
    private weak var callingView: UIViewController!
    private var shown = false
    
    init(calling view: UIViewController, showing instruction: String) {
        self.callingView = view
        self.instruction = instruction
    }
    
    
    // MARK:- Alert
    func showAlert() {
        checkIfAlreadyShown()
        
        if shown { return }
        
        setupEffect()
        setupMessageVC()
        setupMessageView()
        activateConstraints()
        saveAppearence()
    }
    
    private func checkIfAlreadyShown() {
        if UserDefaults.standard.object(forKey: instruction + "hasShown") != nil {
            shown = true
        }
    }
    
    private func setupEffect() {
        visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = callingView.view.frame
        callingView.view.addSubview(visualEffectView)
    }
    
    private func setupMessageVC() {
        scenesView.manager = self
        callingView.addChild(scenesView)
        callingView.view.addSubview(scenesView.view)
        scenesView.didMove(toParent: callingView)
    }
    
    private func setupMessageView() {
        scenesView.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    // MARK:- Constraints
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            scenesView.view.centerXAnchor.constraint(equalTo: callingView.view.centerXAnchor),
            scenesView.view.centerYAnchor.constraint(equalTo: callingView.view.centerYAnchor),
            scenesView.view.widthAnchor.constraint(equalTo: callingView.view.widthAnchor, multiplier: 0.6),
            scenesView.view.heightAnchor.constraint(equalTo: callingView.view.heightAnchor, multiplier: 0.6)
        ])
    }
    
    // MARK:- Save Data
    private func saveAppearence() {
        UserDefaults.standard.set(1, forKey: instruction + "hasShown")
    }
}

