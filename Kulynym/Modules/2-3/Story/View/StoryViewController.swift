/*
* Kulynym
* StoryViewController.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol StoryViewProtocol: class {
    
}

class StoryViewController: UIViewController, StoryViewProtocol {
    // MARK:- Properties
    var presenter: StoryPresenterProtocol!
    
    private weak var backgroundImage: UIImageView!
    private weak var characterImage: UIImageView!
    private weak var closeBtn: UIButton!
    
    private var autoLayout: StoryAutoLayoutProtocol!
    private let configurator: StoryConfiguratorProtocol = StoryConfigurator()
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        initLayout()
        autoLayout.setupLayout()
        assignViews()
        assignActions()
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        autoLayout = StoryAutoLayout(self.view)
    }
    
    private func assignViews() {
        autoLayout.backgroundImage = self.backgroundImage
        autoLayout.characterImage = self.characterImage
        autoLayout.closeBtn = self.closeBtn
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
    }
    
    @objc private func closeBtnPressed() {
        presenter.closeView()
    }
}
