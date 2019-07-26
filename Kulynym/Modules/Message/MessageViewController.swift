/*
* Kulynym
* MessageViewController.swift
*
* Created by: Metah on 6/6/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

class MessageViewController: UIViewController {
    #warning("refactor")
    // MARK:- Properties
    var imageName: String! {
        didSet {
            emotionImage.image = UIImage(named: imageName)
        }
    }
    var titleText: String! {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    private weak var closeBtn: UIButton!
    private weak var emotionImage: UIImageView!
    private weak var titleLabel: UILabel!
    private var autoLayout: MessageAutoLayoutProtocol!
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
        autoLayout.setupLayout()
        assignViews()
        assignActions()
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        autoLayout =  MessageAutoLayout(view)
    }
    
    private func assignViews() {
        self.closeBtn = autoLayout.closeBtn
        self.emotionImage = autoLayout.emotionImage
        self.titleLabel = autoLayout.titleLabel
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
    }
    
    @objc func closeBtnPressed() {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
