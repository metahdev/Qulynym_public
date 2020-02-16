/*
* Qulynym
* MenuViewController.swift
*
* Created by: Metah on 6/10/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit
import Alamofire
import SkeletonView

enum Menu: String {
    case main
    case beinelerPlaylists = "channelId"
    case beineler = "id"
    case toddler
    case games
}

protocol MenuViewControllerProtocol: class {
    var menuType: Menu { get set }
    var playlistID: String? { get set }
    var dataFetchAPI: DataFetchAPI! { get } 
}

class MenuViewController: UIViewController, MenuViewControllerProtocol, DataFetchAPIDelegate, ConnectionWarningViewControllerDelegate {
    // MARK:- Properties
    var presenter: MenuPresenterProtocol!
    
    weak var beineViewDelegate: BeineViewControllerProtocol! 
    weak var playlistViewDelegate: PlaylistViewControllerProtocol!
    weak var secondMenuViewDelegate: MenuViewControllerProtocol!
    weak var itemViewDelegate: ItemViewControllerProtocol!
    
    var menuType: Menu = .main
    var playlistID: String?
    var dataFetchAPI: DataFetchAPI!
    var isPassingSafe = false
    var isConnectionErrorShowing = false
    
    private var ifFetchHasAlreadyDone = false
    private var menuView: MenuViewProtocol!
    private let configurator: MenuConfiguratorProtocol = MenuConfigurator()
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        initLayout()
        menuView.setupLayout()
        setupProperties()
        assignActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if menuType == .beineler || menuType == .beinelerPlaylists {
            if !ifFetchHasAlreadyDone {
                ifFetchHasAlreadyDone = true
                dataFetchAPI.fetchBeine()
            }
        }
        hideOrUnhideCloseBtn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if menuType == .beineler || menuType == .beinelerPlaylists {
            if !Connectivity.isConnectedToInternet {
                showAnErrorMessage()
            }
        }
    }
    
    
    // MARK:- Orientation
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.landscape]
    }
    
    override var prefersStatusBarHidden: Bool {
        return true 
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        menuView = MenuView(self.view)
    }
    
    private func setupProperties() {
        dataFetchAPI = DataFetchAPI(delegate: self)
        menuView.collectionView.delegate = self
        menuView.collectionView.dataSource = self
        
        if menuType == .main {
            self.navigationController!.delegate = self
        }
        if menuType == .beinelerPlaylists {
            self.menuView.titleLabel.font = UIFont(name: "Arial Rounded MT Bold", size: view.frame.height * 0.09)
        }
        self.navigationController!.isNavigationBarHidden = true
    }
    
    private func hideOrUnhideCloseBtn() {
        menuView.closeBtn.isHidden = menuType == .main
        menuView.settingsBtn.isHidden = menuType != .main
        
        if menuType == .main {
            menuView.titleLabel.text = "Qulynym"
        } else if menuType == .toddler {
            menuView.titleLabel.text = "Oqu"
        } else if menuType == .games {
            menuView.titleLabel.text = "Oyin Oinau"
        } else if menuType == .beinelerPlaylists {
            menuView.titleLabel.text = "Oınatý Tіzіmderi"
        } else {
            menuView.titleLabel.text = "Beineler"
        }
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        menuView.closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
        menuView.settingsBtn.addTarget(self, action: #selector(settingsBtnPressed), for: .touchUpInside)
    }
    
    @objc
    private func closeBtnPressed() {
        presenter.closeView() 
    }
    @objc func settingsBtnPressed() {
        presenter.goToSettings()
    }
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK:- UICollectionView Protocols
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if menuType == .toddler {
            return ContentService.toddlerSections.count
        }
        if menuType == .beinelerPlaylists || menuType == .beineler {
            if dataFetchAPI.beineler.count == 0 {
                return 5
            } else {
                return dataFetchAPI.beineler.count
            }
        }
        return ContentService.sections[menuType]!.count        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseID", for: indexPath) as! ImageCollectionViewCell

        cell.backgroundColor = UIColor(red: 149/255, green: 165/255, blue: 166/255, alpha: 1)
        cell.imageView.isSkeletonable = true
        cell.imageViewCornerRadius = 15
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 5
        cell.imageViewLayerMasksToBounds = true
        cell.textSize = cell.frame.height * 0.17
        
        if menuType == .main {
            cell.text = ContentService.sections[menuType]![indexPath.row]
            cell.image = UIImage(named: ContentService.sections[menuType]![indexPath.row])
        } else if menuType == .beinelerPlaylists || menuType == .beineler {
            cell.isUserInteractionEnabled = false
            if self.dataFetchAPI.beineler.count != 0 {
                cell.isUserInteractionEnabled = true
                
//                if cell.beine == nil {
//                    let gradient = SkeletonGradient(baseColor: .concrete)
//                    cell.imageView.showAnimatedGradientSkeleton(usingGradient: gradient)
//                }
                
                cell.beine = self.dataFetchAPI.beineler[indexPath.row]
            }
        } else if menuType == .toddler {
            cell.layer.cornerRadius = cell.frame.height * 0.5
            cell.text = ContentService.toddlerSections[indexPath.row].name
            cell.image = UIImage(named: ContentService.toddlerSections[indexPath.row].name)
            return cell
        } else {
            cell.layer.cornerRadius = cell.frame.height * 0.5
            cell.text = ContentService.sections[menuType]![indexPath.row]
            cell.image = UIImage(named: ContentService.sections[menuType]![indexPath.row])
            return cell
        }
        
        cell.layer.cornerRadius = 15
        cell.imageViewCornerRadius = 15
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if menuType == .main {
            presenter.didSelectMenuCell(at: indexPath.row)
        } else if menuType == .beinelerPlaylists {
            presenter.didSelectPlaylistCell(playlist: self.dataFetchAPI.beineler[indexPath.row].id)
        } else if menuType == .beineler {
            if self.isPassingSafe {
                presenter.didSelectVideoCell(index: indexPath.row)
            }
        } else if menuType == .toddler {
            presenter.didSelectToddlerCell(at: indexPath.row)
        } else {
            presenter.didSelectGamesCell(at: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard menuType == .beineler || menuType == .beinelerPlaylists else { return }
        guard dataFetchAPI.token != nil else { return }
        
         if (indexPath.row == dataFetchAPI.beineler.count - 1 ) {
            self.dataFetchAPI.fetchBeine()
         }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if menuType == .toddler || menuType == .games  {
            return CGSize(width: view.frame.height * 0.5, height: view.frame.height * 0.5)
        } else {
            return CGSize(width: view.frame.width * 0.5, height: view.frame.height * 0.5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 84
    }
}


extension MenuViewController {
    // MARK:- DataFetchAPIDelegate Methods
    func dataIsReady() {
        self.isPassingSafe = true 
        menuView.collectionView.reloadData()
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


extension MenuViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = Animator()
        return animator
    }
}

