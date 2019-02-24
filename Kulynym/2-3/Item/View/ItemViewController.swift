/*
 * Kulynym
 * File.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol ItemVCProtocol: class {
    var category: String { get set }
    var slideCount: Int { get set }
    var contentKey: String { get set }
    func setupContent()
}

class ItemViewController: UIViewController, ItemVCProtocol {
    // MARK: Properties
    #warning ("need to delete default value")
    var category = "Alphabet"
    var slideCount = 0
    var contentKey = ""
    
    lazy var mainImageView: UIImageView = {
        var iv = UIImageView()
        iv.isUserInteractionEnabled = true
        return iv
    }()
    lazy var closeBtn: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.addTarget(self, action: #selector(), for: .touchUpInside)
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
        image.image = UIImage(named: "background")
        return image
    }()
    
    var autoLayoutManager: ItemAutoLayoutManager!
    var presenter: ItemPresenterProtocol!
    let configurator: ItemConfiguratorProtocol = ItemConfigurator()
    
    
    // MARK: View Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.updateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        setupGesture()
        setupLayout()
    }

    
    // MARK: Actions
    func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        mainImageView.addGestureRecognizer(tap)
    }
    
    @objc func imageTapped() {
        presenter.imageViewPressed()
    }
    
    @objc func forwardBtnPressed() {
        presenter.updateView()
    }
    
    @objc func closeBtnTapped() {
        presenter.closeBtnPressed()
    }
    
    // MARK: View
    func setupLayout() {
        configureLayout()
        activateConstraints()
    }
    
    func configureLayout() {
        self.autoLayoutManager = ItemAutoLayoutManager(self.view, imageView: mainImageView, closeBtn: closeBtn, forwardBtn: forwardBtn, background: backgroundImage)
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate(autoLayoutManager.initConstraints())
    }
}


extension ItemViewController {
    // MARK: Protocol Methods
    func setupContent() {
        self.mainImageView.image = UIImage(named: contentKey)
        AudioManager.initExtraAudioPath(with: contentKey)
    }
}
