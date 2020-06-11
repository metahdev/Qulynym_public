/*
 * Qulynym
 * PlaylistViewController.swift
 *
 * Created by: Metah on 5/12/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol PlaylistViewControllerProtocol: class {
    var isKaraoke: Bool! { get set }
    var content: [String] { get set }
}

class PlaylistViewController: UIViewController, PlaylistViewControllerProtocol {
    // MARK:- Properties
    var isKaraoke: Bool!
    var content = [String]()
    var presenter: PlaylistPresenterProtocol!
    weak var karaokeViewDelegate: PlaylistItemViewControllerProtocol!
    
    private weak var listCollectionView: UICollectionView!
    private weak var closeBtn: UIButton!
    private weak var titleLabel: UILabel!
    
    private var playlistView: PlaylistViewProtocol!
    private let configurator: PlaylistConfiguratorProtocol = PlaylistConfigurator()
    
    
    // MARK:- Status Bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        initLayout()
        playlistView.setupLayout()
        assignViews()
        setupCollectionView()
        setText()
        assignActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getContent()
        initMessage()
//        manager.showAlert()
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        playlistView = PlaylistView(view: self.view)
    }
    
    private func assignViews() {
        self.listCollectionView = playlistView.listCollectionView
        self.closeBtn = playlistView.closeBtn
        self.titleLabel = playlistView.titleLabel
    }
    
    
    // MARK:- ListTableView
    private func setupCollectionView() {
        self.listCollectionView.delegate = self
        self.listCollectionView.dataSource = self
    }
    
    private func setText() {
        titleLabel.text = isKaraoke ? "O'lender" : "Ertegiler"
    }
    
    func initMessage() {
//        manager = ScenesManager(calling: self, showing: isKaraoke ? "karaoke" : "stories")
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
    }
    
    @objc private func closeBtnPressed() {
        presenter.closeView()
    }
}

extension PlaylistViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseID", for: indexPath) as! ImageCollectionViewCell
        cell.imageName = content[indexPath.row]
        cell.text = content[indexPath.row]
        cell.textSize = cell.frame.height * 0.1
        cell.imageViewCornerRadius = 15
//        cell.titleLabelConstantFromTop = 4
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.openItem(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.3, height: view.frame.width * 0.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let distance = (view.frame.width - view.frame.width * 0.6) / 3
        return UIEdgeInsets(top: 40, left: distance, bottom: distance, right: distance)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let distance = (view.frame.width - view.frame.width * 0.6) / 3
        return distance
    }
}
