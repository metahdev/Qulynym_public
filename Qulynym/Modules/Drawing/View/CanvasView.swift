 /*
* Qulynym
* CanvasImageView.swift
*
* Created by: Metah on 7/28/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
 */

import UIKit

protocol CanvasViewProtocol: class {
    var color: UIColor { get set }
    var brushWidth: CGFloat { get set }
        
    func clear()
}

class CanvasView: UIView, CanvasViewProtocol {
    // MARK:- Properties
    var color = UIColor.red
    var brushWidth: CGFloat = 0
        
    private var lastPoint: CGPoint!
    private var pointCounter = 0
    private let pointLimit = 128
    private var preRenderImage: UIImage!
    
    private var bezierPath: UIBezierPath = {
        var bP = UIBezierPath()
        bP.lineCapStyle = CGLineCap.round
        bP.lineJoinStyle = CGLineJoin.round
        return bP
    }()
    
    
    // MARK:- View
    func setupAppearence() {
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor(red: 0.4, green: 0.2, blue: 0, alpha: 1).cgColor
        self.layer.borderWidth = 10
        self.layer.cornerRadius = 15
    }
    
    
    // MARK:- Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: AnyObject? = touches.first
        lastPoint = touch!.location(in: self)
        pointCounter = 0
        let location = touch!.location(in: self)
        let dot = UIView(frame: CGRect(x: location.x, y: location.y, width: 50, height:
                50))
        dot.backgroundColor = .clear
        dot.layer.cornerRadius = dot.bounds.midY
        dot.layer.borderColor = UIColor.gray.cgColor
        dot.layer.borderWidth = 5
        dot.layer.position.x = location.x
        dot.layer.position.y = location.y
            
        self.addSubview(dot)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: AnyObject? = touches.first
        let newPoint = touch!.location(in: self)
        let dot = self.subviews.last
        
        bezierPath.move(to: lastPoint)
        bezierPath.addLine(to: newPoint)
        lastPoint = newPoint
        
        let location = touch!.location(in: self)
        let insideX = location.x < self.bounds.maxX && location.x > self.bounds.minX
        let insideY = location.y < self.bounds.maxY && location.y > self.bounds.minY
        if insideX && insideY {
            dot?.layer.position.x = location.x
            dot?.layer.position.y = location.y
        }
        pointCounter += 1
        
        if pointCounter == pointLimit {
            pointCounter = 0
            renderToImage()
            setNeedsDisplay()
            bezierPath.removeAllPoints()
        } else {
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        pointCounter = 0
        renderToImage()
        setNeedsDisplay()
        bezierPath.removeAllPoints()
        self.subviews.last?.removeFromSuperview()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        touchesEnded(touches!, with: event)
    }
    
    
    // MARK:- Pre-Rendering
    func renderToImage() {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        if preRenderImage != nil {
            preRenderImage.draw(in: self.bounds)
        }
        
        bezierPath.lineWidth = brushWidth
        color.setFill()
        color.setStroke()
        bezierPath.stroke()
        
        preRenderImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
    
    
    // MARK:- Rendering
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if preRenderImage != nil {
            preRenderImage.draw(in: self.bounds)
        }
        
        bezierPath.lineWidth = brushWidth
        color.setFill()
        color.setStroke()
        bezierPath.stroke()
    }
    
    
    // MARK:- Clearing
    func clear() {
        preRenderImage = nil
        bezierPath.removeAllPoints()
        setNeedsDisplay()
    }
    
    
    // MARK:- Other
    func hasLines() -> Bool {
        return preRenderImage != nil || !bezierPath.isEmpty
    }
}
