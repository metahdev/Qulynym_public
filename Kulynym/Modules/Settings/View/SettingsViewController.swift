//
/*
* Kulynym
* SettingsViewController.swift
*
* Created by: Баубек on 8/5/19
*
* Copyright © 2019 Automatization X Software. All rights reserved
 
 1) solved
 2) solved UserDefaults
 3) Two buttons one class 
*/
import UIKit
protocol SettingsViewControllerProtocol: class {
    var isInfoForParents: Bool! { get set }
    var isChecked: Bool { get set }
    
    func turnOnMusic()
    func turnOffMusic()
    func checkForMusicState()
}

class SettingsViewController: UIViewController, SettingsViewControllerProtocol {
    // MARK:- Properties
    var presenter: SettingsPresenterProtocol!
    weak var textViewController: TextViewControllerProtocol!
    
    var isInfoForParents: Bool!
    
    private weak var background: UIImageView!
    private weak var closeBtn: UIButton!
    private weak var checkmarkBtn: UIButton!
    private weak var musicBtn: UIButton!
    private weak var infoBtn: UIButton!
    private weak var creditsBtn: UIButton!
    
    private let configurator: SettingsConfiguratorProtocol = SettingsConfigurator()
    private var settingsView: SettingsViewProtocol!
    
    var isChecked = true
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        initLayout()
        settingsView.setupLayout()
        checkForMusicState()    
        assignViews()
        assignActions()
    }

    
    // MARK:- Layout
    private func initLayout() {
        settingsView = SettingsView(self.view)
    }
    
    private func assignViews() {
        self.background = settingsView.background
        self.closeBtn = settingsView.closeBtn
        self.checkmarkBtn = settingsView.checkmarkBtn
        self.musicBtn = settingsView.musicBtn
        self.infoBtn = settingsView.infoBtn
        self.creditsBtn = settingsView.creditsBtn
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        checkmarkBtn.addTarget(self, action: #selector(checkmarkBtnPressed), for: .touchUpInside)
        infoBtn.addTarget(self, action: #selector(infoBtnPressed), for: .touchUpInside)
        creditsBtn.addTarget(self, action: #selector(creditsBtnPressed), for: .touchUpInside)
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
    }
    
    @objc func checkmarkBtnPressed() {
        isChecked = !isChecked
        if isChecked {
            settingsView.setBoxChecked()
            turnOnMusic()
        } else {
            settingsView.setBoxUnchecked()
            turnOffMusic()
        }
        presenter.setBackgroundMusicState()
    }
    
    @objc func infoBtnPressed() {
        isInfoForParents = true
        presenter.goToTextViewController()
//        presenter.goToInfoForParentsViewController()
    }
    
    @objc func creditsBtnPressed() {
        isInfoForParents = false
        presenter.goToTextViewController()
//        presenter.goToCreditsViewController()
    }
    
    @objc func closeBtnPressed() {
        presenter.closeView()
    }
}

extension SettingsViewController {
    func turnOffMusic() {
        AudioPlayer.backgroundAudioPlayer.volume = 0
    }
    
    func turnOnMusic() {
        AudioPlayer.backgroundAudioPlayer.volume = 0.5
    }
    
    func checkForMusicState() {
        let musicPlaying = UserDefaults.standard.bool(forKey: "music playing")
        
        if musicPlaying {
            isChecked = true
        } else {
            isChecked = false
        }
    }
}

