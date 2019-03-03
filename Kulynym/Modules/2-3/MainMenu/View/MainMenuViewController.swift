/*
* Kulynym
* MainMenuViewController.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol MainMenuViewControllerProtocol: class {
    
}

class MainMenuViewController: UIViewController, MainMenuViewControllerProtocol {
    // MARK: Properties
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.bounces = false
        return sv
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "2-4bg")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var alphabetBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "alphabetIcon"), for: .normal)
        btn.addTarget(self, action: #selector(buttonsTouched(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var numbersBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "numbersIcon"), for: .normal)
        btn.addTarget(self, action: #selector(buttonsTouched(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var animalsBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "animalsIcon"), for: .normal)
        btn.addTarget(self, action: #selector(buttonsTouched(sender:)), for: .touchUpInside)
        return btn
    }()
    
    var presenter: MainMenuPresenterProtocol!
    var autoLayoutManager: MainMenuVCAutoLayout!
    var configurator: MainMenuConfiguratorProtocol = MainMenuConfigurator()
    
    // MARK: View Lifestyle
    override func viewWillAppear(_ animated: Bool) {
        presenter.updateProgressState()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        configureLayout()
        removeNavigationBar()
    }
    
    // MARK: View
    func configureLayout() {
        autoLayoutManager = MainMenuVCAutoLayout(view: self.view, scrollView: self.scrollView, background: self.backgroundImageView, alphabetBtn: self.alphabetBtn, numberBtn: self.numbersBtn, animalsBtn: self.animalsBtn)
    }
    
    func removeNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: Actions
    @objc func buttonsTouched(sender: UIButton) {
        let imageName = sender.imageView?.image
        var direction = ""
        
        switch imageName {
        case UIImage(named: "alphabetIcon"):
            direction = "Alphabet"
        case UIImage(named: "numbersIcon"):
            direction = "Numbers"
        case UIImage(named: "animalsIcon"):
            direction = "Animals"
        default:
            direction = ""
        }
        presenter.iconPressed(with: direction)
    }
}
