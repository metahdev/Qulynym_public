//
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
    
    lazy var tools: [UIColor] = [.red, .orange, .yellow, .green, whiteBlue, .blue, .purple, .brown, .black, .white]
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
    
    private var drawingView: DrawingViewProtocol!
    private let configurator: DrawingConfiguratorProtocol = DrawingConfigurator()
    
    var selectedTool: UIButton! {
        didSet {
            selectedToolDidSet()
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
    
    func moveLeft(tool: UIButton) {
        UIView.animate(withDuration: 0.4) {
            tool.transform = CGAffineTransform(translationX: -10, y: 0)
        }
    }
    
    func moveRight(tool: UIButton) {
        UIView.animate(withDuration: 0.4) {
            tool.transform = CGAffineTransform(translationX: 10, y: 0)
        }
    }
    
    func setupDrawingLineComponents(of tool: UIButton) {
        if tool == brush {
            canvasView.brushWidth = 20
            canvasView.color = canvasView.color.withAlphaComponent(1)
        } else if tool == pencil {
            canvasView.brushWidth = 5
            canvasView.color = canvasView.color.withAlphaComponent(0.8)
        } else {
            canvasView.brushWidth = 12
            canvasView.color = canvasView.color.withAlphaComponent(0.5)
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

    }
    
    func selectedToolDidSet() {
        if selectedTool == marker {
            moveLeft(tool: marker)
            moveRight(tool: brush)
            moveRight(tool: pencil)
            setupDrawingLineComponents(of: marker)
        } else if selectedTool == pencil {
            moveLeft(tool: pencil)
            moveRight(tool: brush)
            moveRight(tool: marker)
            setupDrawingLineComponents(of: pencil)
        } else {
            moveLeft(tool: brush)
            moveRight(tool: pencil)
            moveRight(tool: marker)
            setupDrawingLineComponents(of: brush)
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
    
    
    // MARK:- Other
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
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
        if indexPath.row == 9 {
            cell.imageName = "eraser"
        }
        cell.layer.cornerRadius = toolsCV.frame.height / 2
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: toolsCV.frame.height, height: toolsCV.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        canvasView.color = tools[indexPath.row]
        if indexPath.row == 9 {
            canvasView.brushWidth = 20
        } else {
            selectedToolDidSet()
            AudioPlayer.setupExtraAudio(with: "bloop", audioPlayer: .effects)
        }
    }
}

