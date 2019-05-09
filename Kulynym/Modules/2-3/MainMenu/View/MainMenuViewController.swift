/*
* Kulynym
* MainMenuViewController.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol MainMenuViewControllerProtocol: class {}

class MainMenuViewController: UIViewController, MainMenuViewControllerProtocol {
    // MARK:- Properties
    weak var alphabetBtn: UIButton!
    weak var numbersBtn: UIButton!
    weak var animalsBtn: UIButton!
    
    var presenter: MainMenuPresenterProtocol!
    var scenesViewDelegate: ScenesViewControllerProtocol!
    private var autoLayout: MainMenuAutoLayoutProtocol!
    private var configurator: MainMenuConfiguratorProtocol = MainMenuConfigurator()
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        initLayout()
        autoLayout.setupLayout()
        hideNavigationBar()
        assignViews()
        assignActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.updateProgressState()
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        autoLayout = MainMenuAutoLayout(self.view)
    }
    
    private func assignViews() {
        self.alphabetBtn = autoLayout.alphabetBtn
        self.numbersBtn = autoLayout.numbersBtn
        self.animalsBtn = autoLayout.animalsBtn
    }
    
    private func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        alphabetBtn.addTarget(self, action: #selector(buttonsTouched(sender:)), for: .touchUpInside)
        numbersBtn.addTarget(self, action: #selector(buttonsTouched(sender:)), for: .touchUpInside)
        animalsBtn.addTarget(self, action: #selector(buttonsTouched(sender:)), for: .touchUpInside)
    }
    
    @objc func buttonsTouched(sender: UIButton) {
        let direction = getDirection(image: sender.imageView!.image!)
        presenter.iconPressed(with: direction)
    }
    
    private func getDirection(image: UIImage) -> String {
        switch image {
        case UIImage(named: "alphabetIcon"):
            return "Alphabet"
        case UIImage(named: "numbersIcon"):
            return "Numbers"
        case UIImage(named: "animalsIcon"):
            return "Animals"
        default:
            return ""
        }
    }
}
