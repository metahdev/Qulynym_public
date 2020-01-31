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

enum Menu: String {
    case main
    case beinelerPlaylists = "channelId"
    case beineler = "id"
    case toddler
    case games
}

protocol MenuViewControllerProtocol: class {
    var menuType: Menu { get set }
    var playlistID: String! { get set }
    var beineler: [Beine] { get set }
    
    func reloadData()
}

class MenuViewController: UIViewController, MenuViewControllerProtocol {
    // MARK:- Properties
    var presenter: MenuPresenterProtocol!
    
    weak var videoViewDelegate: VideoViewControllerProtocol! 
    weak var playlistViewDelegate: PlaylistViewControllerProtocol!
    weak var secondMenuViewDelegate: MenuViewControllerProtocol!
    weak var itemViewDelegate: ItemViewControllerProtocol!
    
    var menuType: Menu = .main
    var playlistID: String!
    var beineler = [Beine]()
    
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
        if menuType == .beineler || menuType == .beinelerPlaylists {
            presenter.getSections()
        }
        hideOrUnhideCloseBtn()
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
        if menuType == .main {
            return ContentService.menuSections.count
        }
        if menuType == .beinelerPlaylists || menuType == .beineler {
            if beineler.count == 0 {
                return 20
            } else {
                return beineler.count
            }
        }
        return ContentService.sections[menuType]!.count        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseID", for: indexPath) as! ImageCollectionViewCell

        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 5
        cell.textSize = cell.frame.height * 0.17
        
        if menuType == .main {
            cell.text = ContentService.menuSections[indexPath.row]
            cell.image = UIImage(named: ContentService.menuSections[indexPath.row])
        } else if menuType == .beinelerPlaylists || menuType == .beineler {
            cell.backgroundColor = .gray
            if beineler.count != 0 {
                cell.text = self.beineler[indexPath.row].title
                
                let configuration = URLSessionConfiguration.default
                configuration.waitsForConnectivity = true
                let session = URLSession(configuration: configuration)

                let url = URL(string: self.beineler[indexPath.row].thumbnailURL)!
                let task = session.dataTask(with: url) {(data, response, error) in
                    guard let httpResponse = response as? HTTPURLResponse,
                        httpResponse.statusCode == 200 else {    return }
                    
                    guard let data = data else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        cell.image = UIImage(data: data)
                    }
                }
                task.resume()
            }
        } else {
            cell.layer.cornerRadius = cell.frame.height * 0.5
            cell.text = ContentService.sections[menuType]![indexPath.row]
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


extension MenuViewController {
    func reloadData() {
        menuView.collectionView.reloadData()
    }
}


extension MenuViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = Animator()
        return animator
    }
}

