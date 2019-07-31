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

protocol StoryViewProtocol: class {
    var content: StorySection! { get set }
    
    func fillContent(firstChar: String, secondChar: String, background: String)
    func curtainsAnimation()
    func charactersAnimation(char: StoryCharacter, duration: Int)
}

class StoryViewController: UIViewController, StoryViewProtocol {
    // MARK:- Properties
    var presenter: StoryPresenterProtocol!
    var content: StorySection!
    
    private weak var backgroundImage: UIImageView!
    private weak var characterImage: UIImageView!
    private weak var secondCharacterImage: UIImageView!
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        presenter.startTimer()
//        scenesView.startCurtainsAnimation()
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        autoLayout = StoryAutoLayout(self.view)
    }
    
    private func assignViews() {
        self.backgroundImage = autoLayout.backgroundImage
        self.characterImage = autoLayout.characterImage
        self.secondCharacterImage = autoLayout.secondCharacterImage
        self.closeBtn = autoLayout.closeBtn
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
    }
    
    @objc private func closeBtnPressed() {
        presenter.closeView()
    }
}


extension StoryViewController {
    // MARK:- Protocol Methods
    func fillContent(firstChar: String, secondChar: String, background: String) {
        characterImage.image = UIImage(named: firstChar)
        secondCharacterImage.image = UIImage(named: secondChar)
    }
    
    func curtainsAnimation() {
        autoLayout.startCurtainsAnimation()
    }

    func charactersAnimation(char: StoryCharacter, duration: Int) {
        autoLayout.startCharactersAnimation(char: .first, duration: duration)
    }
}
