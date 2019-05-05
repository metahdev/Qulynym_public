/*
 * Kulynym
 * ItemViewController.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol ItemVCProtocol: class {    
    func updateContent(contentKey: String)
}

class ItemViewController: UIViewController, ItemVCProtocol {
    // MARK:- Properties
    lazy var contentButton: UIButton = {
        var iv = UIButton()
        iv.addTarget(self, action: #selector(contentBtnPressed), for: .touchUpInside)
        return iv
    }()
    lazy var closeBtn: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.addTarget(self, action: #selector(closeBtnTapped), for: .touchUpInside)
        return btn
    }()
    lazy var forwardBtn: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(named: "forward"), for: .normal)
        btn.addTarget(self, action: #selector(forwardBtnPressed), for: .touchUpInside)
        return btn
    }()
    lazy var backgroundImage: UIImageView = {
        var image = UIImageView()
        image.layer.zPosition = -1
        image.image = UIImage(named: "itemBackground")
        return image
    }()
   
    var autoLayoutManager: ItemVCAutoLayout!
    var presenter: ItemPresenterProtocol!
    let configurator: ItemConfiguratorProtocol = ItemConfigurator()

    
    // MARK:- View Lifecycle
    convenience init(category: String) {
        self.init()
        configurator.configure(with: self)
        presenter.category = category
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.updateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        AudioPlayer.backgroundAudioPlayer.play()
    }
    
    
    // MARK:- View
    func configureLayout() {
        self.autoLayoutManager = ItemVCAutoLayout(self.view, contentBtn: contentButton, closeBtn: closeBtn, forwardBtn: forwardBtn, background: backgroundImage)
    }
    
    
    // MARK:- Actions
    @objc func contentBtnPressed() {
        presenter.contentBtnPressed()
    }
    
    @objc func forwardBtnPressed() {
        presenter.updateView()
    }
    
    @objc func closeBtnTapped() {
        presenter.closeBtnPressed()
    }
}


extension ItemViewController {
    // MARK:- Protocol Methods
    func updateContent(contentKey: String) {
        contentButton.setImage(UIImage(named: contentKey), for: .normal)
    }
}
