/*
* Kulynym
* MenuViewController.swift
*
* Created by: Metah on 6/10/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol MenuViewProtocol: class {
    var isToddler: Bool { get set }
    var sections: [Section] { get set }
}

class MenuViewController: UIViewController, MenuViewProtocol {
    // MARK:- Properties
    var presenter: MenuPresenterProtocol!
    
    weak var playlistViewDelegate: PlaylistViewProtocol!
    weak var toddlerViewDelegate: MenuViewProtocol!
    weak var scenesViewDelegate: ScenesViewControllerProtocol!
    
    var isToddler = false
    var sections = [Section]()
    
    private weak var collectionView: UICollectionView!
    private weak var closeBtn: UIButton!
    
    private let configurator: MenuConfiguratorProtocol = MenuConfigurator()
    private var autoLayout: MenuAutoLayoutProtocol!
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        initLayout()
        autoLayout.setupLayout()
        setupProperties()
        assignActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getSections()
        hideOrUnhideCloseBtn()
    }

    
    // MARK:- Layout
    private func initLayout() {
        autoLayout = MenuAutoLayout(self.view)
    }
    
    private func setupProperties() {
        self.collectionView = autoLayout.collectionView
        self.closeBtn = autoLayout.closeBtn
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func hideOrUnhideCloseBtn() {
        closeBtn.isHidden = !isToddler
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
    }
    
    @objc func closeBtnPressed() {
        presenter.closeView() 
    }
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK:- UICollectionView Protocols
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseID", for: indexPath) as! ImageCollectionViewCell
        cell.imageName = sections[indexPath.row].name
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 5
        cell.layer.cornerRadius = 15
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.isToddler ? presenter.didSelectToddlerCell(at: indexPath.row) : presenter.didSelectMenuCell(at: indexPath.row)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.5, height: view.frame.height * 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 84
    }
}


extension MenuViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator()
    }
}
