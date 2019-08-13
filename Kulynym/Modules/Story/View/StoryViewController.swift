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
    var index: Int! { get set }
    var isPlaying: Bool { get set }
    var maxCount: Int { get set }
}

class StoryViewController: UIViewController, StoryViewControllerProtocol {
    // MARK:- Properties
    var storyName: String!
    var index: Int!
    var isPlaying = false
    var maxCount = 0
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
        assignActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getMaxCount()
        setProperties()
    }
    
    // MARK:- Layout
    private func initLayout() {
        storyView = StoryView(self.view)
    }
    
    func setProperties() {
        storyView.storyImageView.image = UIImage(named: storyName)
        storyView.titleLabel.text = storyName
        storyView.backBtn.isEnabled = index != 0
        storyView.forwardBtn.isEnabled = index != maxCount
    }
    
    // MARK:- Actions
    private func assignActions() {
        storyView.closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
        storyView.playBtn.addTarget(self, action: #selector(playBtnPressed), for: .touchUpInside)
        storyView.forwardBtn.addTarget(self, action: #selector(forwardBtnPressed), for: .touchUpInside)
    }
    
    @objc private func closeBtnPressed() {
        presenter.closeView()
    }
    
    @objc private func playBtnPressed() {
        if isPlaying {
            presenter.stopAudio()
            storyView.playBtn.setImage(UIImage(named: "playBtn"), for: .normal)
        } else {
            presenter.playAudio()
            storyView.playBtn.setImage(UIImage(named: "pauseBtn"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    @objc private func forwardBtnPressed() {
        presenter.playNext()
    }
    
    @objc private func backBtnPressed() {
        presenter.playPrevious()
    }
}
