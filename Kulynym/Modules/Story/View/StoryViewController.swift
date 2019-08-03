/*
* Kulynym
* StoryViewController.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

enum StoryCharacter {
    case first
    case second
}

protocol StoryViewControllerProtocol: class {
    var storyName: String! { get set }
}

class StoryViewController: UIViewController, StoryViewControllerProtocol {
    // MARK:- Properties
    var storyName: String!
    var presenter: StoryPresenterProtocol!
    
    private weak var closeBtn: UIButton!
    
    private var storyView: StoryViewProtocol!
    private let configurator: StoryConfiguratorProtocol = StoryConfigurator()
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        initLayout()
        storyView.setupLayout()
        assignViews()
        assignActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        storyView = StoryView(self.view)
    }
    
    private func assignViews() {
        self.closeBtn = storyView.closeBtn
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
    }
    
    @objc private func closeBtnPressed() {
        presenter.closeView()
    }
}
