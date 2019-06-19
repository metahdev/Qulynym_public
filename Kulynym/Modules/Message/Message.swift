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
    case success
    case failure
    case karaoke
    case stories
}

class Message {
    // MARK:- Properties
    var messageView = MessageViewController()
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
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = callingView.view.bounds
        callingView.view.addSubview(visualEffectView)
        callingView.view.alpha = 0
    }
    
    private func configureProperties() {
        switch emotion {
        case .success:
            changeValues(image: "happyChar", title: "Well Done!")
        case .failure:
            changeValues(image: "sadChar", title: "Try Again!")
        case .karaoke:
            changeValues(image: "karaokeChar", title: "Choose the Song!")
        case .stories:
            changeValues(image: "storiesChar", title: "Choose the Story!")
        }
    }
    
    private func changeValues(image name: String, title text: String) {
        messageView.imageName = name
        messageView.titleText = text
    }
}

