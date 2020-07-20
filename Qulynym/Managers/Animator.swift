 /*
* Qulynym
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
    static let duration = 1.0

    weak var containerView: UIView!
    weak var toView: UIView!
    var bubbleClipView: UIView!
    
    
    
    // MARK:- Protocol Methods
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Animator.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        setupViews(context: transitionContext)
        
        AudioPlayer.setupExtraAudio(with: "bubbles", audioPlayer: .effects)
        
        containerView.addSubview(toView)
        
        initBubbleView()
        setupBeginningValues()
        
        UIView.animateKeyframes(withDuration: Animator.duration, delay: 0.0, animations: {
            self.callKeyframes()
        }, completion: { _ in
            transitionContext.completeTransition(true)
            self.bubbleClipView.removeFromSuperview()
        })
    }
    
    
    // MARK: Helper Methods
    private func setupViews(context: UIViewControllerContextTransitioning) {
        containerView = context.containerView
        toView = context.viewController(forKey: .to)!.view
    }
    
    private func initBubbleView() {
//        bubbleClipView = UIView(frame: CGRect(x: 0, y: 0, width: containerView.frame.width * 2, height: containerView.frame.height * 2))
        bubbleClipView = UIView(frame: containerView.frame.offsetBy(dx: 0, dy: 0))
        bubbleClipView.clipsToBounds = true
        let bubbleView = BubbleView(frame: bubbleClipView.frame)
        bubbleClipView.addSubview(bubbleView)
        containerView.addSubview(bubbleClipView)
    }
    
    private func setupBeginningValues() {
        toView.alpha = 0
        bubbleClipView.alpha = 0
    }
    
    private func callKeyframes() {
        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
            self.bubbleClipView.alpha = 1
        })
        UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
            self.setupEndingValues()
        })
    }
    
    private func setupEndingValues() {
        bubbleClipView.alpha = 0
        toView.alpha = 1
    }
}
