/*
 * Qulynym
 * SettingsViewController.swift
 *
 * Created by: Baubek on 8/5/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved
*/
import UIKit
protocol SettingsViewControllerProtocol: class {
    var isInfoForParents: Bool! { get set }
    var isChecked: Bool { get set }
    
    func turnOnMusic()
    func turnOffMusic()
}

class SettingsViewController: UIViewController, SettingsViewControllerProtocol {
    // MARK:- Properties
    var presenter: SettingsPresenterProtocol!
    weak var textViewController: TextViewControllerProtocol!
    
    var isChecked = true {
        didSet {
            checkboxOperations()
        }
    }
    var isInfoForParents: Bool!
    
    private weak var closeBtn: UIButton!
    private weak var checkmarkBtn: UIButton!
    private weak var musicBtn: UIButton!
    private weak var infoBtn: UIButton!
    private weak var creditsBtn: UIButton!
    
    private let configurator: SettingsConfiguratorProtocol = SettingsConfigurator()
    private var settingsView: SettingsViewProtocol!
    
    // MARK:- Status Bar
    override var prefersStatusBarHidden: Bool {
        return true 
    }
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        initLayout()
        settingsView.setupLayout()
        assignViews()
        assignActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.checkForMusicState()
    }
    
    // MARK:- Layout
    private func initLayout() {
        settingsView = SettingsView(self.view)
    }
    
    private func assignViews() {
        self.closeBtn = settingsView.closeBtn
        self.checkmarkBtn = settingsView.checkmarkBtn
        self.musicBtn = settingsView.musicBtn
        self.infoBtn = settingsView.infoBtn
        self.creditsBtn = settingsView.creditsBtn
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        musicBtn.addTarget(self, action: #selector(checkmarkBtnPressed), for: .touchUpInside)
        checkmarkBtn.addTarget(self, action: #selector(checkmarkBtnPressed), for: .touchUpInside)
        infoBtn.addTarget(self, action: #selector(infoBtnPressed), for: .touchUpInside)
        creditsBtn.addTarget(self, action: #selector(creditsBtnPressed), for: .touchUpInside)
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
    }
    
    @objc func checkmarkBtnPressed() {
        isChecked = !isChecked
    }
    
    @objc func infoBtnPressed() {
        isInfoForParents = true
        presenter.goToTextViewController()
    }
    
    @objc func creditsBtnPressed() {
        isInfoForParents = false
        presenter.goToTextViewController()
    }
    
    @objc func closeBtnPressed() {
        presenter.closeView()
    }
    
    private func checkboxOperations() {
        if isChecked {
            settingsView.setBoxChecked()
            turnOnMusic()
        } else {
            settingsView.setBoxUnchecked()
            turnOffMusic()
        }
        presenter.setBackgroundMusicState()
    }
}

extension SettingsViewController {
    // MARK:- Protocol Methods
    func turnOffMusic() {
        AudioPlayer.backgroundAudioPlayer.stop()
    }
    
    func turnOnMusic() {
        AudioPlayer.backgroundAudioPlayer.play()
    }
}

