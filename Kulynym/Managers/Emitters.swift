/*
* Kulynym
* Emitters.swift
*
* Created by: Metah on 6/5/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

// MARK: Bubble Animation
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

// MARK:- Musical Notes Animation
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
