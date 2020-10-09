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
    var itemConstant: CGFloat? { get set }
}

class PlaylistViewController: QulynymVC, PlaylistViewControllerProtocol {
    // MARK:- Properties
    var isKaraoke: Bool!
    var content = [String]()
    var itemConstant: CGFloat?
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
        playlistView.imageName = isKaraoke ? "karaokeBg" : "storyBg"
        if !isKaraoke {
            playlistView.titleLabel.textColor = .lightViolet
        }
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
    
    private func setupItemConstant() {
        if traitCollection.verticalSizeClass == .compact {
            itemConstant = view.frame.width * 0.28
        } else {
            itemConstant = view.frame.width * 0.2
        }
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
        cell.image = UIImage(named: content[indexPath.row])
        cell.text = content[indexPath.row]
        cell.sectionTitleLabel.setupPlaylistLabel(size: cell.frame.height * 0.1)
        if !isKaraoke {
            cell.sectionTitleLabel.textColor = .lightViolet
            cell.sectionTitleLabel.backgroundColor = UIColor(red: 31/255, green: 28/255, blue: 50/255, alpha: 1)
        }
        cell.imageView.layer.cornerRadius = 5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.openItem(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        setupItemConstant()
        return CGSize(width: itemConstant!, height: itemConstant!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: view.frame.width * 0.1, bottom: 40, right: view.frame.width * 0.1)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let distance = (view.frame.width - view.frame.width * 0.6) / 3
        return distance
    }
}
