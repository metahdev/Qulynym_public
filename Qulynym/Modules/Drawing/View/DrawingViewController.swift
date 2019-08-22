/*
* Kulynym
* DrawingViewController.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol DrawingViewControllerProtocol: class {
    var currentImageName: String? { get set }
    var selectedTool: UIButton! { get set }
    
    func clearCanvas() 
}

class DrawingViewController: UIViewController, DrawingViewControllerProtocol {
    // MARK:- Properties
    var presenter: DrawingPresenterProtocol!
    
    var currentImageName: String? {
        didSet {
            updateImage()
        }
    }
    
    var manager: ScenesManager!
    
    lazy var tools: [UIColor] = [.red, .orange, .yellow, .green, whiteBlue, .blue, .purple, .brown, .black]
    private let whiteBlue = UIColor(red: 102/255, green: 1, blue: 1, alpha: 1)

    private weak var closeBtn: UIButton!
    private weak var toolsCV: UICollectionView!
    private weak var pictureImageView: UIImageView!
    private weak var canvasView: CanvasViewProtocol!
    private weak var resetBtn: UIButton!
    private weak var slideOutBtn: UIButton!
    private weak var marker: UIButton!
    private weak var pencil: UIButton!
    private weak var brush: UIButton!
    private weak var eraser: UIButton!
    
    private var drawingView: DrawingViewProtocol!
    private let configurator: DrawingConfiguratorProtocol = DrawingConfigurator()
    
    private var previousTool: UIButton?
    var selectedTool: UIButton! {
        didSet {
            previousTool = oldValue
            toolDidSet()
        }
    }
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        initLayout()
        drawingView.setupLayout()
        assignViews()
        setupCV()
        initMessage()
//        manager.showAlert()
        assignActions()
        selectedTool = pencil
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        drawingView = DrawingView(self)
    }
    
    private func assignViews() {
        self.closeBtn = drawingView.closeBtn
        self.toolsCV = drawingView.toolsCollectionView
        self.pictureImageView = drawingView.drawingImageView
        self.canvasView = drawingView.canvasView
        self.resetBtn = drawingView.resetBtn
        self.slideOutBtn = drawingView.slideOutBtn
        self.marker = drawingView.marker
        self.pencil = drawingView.pencil
        self.brush = drawingView.brush
        self.eraser = drawingView.eraser
    }
    
    private func setupCV() {
        toolsCV.delegate = self
        toolsCV.dataSource = self
    }
    
    private func updateImage() {
        guard let name = currentImageName else {
            pictureImageView.image = nil
            return
        }
        pictureImageView.image = UIImage(named: name)
    }
    
    func moveUp(tool: UIButton) {
        UIView.animate(withDuration: 0.4) {
            tool.transform = CGAffineTransform(translationX: 0, y: -20)
        }
    }
    
    func moveDown(tool: UIButton) {
        UIView.animate(withDuration: 0.4) {
            tool.transform = CGAffineTransform(translationX: 0, y: 20)
        }
    }
    
    func setupDrawingLineComponents(of tool: UIButton) {
        if canvasView.color == .white {
            canvasView.color = .red
        }
        if tool == brush {
            canvasView.brushWidth = 20
            canvasView.color = canvasView.color.withAlphaComponent(1)
        } else if tool == pencil {
            canvasView.brushWidth = 5
            canvasView.color = canvasView.color.withAlphaComponent(0.7)
        } else if tool == marker {
            canvasView.brushWidth = 12
            canvasView.color = canvasView.color.withAlphaComponent(0.5)
        } else {
            canvasView.brushWidth = 25
            canvasView.color = .white
        }
    }
    
    
    func initMessage() {
//        manager = ScenesManager(calling: self, showing: "drawing")
    }
    
    // MARK:- Actions
    private func assignActions() {
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
        resetBtn.addTarget(self, action: #selector(reset), for: .touchUpInside)
        slideOutBtn.addTarget(self, action: #selector(slideOut), for: .touchUpInside)
        marker.addTarget(self, action: #selector(markerBtnPressed), for: .touchUpInside)
        pencil.addTarget(self, action: #selector(pencilBtnPressed), for: .touchUpInside)
        brush.addTarget(self, action: #selector(brushBtnPressed), for: .touchUpInside)
        eraser.addTarget(self, action: #selector(eraserBtnPressed), for: .touchUpInside)
    }
    
    func toolDidSet() {
        if selectedTool == marker {
            moveUp(tool: marker)
            setupDrawingLineComponents(of: marker)
        } else if selectedTool == pencil {
            moveUp(tool: pencil)
            setupDrawingLineComponents(of: pencil)
        } else if selectedTool == brush {
            moveUp(tool: brush)
            setupDrawingLineComponents(of: brush)
        } else {
            moveUp(tool: eraser)
            setupDrawingLineComponents(of: eraser)
        }
        if previousTool != nil && previousTool != selectedTool {
            moveDown(tool: previousTool!)
        }
    }
    
    @objc
    private func closeBtnPressed() {
        presenter.closeView()
    }
    
    @objc
    private func slideOut() {
        drawingView.toggleDrawingsCV()
    }
    
    @objc
    private func reset() {
        canvasView.clear()
    }
    
    @objc func brushBtnPressed() {
        selectedTool = brush
    }
    
    @objc func pencilBtnPressed() {
        selectedTool = pencil
    }
    
    @objc func markerBtnPressed() {
        selectedTool = marker
    }
    
    @objc func eraserBtnPressed() {
        selectedTool = eraser
    }
    
    
    // MARK:- Other
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
}


extension DrawingViewController {
    func clearCanvas() {
        canvasView.clear()
    }
}


extension DrawingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK:- UICollectionView Protocols
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tools.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseID", for: indexPath) as! ImageCollectionViewCell
        cell.backgroundColor = tools[indexPath.row]
        cell.layer.cornerRadius = cell.frame.width * 0.5
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: toolsCV.frame.height - 20, height: toolsCV.frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        canvasView.color = tools[indexPath.row]
        toolDidSet()
        AudioPlayer.setupExtraAudio(with: "bloop", audioPlayer: .effects)
    }
}

