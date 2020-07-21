/*
 * Qulynym
 * DrawingView.swift
 *
 * Created by: Metah on 5/30/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol DrawingViewProtocol: class {
    var isOpen: Bool { get set }
    var closeBtn: UIButton { get set }
    var drawingImageView: UIImageView { get set }
    var canvasView: CanvasView { get set }
    var toolsCollectionView: UICollectionView { get set }
    var resetBtn: UIButton { get }
    var slideOutBtn: UIButton { get }
    var marker: UIButton { get }
    var pencil: UIButton { get }
    var brush: UIButton { get }
    var eraser: UIButton { get }
    
    func setupLayout()
    func toggleDrawingsCV()
}

class DrawingView: DrawingViewProtocol {
    // MARK:- Properties
    var isOpen = false
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    lazy var canvasView: CanvasView = {
        let v = CanvasView()
        v.isUserInteractionEnabled = true
        v.isMultipleTouchEnabled = false
        v.clipsToBounds = true
        return v
    }()
    lazy var drawingImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.zPosition = 1
        iv.contentMode = .scaleAspectFit 
        return iv
    }()
    lazy var toolsCollectionView: UICollectionView = {
        return configureImagesCollectionView(scroll: .horizontal,/* image: nil,*/ background: .clear)
    }()
    lazy var resetBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "reset"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    lazy var slideOutBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "slideOutOpen"), for: .normal)
        btn.layer.zPosition = 2
        return btn
    }()
    lazy var marker: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "marker"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    lazy var pencil: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "pencil"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    lazy var brush: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "brush"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    lazy var eraser: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "eraser"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    private lazy var woodenBgImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "woodBg")
        return iv
    }()
    
    private var drawingsCollectionView: DrawingsCollectionView!
    private weak var drawingViewController: DrawingViewController!
    private weak var view: UIView!
    
    private var drawingCVTrailingConstraint: NSLayoutConstraint!
    private var slideOutBtnConstraint: NSLayoutConstraint? {
        didSet {
            oldValue?.isActive = false
            slideOutBtnConstraint?.isActive = true
        }
    }
    
    
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
        initCloseConstraints()
        canvasView.setupAppearence()
    }
    
    private func configureChild() {
        drawingsCollectionView = DrawingsCollectionView()
        drawingsCollectionView.drawingView = drawingViewController
        drawingsCollectionView.view.layer.zPosition = 2
        drawingViewController.addChild(drawingsCollectionView)
    }
    
    private func addSubviews() {
        view.addSubview(woodenBgImage)
        view.addSubview(drawingsCollectionView.view)
        view.addSubview(closeBtn)
        view.addSubview(drawingImageView)
        view.addSubview(canvasView)
        view.addSubview(toolsCollectionView)
        view.addSubview(resetBtn)
        view.addSubview(slideOutBtn)
        view.addSubview(marker)
        view.addSubview(pencil)
        view.addSubview(brush)
        view.addSubview(eraser)
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
            canvasView.isUserInteractionEnabled = true
        } else {
            initOpenConstraints()
            canvasView.isUserInteractionEnabled = false
        }
        isOpen = !isOpen
    }
    
    private func initCloseConstraints() {
        slideOutBtn.setImage(UIImage(named: "slideOutOpen"), for: .normal)
        slideOutBtnConstraint = slideOutBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        drawingCVTrailingConstraint.constant = 0
        closeBtn.isEnabled = true
    }
    
    private func initOpenConstraints() {
        slideOutBtn.setImage(UIImage(named: "slideOutClose"), for: .normal)
        slideOutBtnConstraint = slideOutBtn.leadingAnchor.constraint(equalTo: drawingsCollectionView.view.trailingAnchor, constant: -4)
        drawingCVTrailingConstraint.constant = view.frame.height * 0.4
        closeBtn.isEnabled = false
    }
    
    #warning("Unable to simultaneously satisfy constraints.")
    private func activateConstraints() {
        drawingCVTrailingConstraint = drawingsCollectionView.view.trailingAnchor.constraint(equalTo: view.leadingAnchor)
        NSLayoutConstraint.activate([
            drawingsCollectionView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.frame.height * 0.15)),
            drawingsCollectionView.view.topAnchor.constraint(equalTo: view.topAnchor),
            drawingsCollectionView.view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            drawingCVTrailingConstraint,
            
            toolsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            toolsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolsCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            toolsCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            
            woodenBgImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            woodenBgImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            woodenBgImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            woodenBgImage.heightAnchor.constraint(equalTo: toolsCollectionView.heightAnchor),
            
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
            resetBtn.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            resetBtn.heightAnchor.constraint(equalTo: resetBtn.widthAnchor),
            
            marker.heightAnchor.constraint(equalToConstant: marker.intrinsicContentSize.height),
            marker.leadingAnchor.constraint(equalTo: toolsCollectionView.trailingAnchor, constant: 16),
            marker.topAnchor.constraint(equalTo: toolsCollectionView.topAnchor),
            marker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.075, constant: -20),
            
            pencil.topAnchor.constraint(equalTo: marker.topAnchor),
            pencil.leadingAnchor.constraint(equalTo: marker.trailingAnchor, constant: 16),
            pencil.heightAnchor.constraint(equalToConstant: pencil.intrinsicContentSize.height),
            pencil.widthAnchor.constraint(equalTo: marker.widthAnchor),
            
            brush.topAnchor.constraint(equalTo: pencil.topAnchor),
            brush.leadingAnchor.constraint(equalTo: pencil.trailingAnchor, constant: 16),
            brush.heightAnchor.constraint(equalToConstant: brush.intrinsicContentSize.height),
            brush.widthAnchor.constraint(equalTo: pencil.widthAnchor),
            
            eraser.leadingAnchor.constraint(equalTo: brush.trailingAnchor, constant: 16),
            eraser.widthAnchor.constraint(equalTo: brush.widthAnchor),
            eraser.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            eraser.topAnchor.constraint(equalTo: brush.topAnchor),
            
            slideOutBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            slideOutBtn.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12),
            slideOutBtn.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12)
        ])
    }
}
