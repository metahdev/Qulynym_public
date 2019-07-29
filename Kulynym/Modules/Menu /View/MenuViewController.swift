/*
* Kulynym
* MenuViewController.swift
*
* Created by: Metah on 6/10/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

enum Menu {
    case toddler
    case main
    case games
}

protocol MenuViewProtocol: class {
    var menuType: Menu { get set }
    var sections: [Section] { get set }
}

class MenuViewController: UIViewController, MenuViewProtocol {
    // MARK:- Properties
    var presenter: MenuPresenterProtocol!
    
    weak var playlistViewDelegate: PlaylistViewProtocol!
    weak var secondMenuViewDelegate: MenuViewProtocol!
    weak var scenesViewDelegate: ScenesViewControllerProtocol!
    
    var menuType: Menu = .main
    var sections = [Section]()
    
    private weak var collectionView: UICollectionView!
    private weak var closeBtn: UIButton!
    
    private let configurator: MenuConfiguratorProtocol = MenuConfigurator()
    private var autoLayout: MenuAutoLayoutProtocol!
    private var message: Message!
    
    
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
//        initMessage()
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
        closeBtn.isHidden = menuType == .main
    }
    
    private func initMessage() {
        message = Message(calling: self, showing: .happy)
        message.showAlert()
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
        
        if menuType == .main {
            cell.layer.cornerRadius = 15
        } else {
            cell.layer.cornerRadius = view.frame.height * 0.25
        }
        cell.imageView.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if menuType == .toddler {
            presenter.didSelectToddlerCell(at: indexPath.row)
        } else if menuType == .main {
            presenter.didSelectMenuCell(at: indexPath.row)
        } else {
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if menuType == .main  {
            return CGSize(width: view.frame.width * 0.5, height: view.frame.height * 0.5)
        }
        return CGSize(width: view.frame.height * 0.5, height: view.frame.height * 0.5)
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
