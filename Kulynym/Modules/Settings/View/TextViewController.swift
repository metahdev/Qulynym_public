//
/*
* Kulynym
* InfoForParentsViewController.swift
*
* Created by: Баубек on 8/6/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol TextViewControllerProtocol: class {
    var content: NSAttributedString! { get set }
}

class TextViewController: UIViewController, TextViewControllerProtocol {
    //MARK:- Properties
    var content: NSAttributedString!
    
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        return btn
    }()
    
    lazy var textView: UITextView = {
        var tv = UITextView()
        tv.backgroundColor = .clear
        tv.textAlignment = .center
        tv.isEditable = false
        tv.isScrollEnabled = true
        return tv
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "settingsBg")
        return iv
    }()

    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        assignActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.attributedText = content
    }
    
    
    // MARK:- Layout
    func setupLayout() {
        addSubviews()
        makeMaskFalse()
        closeBtn.configureCloseBtnFrame(view)
        backgroundImage.configureBackgroundImagePosition(view)
        activateConstraints()
    }

    
    func addSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(textView)
        view.addSubview(closeBtn)
    }
    
    func makeMaskFalse() {
        for subview in view.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.topAnchor.constraint(equalTo: view.topAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
    }
    
    @objc
    private func closeBtnPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}
