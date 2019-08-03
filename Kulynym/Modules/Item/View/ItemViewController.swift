/*
 * Kulynym
 * ItemViewController.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol ItemViewControllerProtocol: class {
    var categoryName: String { get set }
    var contentNames: [String]! { get set }
    var slideCount: Int { get set }
    var checkForQuiz: Bool { get set }
    
    func updateContent(contentKey: String)
}

class ItemViewController: UIViewController, ItemViewControllerProtocol {
    // MARK:- Properties
    var categoryName = ""
    var contentNames: [String]!
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
    
    private weak var contentBtn: UIButton!
    private weak var closeBtn: UIButton!
    private weak var forwardBtn: UIButton!
    
    private var autoLayout: ItemViewProtocol!
    private let configurator: ItemConfiguratorProtocol = ItemConfigurator()

    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        initLayout()
        autoLayout.setupLayout()
        assignViews()
        assignActions()
        
        AudioPlayer.backgroundAudioPlayer.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkForQuiz = false
        presenter.updateView()
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        self.autoLayout = ItemView(self.view)
    }
    
    private func assignViews() {
        self.contentBtn = autoLayout.contentBtn
        self.closeBtn = autoLayout.closeBtn
        self.forwardBtn = autoLayout.forwardBtn
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
    
    @objc func closeBtnPressed() {
        presenter.closeBtnPressed()
    }
}


extension ItemViewController {
    // MARK:- Protocol Methods
    func updateContent(contentKey: String) {
        contentBtn.setImage(UIImage(named: contentKey), for: .normal)
        contentBtn.imageView?.contentMode = .scaleAspectFill
    }
}
