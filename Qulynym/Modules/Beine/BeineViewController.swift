/*
* Qulynym
* BeineViewController.swift
*
* Created by: Metah on 10/20/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit
import youtube_ios_player_helper
import Alamofire
import SkeletonView

protocol BeineViewControllerProtocol: class {
    var beineler: [Beine]! { get set }
    var images: [Data]! { get set }
    var token: String? { get set }
    var playlistID: String? { get set }
    var index: Int! { get set }
}

class BeineViewController: QulynymVC, BeineViewControllerProtocol, DataFetchAPIDelegate, ConnectionWarningCaller, ConnectionWarningViewControllerDelegate {
    // MARK:- Properties
    var dataFetchAPI: DataFetchAPI!
    var beineler: [Beine]!
    var images: [Data]!
    var token: String?
    var index: Int!
    
    var playlistID: String?
    var isPassingSafe = false
    var isConnectionErrorShowing = false
    
    private let playVarsDic = ["controls": 1, "playsinline": 1, "showinfo": 1, "autoplay": 0, "rel": 0]
    private lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    private lazy var videoView: YTPlayerView = {
        let view = YTPlayerView()
        view.delegate = self
        view.clipsToBounds = false
        view.isSkeletonable = true
        return view
    }()
    private lazy var recommendationsCV: UICollectionView = {
        return configureImagesCollectionView(scroll: .horizontal,/* image: nil,*/ background: nil)
    }()
    private lazy var nextVideoBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "darkForward"), for: .normal)
        return btn
    }()
    private lazy var previousVideoBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "darkBack"), for: .normal)
        return btn
    }()
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 15
        lbl.setupMenuLabel(size: view.frame.height * 0.06)
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(videoView)
        view.addSubview(closeBtn)
        view.addSubview(recommendationsCV)
        view.addSubview(nextVideoBtn)
        view.addSubview(previousVideoBtn)
        setupCV()
        setAutoresizingFalse()
        activateConstraints()
        closeBtn.configureCloseBtnFrame(view)
        setupLayoutByTraitCollection()
        closeBtn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        nextVideoBtn.addTarget(self, action: #selector(nextVideo), for: .touchUpInside)
        previousVideoBtn.addTarget(self, action: #selector(previousVideo), for: .touchUpInside)
        
        dataFetchAPI = DataFetchAPI(fetchAPIDelegate: self, connectionDelegate: self)
        dataFetchAPI.beineler = self.beineler
        dataFetchAPI.token = self.token
        
        view.backgroundColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if index == 0 {
            previousVideoBtn.isEnabled = false
        }
        if index == dataFetchAPI.beineler.count - 1 {
            nextVideoBtn.isEnabled = false
        }
        updateTitle()
    }
    
    private func updateTitle() {
        titleLabel.text = beineler[index].title
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoView.load(withVideoId: dataFetchAPI.beineler[index].id, playerVars: playVarsDic)
        videoViewLoading()
        AudioPlayer.backgroundAudioPlayer.pause()
        let indexPath = IndexPath(item: index, section: 0)
        recommendationsCV.scrollToItem(at: indexPath, at: .left, animated: true)
        
        checkForConnection()
    }
    
    private func checkForConnection() {
        if !Connectivity.isConnectedToInternet {
            showAnErrorMessage()
        }
    }
    
    
    // MARK:- Layout
    private func videoViewLoading() {
        videoView.showAnimatedSkeleton(usingColor: .darkClouds, animation: nil, transition: .none)
    }
    
    func makeCellSelected(_ cell: UICollectionViewCell) {
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 5
    }
    
    func makeCellDeselected(_ cell: UICollectionViewCell) {
        cell.layer.borderColor = nil
        cell.layer.borderWidth = 0
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
    
    private func setupLayoutByTraitCollection() {
        var constraints = [NSLayoutConstraint]()
        if traitCollection.verticalSizeClass == .compact {
            constraints = [
                videoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
                videoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            ]
        } else {
            view.addSubview(titleLabel)
            constraints = [
                videoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
                videoView.topAnchor.constraint(equalTo: closeBtn.bottomAnchor, constant: 4),
                
                titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
                titleLabel.leadingAnchor.constraint(equalTo: closeBtn.trailingAnchor),
                titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                titleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18)
            ]
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            videoView.widthAnchor.constraint(equalTo: videoView.heightAnchor, multiplier: 2),
            videoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nextVideoBtn.leadingAnchor.constraint(equalTo: videoView.trailingAnchor, constant: 16),
            nextVideoBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.05),
            nextVideoBtn.heightAnchor.constraint(equalTo: nextVideoBtn.widthAnchor),
            nextVideoBtn.centerYAnchor.constraint(equalTo: videoView.centerYAnchor),
            
            previousVideoBtn.trailingAnchor.constraint(equalTo: videoView.leadingAnchor, constant: -16),
            previousVideoBtn.widthAnchor.constraint(equalTo: nextVideoBtn.widthAnchor),
            previousVideoBtn.heightAnchor.constraint(equalTo: previousVideoBtn.widthAnchor),
            previousVideoBtn.centerYAnchor.constraint(equalTo: nextVideoBtn.centerYAnchor),
            
            recommendationsCV.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: 12),
            recommendationsCV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recommendationsCV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recommendationsCV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
    // MARK:- Actions
    @objc
    private func closeView() {
        self.navigationController!.popViewController(animated: true)
        videoView.stopVideo()
        if AudioPlayer.backgroundAudioStatePlaying == true {
            AudioPlayer.backgroundAudioPlayer.play()
        }
    }
    
    @objc
    private func nextVideo() {
        videoViewLoading()
        if let cell = recommendationsCV.cellForItem(at: IndexPath(item: self.index, section: 0)) {
            makeCellDeselected(cell)
        }
        index += 1
        if index == dataFetchAPI.beineler.count - 1{
            nextVideoBtn.isEnabled = false
        }
        previousVideoBtn.isEnabled = true
        videoView.load(withVideoId: dataFetchAPI.beineler[index].id, playerVars: playVarsDic)
        recommendationsCV.scrollToItem(at: IndexPath(item: index, section: 0), at: .left, animated: true)
        if let cell = recommendationsCV.cellForItem(at: IndexPath(item: index, section: 0)) {
            makeCellSelected(cell)
        }
        
        checkForConnection()
    }
    
    @objc
    private func previousVideo() {
        videoViewLoading()
        if let cell = recommendationsCV.cellForItem(at: IndexPath(item: self.index, section: 0)) {
            makeCellDeselected(cell)
        }
        index -= 1
        if index == 0 {
            previousVideoBtn.isEnabled = false
        }
        nextVideoBtn.isEnabled = true
        videoView.load(withVideoId: dataFetchAPI.beineler[index].id, playerVars: playVarsDic)
        recommendationsCV.scrollToItem(at: IndexPath(item: index, section: 0), at: .left, animated: true)
        if let cell = recommendationsCV.cellForItem(at: IndexPath(item: index, section: 0)) {
            makeCellSelected(cell)
        }
        
        checkForConnection()
    }
}

extension BeineViewController {
    // MARK:- DataFetchAPIDelegate Methods
    func dataIsReady() {
        recommendationsCV.reloadData()
        if index > 0 {
            previousVideoBtn.isEnabled = true
        }
        if index < dataFetchAPI.beineler.count - 1 {
            nextVideoBtn.isEnabled = true
        }
    }
    
    func showAnErrorMessage() {
        if !self.isConnectionErrorShowing {
            if AudioPlayer.backgroundAudioStatePlaying == true {
                AudioPlayer.backgroundAudioPlayer.play()
            }
            let vc = ConnectionWarningViewController()
            vc.delegateVC = self
            self.show(vc, sender: nil)
            self.isConnectionErrorShowing = true
        }
    }
    
    // MARK:- ConnectionWarningViewControllerDelegate Methods
    func fetchData() {
        self.dataFetchAPI.fetchBeine()
    }
}


extension BeineViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataFetchAPI.beineler.count == 0 ? 5 : dataFetchAPI.beineler.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseID", for: indexPath) as! ImageCollectionViewCell
        
        cell.backgroundColor = UIColor(red: 149/255, green: 165/255, blue: 166/255, alpha: 1)
        cell.imageView.isSkeletonable = true
        cell.sectionTitleLabel.backgroundColor = .black
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
        cell.isUserInteractionEnabled = false
        
        let gradient = SkeletonGradient(baseColor: .concrete)
        cell.imageView.showAnimatedGradientSkeleton(usingGradient: gradient)
        
        cell.warningCaller = self

        if self.dataFetchAPI.beineler.count != 0 {
            cell.isUserInteractionEnabled = true
            cell.beine = self.dataFetchAPI.beineler[indexPath.row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = recommendationsCV.frame.height - 8
        return CGSize(width: height * 1.8, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != index {
            videoViewLoading()
            if let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) {
                makeCellDeselected(cell)
            }
            videoView.load(withVideoId: dataFetchAPI.beineler[indexPath.row].id, playerVars: playVarsDic)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            makeCellSelected(collectionView.cellForItem(at: indexPath)!)
            index = indexPath.row
            updateTitle()
        }
        
        checkForConnection()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == index {
            makeCellSelected(cell)
        } else {
            makeCellDeselected(cell)
        }
        
        guard dataFetchAPI.token != nil else { return }
        if (indexPath.row == dataFetchAPI.beineler.count - 1 ) {
            self.dataFetchAPI.fetchBeine()
        }
    }
}


extension BeineViewController: YTPlayerViewDelegate {
    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor {
        return .clear
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.hideSkeleton(transition: .crossDissolve(0.5))
    }
}
