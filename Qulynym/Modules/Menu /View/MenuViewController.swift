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

enum Menu {
    case main
    case beinelerPlaylists
    case beineler
    case toddler
    case games
}

protocol MenuViewControllerProtocol: class {
    var menuType: Menu { get set }
    var sections: [String] { get set }
    var eduSections: [EduSection] { get set }
}

class MenuViewController: UIViewController, MenuViewControllerProtocol {
    // MARK:- Properties
    var presenter: MenuPresenterProtocol!
    
    weak var videoViewDelegate: VideoViewControllerProtocol! 
    weak var playlistViewDelegate: PlaylistViewControllerProtocol!
    weak var secondMenuViewDelegate: MenuViewControllerProtocol!
    weak var itemViewDelegate: ItemViewControllerProtocol!
    
    var menuType: Menu = .main
    var sections = [String]()
    var eduSections = [EduSection]()
    
    private let configurator: MenuConfiguratorProtocol = MenuConfigurator()
    private var menuView: MenuViewProtocol!
    
    
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
        presenter.getSections()
        hideOrUnhideCloseBtn()
        fetchPlaylistVideos()
    }
    
    func fetchPlaylistVideos() {
        var playlistID = "PLm8b4TrIR2AcXTsUw9BrBcL4552pE6wA2"
        let apiKey = "AIzaSyAxwDKck_8Ve5hrqIZfaJK1lgoVmGc4qr0"
        let stringURL = "https://www.googleapis.com/youtube/v3/playlists"
        
        AF.request(stringURL, method: .get, parameters: ["part": "snippet", "playlistID": playlistID, "key": apiKey, "channelId": "UCSJKvyZVC0FLiyvo3LeEllg"], encoder: URLEncodedFormParameterEncoder(destination: .queryString), headers: nil).responseJSON(completionHandler: { response in
            
            guard response.error == nil else {
                #warning("show an error message")
                return
            }
            
            if let json = response.value as? NSDictionary {
                print(json)
            }
        })
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
        #warning("rewrite this method for beineler")
        if menuType == .beinelerPlaylists || menuType == .beineler {
            return 20
        }
        return menuType == .toddler ? eduSections.count : sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        #warning("rewrite this method for data parsing")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseID", for: indexPath) as! ImageCollectionViewCell
        if menuType != .beinelerPlaylists && menuType != .beineler {
            cell.imageName = menuType == .toddler ? eduSections[indexPath.row].name : sections[indexPath.row]
        }
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 5
        
        if menuType == .beinelerPlaylists || menuType == .beineler {
            cell.backgroundColor = .gray
        }
        
        if menuType == .toddler || menuType == .games {
            cell.layer.cornerRadius = cell.frame.height * 0.5
        } else {
            cell.layer.cornerRadius = 15
            cell.imageViewCornerRadius = 15
        }
        
        if menuType != .beinelerPlaylists && menuType != .beineler {
            cell.text = menuType == .toddler ? eduSections[indexPath.row].name : sections[indexPath.row]
            cell.textSize = cell.frame.height * 0.17
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if menuType == .main {
            presenter.didSelectMenuCell(at: indexPath.row)
        } else if menuType == .beinelerPlaylists {
            presenter.didSelectPlaylistCell(at: indexPath.row)
        } else if menuType == .beineler {
            presenter.didSelectVideoCell(at: indexPath.row)
        } else if menuType == .toddler {
                presenter.didSelectToddlerCell(at: indexPath.row)
        } else {
            presenter.didSelectGamesCell(at: indexPath.row)
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


extension MenuViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = Animator()
        return animator
    }
}
