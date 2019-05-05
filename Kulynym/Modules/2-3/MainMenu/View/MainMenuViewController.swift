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
    private var autoLayout: MainMenuAutoLayout!
    private var configurator: MainMenuConfiguratorProtocol = MainMenuConfigurator()
    
    
    // MARK:- View Lifestyle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        configureLayout()
        assignViews()
        assignActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.updateProgressState()
    }
    
    
    // MARK:- Layout
    private func configureLayout() {
        autoLayout = MainMenuAutoLayout(view: self.view)
    }
    
    private func assignViews() {
        self.alphabetBtn = autoLayout.alphabetBtn
        self.numbersBtn = autoLayout.numbersBtn
        self.animalsBtn = autoLayout.animalsBtn
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
