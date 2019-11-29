/*
* Qulynym
* BeinelerViewController.swift
*
* Created by: Metah on 10/20/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

class Beine {
    var title: String
    var image: Data
    var url: URL
    
    init(title: String, image: Data, url: URL) {
        self.title = title
        self.image = image
        self.url = url
    }
}

class BeinelerViewController: UIViewController {
    // MARK:- Properties
    weak var videoViewController: VideoViewControllerProtocol!
    
    private lazy var videosCollectionView: UICollectionView = {
        return configureImagesCollectionView(scroll: .horizontal, image: "menu", background: nil)
    }()
    private lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Beineler"
        lbl.backgroundColor = .white
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 15
        lbl.setupContentLabel(size: view.frame.height * 0.1)
        return lbl
    }()
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(videosCollectionView)
        view.addSubview(closeBtn)
        view.addSubview(titleLabel)
        setupCV()
        setAutoresizingFalse()
        activateConstraints()
        closeBtn.configureCloseBtnFrame(view)
        closeBtn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
    }
    
    
    // MARK:- UICollectionView
    func setupCV() {
        videosCollectionView.delegate = self
        videosCollectionView.dataSource = self
    }
    
    
    // MARK:- Layout
    func setAutoresizingFalse() {
        for subview in view.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            
            videosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videosCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            videosCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    // MARK:- Actions
    @objc
    func closeView() {
        self.navigationController!.popViewController(animated: true)
    }
}

extension BeinelerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = VideoViewController()
        videoViewController = vc
        
        videoViewController.videoURL = URL(string: "https://www.youtube.com/embed/v=HluANRwPyNo")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.5, height: view.frame.height * 0.5)
    }
}
