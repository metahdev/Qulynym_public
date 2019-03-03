/*
* Kulynym
* ScenesViewController.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol ScenesViewControllerProtocol: class {
    func fillContent(image named: String)
}

class ScenesViewController: UIViewController, ScenesViewControllerProtocol {
    // MARK: Properties
    var presenter: ScenesPresenterProtocol!
    var autoLayoutManager: ScenesAutoLayoutManager!
    var configurator: ScenesConfiguratorProtocol = ScenesConfigurator()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    lazy var skipBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "forward"), for: .normal)
        btn.addTarget(self, action: #selector(skipBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    // MARK: View Lifestyle
    convenience init(category: String) {
        self.init()
        configurator.configure(with: self)
        presenter.category = category
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.getScenes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        presenter.playAudio()
        presenter.startTimer()
    }
    
    // MARK: View
    func configureView() {
        autoLayoutManager = ScenesAutoLayoutManager(view: self.view, imageView: imageView, forwardBtn: skipBtn)
    }
    
    // MARK: Actions
    @objc func skipBtnPressed() {
        presenter.skipBtnPressed()
    }
}

extension ScenesViewController {
    func fillContent(image named: String) {
        imageView.image = UIImage(named: named)
    }
}
