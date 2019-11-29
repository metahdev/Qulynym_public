/*
 * Qulynym
 * InfoForParentsViewController.swift
 *
 * Created by: Baubek on 8/6/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol TextViewControllerProtocol: class {
    var content: NSAttributedString! { get set }
    var titleText: String! { get set }
}

class TextViewController: UIViewController, TextViewControllerProtocol {
    //MARK:- Properties
    var content: NSAttributedString!
    var titleText: String!
    
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Gill Sans", size: view.frame.height * 0.17)
        lbl.textAlignment = .center
        return lbl
    }()
    lazy var textView: UITextView = {
        var tv = UITextView()
        tv.backgroundColor = .clear
        tv.textAlignment = .center
        tv.isEditable = false
        tv.isScrollEnabled = true
        return tv
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
        titleLabel.text = titleText
    }
    
    
    // MARK:- Layout
    func setupLayout() {
        view.backgroundColor = UIColor(red: 0.99, green: 0.9, blue: 0.9, alpha: 1)
        
        addSubviews()
        makeMaskFalse()
        closeBtn.configureCloseBtnFrame(view)
        activateConstraints()
    }

    
    func addSubviews() {
        view.addSubview(titleLabel)
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
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
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
