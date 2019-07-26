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
    var tools: [UIColor]! { get set }
}

class DrawingViewController: UIViewController, DrawingViewProtocol {
    // MARK:- Properties
    var presenter: DrawingPresenterProtocol!
    var tools: [UIColor]!
    
    private weak var closeBtn: UIButton!
    private weak var toolsCV: UICollectionView!
    private weak var pictureImageView: UIImageView!
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
        autoLayout = DrawingAutoLayout(self.view)
    }
    
    private func assignViews() {
        self.closeBtn = autoLayout.closeBtn
        self.toolsCV = autoLayout.toolsCollectionView
        self.pictureImageView = autoLayout.drawingImageView
        self.resetBtn = autoLayout.resetBtn
        self.slideOutBtn = autoLayout.slideOutBtn
    }
    
    private func setupCV() {
        toolsCV.delegate = self
        toolsCV.dataSource = self
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
        
    }
    
    @objc private func reset() {
        
    }
}


extension DrawingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tools.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseID", for: indexPath) as! ImageCollectionViewCell
        if indexPath.row == 7 {
            cell.imageName = "eraser"
        } else {
            cell.backgroundColor = tools[indexPath.row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.5, height: view.frame.height * 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }

}
