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
    
    private var drawingView: DrawingViewProtocol!
    private let configurator: DrawingConfiguratorProtocol = DrawingConfigurator()
    
    
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
    
    
    func initMessage() {
//        manager = ScenesManager(calling: self, showing: "drawing")
    }
    
    // MARK:- Actions
    private func assignActions() {
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
        resetBtn.addTarget(self, action: #selector(reset), for: .touchUpInside)
        slideOutBtn.addTarget(self, action: #selector(slideOut), for: .touchUpInside)
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
        AudioPlayer.setupExtraAudio(with: "bulp", audioPlayer: .effects)
        canvasView.color = tools[indexPath.row]
        if indexPath.row == 9 {
            canvasView.brushWidth = 10
        } else {
            canvasView.brushWidth = 5
        }
    }
}

