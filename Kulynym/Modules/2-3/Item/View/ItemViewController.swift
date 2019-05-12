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
    var contentNames: [String]! { get set }
    
    func updateContent(contentKey: String)
}

class ItemViewController: UIViewController, ItemVCProtocol {
    // MARK:- Properties
    var contentNames: [String]!
    var presenter: ItemPresenterProtocol!
    
    private weak var contentBtn: UIButton!
    private weak var closeBtn: UIButton!
    private weak var forwardBtn: UIButton!
    
    private var autoLayout: ItemAutoLayoutProtocol!
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.updateView()
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        self.autoLayout = ItemAutoLayout(self.view)
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
    }
}
