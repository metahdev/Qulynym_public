/*
* Kulynym
* Message.swift
*
* Created by: Metah on 6/5/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

enum Emotion {
    case happy
    case sad
}

class MessageManager {
    // MARK:- Properties
    var messageView = MessageViewController()
    var visualEffectView: UIVisualEffectView!
    private weak var callingView: UIViewController! 
    private var emotion: Emotion
    
    init(calling view: UIViewController, showing emotion: Emotion) {
        self.callingView = view
        self.emotion = emotion
    }
    
    
    // MARK:- Alert
    func showAlert() {
        callingView.addChild(messageView)
        callingView.view.addSubview(messageView.view)
        messageView.view.translatesAutoresizingMaskIntoConstraints = false
        messageView.didMove(toParent: callingView)
        activateConstraints()
        setupEffect()
        configureProperties()
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            messageView.view.centerXAnchor.constraint(equalTo: callingView.view.centerXAnchor),
            messageView.view.centerYAnchor.constraint(equalTo: callingView.view.centerYAnchor),
            messageView.view.widthAnchor.constraint(equalTo: callingView.view.widthAnchor, multiplier: 0.6),
            messageView.view.heightAnchor.constraint(equalTo: callingView.view.heightAnchor, multiplier: 0.6)
        ])
    }
    
    private func setupEffect() {
        visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = callingView.view.frame
        callingView.view.addSubview(visualEffectView)
        messageView.view.layer.zPosition = 1
    }
    
    private func configureProperties() {
        switch emotion {
        case .happy:
            changeValues(image: "happyChar")
        case .sad:
            changeValues(image: "sadChar")
        }
    }
    
    private func changeValues(image name: String) {
        messageView.imageName = name
    }
}

