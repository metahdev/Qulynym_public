/*
* Kulynym
* Message.swift
*
* Created by: Metah on 6/5/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

enum Emotion: String {
    case hello = "helloMessage"
    case karaoke = "karaokeMessage"
    case stories = "storiesMessage"
    case drawing = "drawingMessage"
    case games = "gamesMessage"
}

protocol MessageShowingVC {
    var message: MessageManager! { get set }
    func initMessage()
}

protocol MessageManagerProtocol: class {
    var visualEffectView: UIVisualEffectView! { get set }
}

class MessageManager {
    // MARK:- Properties
    var visualEffectView: UIVisualEffectView!
    private var messageView = MessageViewController()
    private weak var callingView: UIViewController!
    private var emotion: Emotion
    
    init(calling view: UIViewController, showing emotion: Emotion) {
        self.callingView = view
        self.emotion = emotion
    }
    
    
    // MARK:- Alert
    func showAlert() {
        setupEffect()
        setupMessageVC()
        setupMessageView()
        activateConstraints()
        configureProperties()
    }
    
    private func setupEffect() {
        visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = callingView.view.frame
        callingView.view.addSubview(visualEffectView)
    }
    
    private func setupMessageVC() {
        callingView.addChild(messageView)
        callingView.view.addSubview(messageView.view)
        messageView.didMove(toParent: callingView)
    }
    
    private func setupMessageView() {
        messageView.view.translatesAutoresizingMaskIntoConstraints = false
        messageView.message = self
    }
    
    
    // MARK:- Constraints
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            messageView.view.centerXAnchor.constraint(equalTo: callingView.view.centerXAnchor),
            messageView.view.centerYAnchor.constraint(equalTo: callingView.view.centerYAnchor),
            messageView.view.widthAnchor.constraint(equalTo: callingView.view.widthAnchor, multiplier: 0.6),
            messageView.view.heightAnchor.constraint(equalTo: callingView.view.heightAnchor, multiplier: 0.6)
        ])
    }
    
    
    // MARK:- Send Data
    private func configureProperties() {
        messageView.imageName = "happyChar"
        messageView.audioName = emotion.rawValue
    }
}

