//
/*
* Kulynym
* DrawingAutoLayout.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol DrawingAutoLayoutProtocol: class {
    var closeBtn: UIButton { get set }
    var drawingImageView: UIImageView { get set }
    var canvasView: CanvasView { get set }
    var toolsCollectionView: UICollectionView { get set }
    var resetBtn: UIButton { get set }
    var slideOutBtn: UIButton { get set }
    
    func setupLayout()
    func toggleDrawingsCV()
}

class DrawingAutoLayout: DrawingAutoLayoutProtocol {
    // MARK:- Properties
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        return btn
    }()
    lazy var canvasView: CanvasView = {
        let v = CanvasView()
        v.isUserInteractionEnabled = true
        v.isMultipleTouchEnabled = true
        return v
    }()
    lazy var drawingImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.zPosition = -1
        return iv
    }()
    lazy var toolsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundView = UIImageView(image: UIImage(named: "woodBg"))
        
        cv.setCollectionViewLayout(layout, animated: true)
        cv.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "reuseID")
        return cv
    }()
    lazy var resetBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "reset"), for: .normal)
        return btn
    }()
    lazy var slideOutBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "slideOutOpen"), for: .normal)
        return btn
    }()
    private var drawingsCollectionView: DrawingsCollectionView!
    private weak var drawingViewController: DrawingViewController!
    private weak var view: UIView!
    
    private var drawingCVTrailingConstraint: NSLayoutConstraint!
    private var isOpen = false
    
    
    // MARK:- Initialization 
    required init(_ vc: DrawingViewController) {
        self.drawingViewController = vc
        self.view = vc.view
        self.view.backgroundColor = .white
    }
    
    
    // MARK:- Layout
    func setupLayout() {
        configureChild()
        addSubviews()
        drawingsCollectionView.didMove(toParent: drawingViewController)
        setSubviewsMask()
        closeBtn.configureCloseBtnFrame(view)
        activateConstraints()
        canvasView.setupAppearence()
    }
    
    private func configureChild() {
        drawingsCollectionView = DrawingsCollectionView()
        drawingsCollectionView.drawingView = drawingViewController
        drawingViewController.addChild(drawingsCollectionView)
    }
    
    private func addSubviews() {
        view.addSubview(drawingsCollectionView.view)
        view.addSubview(closeBtn)
        view.addSubview(drawingImageView)
        view.addSubview(canvasView)
        view.addSubview(toolsCollectionView)
        view.addSubview(resetBtn)
        view.addSubview(slideOutBtn)
    }
    
    private func setSubviewsMask() {
        for subview in view.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
    // MARK:- Constraints
    func toggleDrawingsCV() {
        if isOpen {
            initCloseConstraints()
        } else {
            initOpenConstraints()
        }
        isOpen = !isOpen
    }
    
    private func initCloseConstraints() {
        slideOutBtn.setImage(UIImage(named: "slideOutOpen"), for: .normal)
        drawingCVTrailingConstraint.constant = 0
        closeBtn.isEnabled = true
    }
    
    private func initOpenConstraints() {
        slideOutBtn.setImage(UIImage(named: "slideOutClose"), for: .normal)
        drawingCVTrailingConstraint.constant = view.frame.height * 0.4
        closeBtn.isEnabled = false
    }
    
    private func activateConstraints() {
        drawingCVTrailingConstraint = drawingsCollectionView.view.trailingAnchor.constraint(equalTo: view.leadingAnchor)
        NSLayoutConstraint.activate([
            drawingsCollectionView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.frame.height * 0.15)),
            drawingsCollectionView.view.topAnchor.constraint(equalTo: view.topAnchor),
            drawingsCollectionView.view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            drawingCVTrailingConstraint,
            
            toolsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            toolsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolsCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            
            drawingImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            drawingImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            drawingImageView.bottomAnchor.constraint(equalTo: toolsCollectionView.topAnchor, constant: -16),
            drawingImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            
            canvasView.leadingAnchor.constraint(equalTo: drawingImageView.leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: drawingImageView.trailingAnchor),
            canvasView.topAnchor.constraint(equalTo: drawingImageView.topAnchor),
            canvasView.bottomAnchor.constraint(equalTo: drawingImageView.bottomAnchor),
            
            resetBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            resetBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            resetBtn.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12),
            resetBtn.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12),
            
            slideOutBtn.leadingAnchor.constraint(equalTo: drawingsCollectionView.view.trailingAnchor, constant: -4),
            slideOutBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            slideOutBtn.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12),
            slideOutBtn.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12),
        ])
    }
}
