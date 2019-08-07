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
    var content: String! { get set }
}

class TextViewController: UIViewController, TextViewControllerProtocol {
    //MARK:- Properties
    var content: String!
    var constraints = [NSLayoutConstraint]()
    
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "clode"), for: .normal)
        return btn
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.contentSize = CGSize(width: view.frame.width, height: textView.contentSize.height)
        return sv
    }()
    
    lazy var textView: UITextView = {
        var tv = UITextView()
        tv.text = content
        tv.backgroundColor = .white
        tv.sizeToFit()
        return tv
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
        view.addSubview(scrollView)
        scrollView.addSubview(textView)
    }
    
    func makeMaskFalse() {
        for subview in view.subviews + scrollView.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: scrollView.contentSize.height),
            
            textView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}
