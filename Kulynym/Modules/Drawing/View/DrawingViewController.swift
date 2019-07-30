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

protocol DrawingViewProtocol: class {
    var currentImageName: String? { get set }
}

class DrawingViewController: UIViewController, DrawingViewProtocol {
    // MARK:- Properties
    var presenter: DrawingPresenterProtocol!
    
    var currentImageName: String? {
        didSet {
            updateImage()
        }
    }
    lazy var tools: [UIColor] = [.red, .orange, .yellow, .green, whiteBlue, .blue, .purple, .brown, .black, .white]
    private let whiteBlue = UIColor(red: 102/255, green: 1, blue: 1, alpha: 1)

    private weak var closeBtn: UIButton!
    private weak var toolsCV: UICollectionView!
    private weak var pictureImageView: UIImageView!
    private weak var canvasView: CanvasViewProtocol!
    private weak var resetBtn: UIButton!
    private weak var slideOutBtn: UIButton!
    
    private var autoLayout: DrawingAutoLayoutProtocol!
    private let configurator: DrawingConfiguratorProtocol = DrawingConfigurator()
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        initLayout()
        autoLayout.setupLayout()
        assignViews()
        setupCV()
        assignActions()
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        autoLayout = DrawingAutoLayout(self)
    }
    
    private func assignViews() {
        self.closeBtn = autoLayout.closeBtn
        self.toolsCV = autoLayout.toolsCollectionView
        self.pictureImageView = autoLayout.drawingImageView
        self.canvasView = autoLayout.canvasView
        self.resetBtn = autoLayout.resetBtn
        self.slideOutBtn = autoLayout.slideOutBtn
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
    
    
    // MARK:- Actions
    private func assignActions() {
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
        resetBtn.addTarget(self, action: #selector(reset), for: .touchUpInside)
        slideOutBtn.addTarget(self, action: #selector(slideOut), for: .touchUpInside)
    }
    
    @objc private func closeBtnPressed() {
        presenter.closeView()
    }
    
    @objc private func slideOut() {
        autoLayout.toggleDrawingsCV()
    }
    
    @objc private func reset() {
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
        canvasView.color = tools[indexPath.row]
        if indexPath.row == 9 {
            canvasView.brushWidth = 10
        } else {
            canvasView.brushWidth = 5
        }
    }
}


// MARK:- DrawingsCollectionView
class DrawingsCollectionView: UIViewController {
    // MARK:- Properties
    var pictures = ["whiteCanvas", "flowerDrawing", "penguinDrawing", "catterpilarDrawing", "butterflyDrawing"]
    weak var drawingView: DrawingViewProtocol!
    private lazy var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        var cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        
        cv.setCollectionViewLayout(layout, animated: true)
        cv.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "reuseID")
        return cv
    }()
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        view.addSubview(mainCollectionView)
        setupCollectionView()
        setupAppearence()
        activateConstraints()
    }
    
    private func setupCollectionView() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupAppearence() {
        view.layer.zPosition = 1
        view.backgroundColor = .white
        
        view.layer.shadowRadius = 5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension DrawingsCollectionView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    // MARK:- UICollectionView Protocols
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseID", for: indexPath) as! ImageCollectionViewCell
        if indexPath.row == 0 {
            cell.imageName = "noDrawing"
        } else {
            cell.imageName = pictures[indexPath.row]
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            drawingView.currentImageName = nil 
        }
        drawingView.currentImageName = pictures[indexPath.row]
    }
}