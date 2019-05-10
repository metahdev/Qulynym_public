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
    
        setupBeginningValues()
        
        initBubbleView(view: containerView)
        
        UIView.animate(withDuration: duration, animations: {
            self.setupEndingValues()
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
    
    private func setupBeginningValues() {
        toView.alpha = 0
        
        fromView.backgroundColor = .black
        fromView.layer.opacity = 0.6
    }
    
    private func setupEndingValues() {
        toView.alpha = 1
        fromView.layer.opacity = 1
        bubbleClipView.alpha = 0
    }
    
    private func initBubbleView(view: UIView) {
        bubbleClipView = UIView(frame: view.frame.offsetBy(dx: 0, dy: 0))
        bubbleClipView.clipsToBounds = true
        let bubbleView = BubbleView(frame: CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: view.frame.height))
        
        bubbleClipView.addSubview(bubbleView)
        view.addSubview(bubbleClipView)
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
        emitter.emitterPosition = CGPoint(x: bounds.size.width / 2, y: 0)
        emitter.emitterSize = bounds.size
        emitter.emitterShape = CAEmitterLayerEmitterShape.rectangle
    }
    
    private func initEmitterCell() {
        emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: "bubble")!.cgImage
        emitterCell.birthRate = 200
        emitterCell.lifetime = 3.5
        emitterCell.color = UIColor.white.cgColor
        emitterCell.redRange = 0.0
        emitterCell.blueRange = 0.1
        emitterCell.greenRange = 0.0
        emitterCell.velocity = 10
        emitterCell.velocityRange = 350
        emitterCell.emissionRange = CGFloat.pi / 2
        emitterCell.emissionLongitude = -CGFloat.pi
        emitterCell.yAcceleration = 70
        emitterCell.xAcceleration = 0
        emitterCell.scale = 0.33
        emitterCell.scaleRange = 1.25
        emitterCell.scaleSpeed = -0.25
        emitterCell.alphaRange = 0.5
        emitterCell.alphaSpeed = -0.15
    }
}
