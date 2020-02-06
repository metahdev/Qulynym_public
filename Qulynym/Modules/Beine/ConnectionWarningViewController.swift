//
/*
* Qulynym
* ConnectionWarningViewController.swift
*
* Created by: Баубек on 2/2/20
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol ConnectionWarningViewControllerDelegate: class {
    func fetchData()
}

class ConnectionWarningViewController: UIViewController {
    //MARK: - Properties
    weak var delegateVC: ConnectionWarningViewControllerDelegate!
    
    private lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    
    private lazy var warningImageView = UIImageView(image: UIImage(named: "rocket"))
    
    private lazy var tryAgainBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .skyBlue
        btn.layer.cornerRadius = 20
        btn.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: view.frame.height * 0.04)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("Try Again", for: .normal)
        btn.sizeToFit()
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 4
        return btn
    }()
 
    private lazy var warningLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Oh no! Internet connection lost!"
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: view.frame.height * 0.074)
        lbl.textAlignment = .center
        lbl.textColor = .black
        return lbl
    }()
    
    #warning("change the text")
    private lazy var warningDescriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "You're offline"
        lbl.font = UIFont(name: "Arial", size: view.frame.height * 0.038)
        lbl.textAlignment = .center
        lbl.textColor = .black
        return lbl
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .beigePink
        addSubviewsToTheViews()
        makeMaskFalse()
        activateConstraints()
        closeBtn.addTarget(self, action: #selector(closeView), for: .touchDown)
        closeBtn.configureCloseBtnFrame(view)
        tryAgainBtn.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        
        view.backgroundColor = .beigePink
    }
    
    func addSubviewsToTheViews() {
        view.addSubview(closeBtn)
        view.addSubview(warningImageView)
        view.addSubview(warningLbl)
        view.addSubview(warningDescriptionLbl)
        view.addSubview(tryAgainBtn)
    }
    
    func makeMaskFalse() {
        for view in view.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            warningLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            warningLbl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            warningLbl.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            warningDescriptionLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            warningDescriptionLbl.topAnchor.constraint(equalTo: warningLbl.bottomAnchor, constant: 5),
            warningDescriptionLbl.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            tryAgainBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tryAgainBtn.topAnchor.constraint(equalTo: warningDescriptionLbl.bottomAnchor, constant: 40),
            tryAgainBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            tryAgainBtn.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.14),
            
            warningImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            warningImageView.bottomAnchor.constraint(equalTo: warningLbl.topAnchor, constant: -20),
            warningImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.36),
            warningImageView.widthAnchor.constraint(equalTo: warningImageView.heightAnchor)
        ])
    }
    
    //MARK: - Actions
    @objc
    private func closeView() {
        if let firstViewController = self.navigationController?.viewControllers[0] {
            self.navigationController?.popToViewController(firstViewController, animated: true)
        }
    }
    
    @objc
    private func tryAgain() {
        if Connectivity.isConnectedToInternet {
            self.navigationController?.popViewController(animated: true)
            delegateVC.fetchData()
        }
    }
}
