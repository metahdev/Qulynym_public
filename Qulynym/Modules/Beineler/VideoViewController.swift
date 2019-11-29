/*
* Qulynym
* VideoViewController.swift
*
* Created by: Metah on 10/20/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol VideoViewControllerProtocol: class {
    var videoURL: URL! { get set }
}

class VideoViewController: UIViewController,VideoViewControllerProtocol {
    // MARK:- Properties
    var videoURL: URL!
    private lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    #warning("WKWebView")
    private lazy var videoView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var recommendationsCV: UICollectionView = {
        return configureImagesCollectionView(scroll: .horizontal, image: nil, background: nil)
    }()
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(videoView)
        view.addSubview(closeBtn)
        view.addSubview(recommendationsCV)
        setupCV()
        setAutoresizingFalse()
        activateConstraints()
        closeBtn.configureCloseBtnFrame(view)
        closeBtn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
    }
    
    private func setupCV() {
        recommendationsCV.delegate = self
        recommendationsCV.dataSource = self
    }
    
    private func setAutoresizingFalse() {
        for subview in view.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false 
        }
    }
    
    private func activateConstraints() {
        
    }
    
    
    // MARK:- Actions
    @objc
    private func closeView() {
        self.navigationController!.popViewController(animated: true)
    }
}


extension VideoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseID", for: indexPath) as! ImageCollectionViewCell
        
        cell.backgroundColor = .gray
        
        cell.textSize = view.frame.height * 0.1
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 5
        cell.layer.cornerRadius = 15
        cell.imageViewCornerRadius = 15
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: view.frame.width * 0.5, height: view.frame.height * 0.5)
    }
}
