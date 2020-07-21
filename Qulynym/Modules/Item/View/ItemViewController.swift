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
    var returnedFromQuiz: Bool { get set }
    
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
    var returnedFromQuiz = false 
    var presenter: ItemPresenterProtocol!
    var quizViewController: QuizViewControllerProtocol!
    
    private weak var titleLabel: UILabel!
    private weak var contentBtn: UIButton!
    private weak var closeBtn: UIButton!
    private weak var forwardBtn: UIButton!
    private weak var backBtn: UIButton!
    
    private var itemView: ItemViewProtocol!
    private let configurator: ItemConfiguratorProtocol = ItemConfigurator()

    
    // MARK:- Status Bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        initLayout()
        itemView.setupLayout()
        assignViews()
        assignActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.openedQuiz = false 
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
        self.backBtn = itemView.backBtn
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
        backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
    }
    
    @objc func contentBtnPressed() {
        presenter.contentBtnPressed()
    }
    
    @objc func forwardBtnPressed() {
        presenter.updateView()
    }
    
    @objc func backBtnPressed() {
        presenter.returnBack()
    }
    
    @objc
    private func closeBtnPressed() {
        presenter.closeBtnPressed()
    }
    
    private func setupBackBtnEnability() {
        if presenter.slideCount == 0 && presenter.slideCount % 4 == 0 {
            backBtn.isEnabled = false
        }
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
