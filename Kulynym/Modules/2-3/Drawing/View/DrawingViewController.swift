//
/*
* Kulynym
* DrawingViewController.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol DrawingViewProtocol: class {
    
}

class DrawingViewController: UIViewController, DrawingViewProtocol {
    // MARK:- Properties
    var presenter: DrawingPresenterProtocol!
    
    private weak var closeBtn: UIButton!
    
    private var autoLayout: DrawingAutoLayoutProtocol!
    private let configurator: DrawingConfiguratorProtocol = DrawingConfigurator()
    
    
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
        autoLayout = DrawingAutoLayout(self.view)
    }
    
    private func assignViews() {
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
