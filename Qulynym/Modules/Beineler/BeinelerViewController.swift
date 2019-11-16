/*
* Qulynym
* BeinelerViewController.swift
*
* Created by: Metah on 10/20/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/


import UIKit

class BeinelerViewController: UIViewController {
    // MARK:- Properties
    private lazy var videosCollectionView: UICollectionView = {
        return configureImagesCollectionView(scroll: .horizontal, image: "menu", background: nil)
    }()
    private lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    var titles = [String]()
    var images = [UIImage]()
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(videosCollectionView)
        view.addSubview(closeBtn)
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
        
        let configuration = URLSessionConfiguration.default
//        let session = URLSession(configuration: configuration)
//        let url = URL(string: "https://youtube.com")!
        
//        let task = session.dataTask(with: url) { (data, response, error) in
//            guard let httpResponse = response as? HTTPURLResponse,
//                httpResponse.statusCode == 200 else { return }
//
//            guard let data = data else {
//                return
//            }
//
//            let jsonDecoder = JSONDecoder()
//            let media = JSONDecoder.decode()
//        }
//
//        cell.text = titles[indexPath.row]
//        cell.image = images[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.5, height: view.frame.height * 0.5)
    }
}
