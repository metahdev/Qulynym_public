//
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
    let duration = 1.0
    var fromView: UIView!
    var toView: UIView!
    var containerView: UIView!
    var bubbleClipView: UIView!
    
    
    // MARK:- Protocol Methods
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
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

class BubbleView: UIView {
    // MARK:- Properties
    var emitter: CAEmitterLayer!
    var emitterCell: CAEmitterCell!
    
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    
    
    // MARK:- Initialization
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initEmitter()
        initEmitterCell()
        
        emitter.emitterCells = [emitterCell]
    }
    
    
    // MARK:- Emitter
    private func initEmitter() {
        emitter = (layer as! CAEmitterLayer)
        emitter.emitterPosition = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        emitter.emitterSize = bounds.size
        emitter.emitterShape = CAEmitterLayerEmitterShape.rectangle
    }
    
    func initEmitterCell() {
        emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: "bubble")!.cgImage
        emitterCell.birthRate = 100
        emitterCell.lifetime = 2
        emitterCell.color = UIColor.white.cgColor
        emitterCell.blueRange = 0.1
        emitterCell.velocity = 10
        emitterCell.velocityRange = 350
        emitterCell.emissionRange = CGFloat.pi / 2
        emitterCell.emissionLongitude = -CGFloat.pi
        emitterCell.yAcceleration = -70
        emitterCell.scale = 0.33
        emitterCell.scaleRange = 1.25
        emitterCell.scaleSpeed = -0.25
        emitterCell.alphaRange = 0.5
        emitterCell.alphaSpeed = -0.15
    }
}

class NoteView: BubbleView {
    override func initEmitterCell() {
        super.initEmitterCell()
        emitterCell.contents = UIImage(named: "note")!.cgImage
        emitterCell.birthRate = 3
        emitterCell.lifetime = 1.5
        emitterCell.yAcceleration = -70
        emitterCell.velocity = 30
        emitterCell.velocityRange = 350
        emitterCell.scale = 1.0
        emitterCell.scaleRange = 0.0
        emitterCell.scaleSpeed = 0.0
    }
}
