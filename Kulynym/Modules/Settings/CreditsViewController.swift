//
/*
* Kulynym
* CreditsViewController.swift
*
* Created by: Баубек on 8/7/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

class CreditsViewController: UIViewController {
    //MARK:- Properties
    var content: String!
    var constraints = [NSLayoutConstraint]()
    
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "Credits", attributes: [NSAttributedString.Key.font: UIFont(name: "Arial", size: view.frame.height * 0.1)!])
        
        attributedText.append(NSAttributedString(string: "\n\n\nSomething about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.Something about credits.", attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: view.frame.height * 0.04)!, NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = true
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    func setupLayout() {
        generalLayoutSetup()
        addSubviews()
        makeMaskFalse()
        closeBtn.configureCloseBtnFrame(view)
        activateConstraints()
    }
    
    func generalLayoutSetup() {
        view.backgroundColor = .white
    }
    
    func addSubviews() {
        view.addSubview(textView)
        view.addSubview(closeBtn)
        
    }
    
    func makeMaskFalse() {
        for subview in view.subviews{
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: closeBtn.centerYAnchor),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
    }
    @objc func closeBtnPressed() {
        self.navigationController!.popViewController(animated: true)
    }
}
