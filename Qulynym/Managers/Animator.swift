/*
* Kulynym
* Animator.swift
*
* Created by: Metah on 5/10/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit
import QuartzCore

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK:- Properties
    let duration = 0.7
    weak var fromView: UIView!
    weak var toView: UIView!
    weak var containerView: UIView!
    var bubbleClipView: UIView!
    
    
    // MARK:- Protocol Methods
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        AudioPlayer.setupExtraAudio(with: "bubbles", audioPlayer: .effects)
        setupViews(context: transitionContext)
        containerView.addSubview(toView)
        initBubbleView(view: containerView)
        setupBeginningValues()
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, animations: {
            self.callKeyframes()
        }, completion: { _ in
            transitionContext.completeTransition(true)
            self.bubbleClipView.removeFromSuperview()
        })
    }
    
    
    // MARK: Helper Methods
    private func setupViews(context: UIViewControllerContextTransitioning) {
        fromView = context.viewController(forKey: .from)!.view
        toView = context.viewController(forKey: .to)!.view
        containerView = context.containerView
    }
    
    private func initBubbleView(view: UIView) {
        bubbleClipView = UIView(frame: view.frame.offsetBy(dx: 0, dy: 0))
        bubbleClipView.clipsToBounds = true
        let bubbleView = BubbleView(frame: CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: view.frame.height))        
        bubbleClipView.addSubview(bubbleView)
        view.addSubview(bubbleClipView)
    }
    
    private func setupBeginningValues() {
        toView.alpha = 0
        bubbleClipView.alpha = 0
        fromView.backgroundColor = .black
        fromView.layer.opacity = 0.6
    }
    
    private func callKeyframes() {
        let halfOfDuration = self.duration * 0.5
        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: halfOfDuration, animations: {
            self.bubbleClipView.alpha = 1
        })
        UIView.addKeyframe(withRelativeStartTime: halfOfDuration, relativeDuration: halfOfDuration, animations: {
            self.setupEndingValues()
        })
    }
    
    private func setupEndingValues() {
        toView.alpha = 1
        fromView.layer.opacity = 1
        bubbleClipView.alpha = 0
    }
}
