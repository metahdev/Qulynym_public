/*
 * Qulynym
 * ItemViewController.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol ItemViewControllerProtocol: class {
    var section: EduSection! { get set }
    var areImagesTransparent: Bool { get set }
    var slideCount: Int { get set }
    var checkForQuiz: Bool { get set }
    
    func updateContent(contentKey: String)
}

class ItemViewController: UIViewController, ItemViewControllerProtocol {
    // MARK:- Properties
    var section: EduSection!
    var areImagesTransparent = true
    var slideCount: Int {
        get {
            return presenter.slideCount
        }
        set {
            presenter.slideCount = newValue
        }
    }
    var checkForQuiz = false
    var presenter: ItemPresenterProtocol!
    var quizViewController: QuizViewControllerProtocol!
    
    private weak var titleLabel: UILabel!
    private weak var contentBtn: UIButton!
    private weak var closeBtn: UIButton!
    private weak var forwardBtn: UIButton!
    
    private var itemView: ItemViewProtocol!
    private let configurator: ItemConfiguratorProtocol = ItemConfigurator()

    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        initLayout()
        itemView.setupLayout()
        assignViews()
        assignActions()
        
        AudioPlayer.backgroundAudioPlayer.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkForQuiz = false
        presenter.getAreImagesTransparentInfo()
        presenter.updateView()
        setupContentButtonBorder()
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        self.itemView = ItemView(self.view)
    }
    
    private func assignViews() {
        self.titleLabel = itemView.titleLabel
        self.contentBtn = itemView.contentBtn
        self.closeBtn = itemView.closeBtn
        self.forwardBtn = itemView.forwardBtn
    }
    
    private func setupContentButtonBorder() {
        if !areImagesTransparent {
            contentBtn.layer.borderWidth = 5
            contentBtn.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        contentBtn.addTarget(self, action: #selector(contentBtnPressed), for: .touchUpInside)
        forwardBtn.addTarget(self, action: #selector(forwardBtnPressed), for: .touchUpInside)
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
    }
    
    @objc func contentBtnPressed() {
        presenter.contentBtnPressed()
    }
    
    @objc func forwardBtnPressed() {
        presenter.updateView()
    }
    
    @objc
    private func closeBtnPressed() {
        presenter.closeBtnPressed()
    }
}


extension ItemViewController {
    // MARK:- Protocol Methods
    func updateContent(contentKey: String) {
        titleLabel.text = contentKey
        contentBtn.setImage(UIImage(named: contentKey), for: .normal)
        if areImagesTransparent {
            contentBtn.imageView?.contentMode = .scaleAspectFit
        } else {
            contentBtn.imageView?.contentMode = .scaleAspectFill
        }
    }
}
