/*
* Kulynym
* StoryAutoLayout.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol StoryAutoLayoutProtocol: class {
    var backgroundImage: UIImageView { get set }
    var characterImage: UIImageView { get set }
    var secondCharacterImage: UIImageView { get set }
    var closeBtn: UIButton { get set } 
    
    func setupLayout()
    func startCharactersAnimation(char: StoryCharacter, duration: Int)
    func startCurtainsAnimation()
}

class StoryAutoLayout: StoryAutoLayoutProtocol {
    // MARK:- Properties
    #warning("Images")
    lazy var backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.layer.zPosition = -1
        iv.image = UIImage(named: "kolobokHouse")
        return iv
    }()
    lazy var characterImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "kolobokGrandma")
        return iv
    }()
    lazy var secondCharacterImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "kolobokChar")
        return iv
    }()
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        return btn
    }()
    private lazy var leftCurtainsImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "leftClosedCurtains")
        return iv
    }()
    private lazy var rightCurtainsImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "rightClosedCurtains")
        return iv
    }()
    private weak var view: UIView!
    private var curtainsConstraints = [NSLayoutConstraint]()
    private var charConstraints = [NSLayoutConstraint]()
    private var isCurtainsClosed = true
    
    
    // MARK:- Initialization
    required init(_ view: UIView) {
        self.view = view
    }
    
    
    // MARK:- Layout
    func setupLayout() {
        addSubviews()
        setSubviewsMask()
        initClosedCurtainsConstraints()
        initCharConstraints()
        activateMainConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(closeBtn)
        view.addSubview(backgroundImage)
        view.addSubview(characterImage)
        view.addSubview(secondCharacterImage)
        view.addSubview(leftCurtainsImage)
        view.addSubview(rightCurtainsImage)
    }
    
    private func setSubviewsMask() {
        for subview in view.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func initClosedCurtainsConstraints() {
        curtainsConstraints = [
            leftCurtainsImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            rightCurtainsImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ]
    }
    
    private func initOpenCurtainsConstraints() {
        curtainsConstraints = [
            leftCurtainsImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            rightCurtainsImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2)
        ]
    }
    
    private func initCharConstraints()  {
        charConstraints = [
            characterImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2, constant: 32),
            secondCharacterImage.heightAnchor.constraint(equalTo: characterImage.heightAnchor),
        ]
    }
    
    private func activateMainConstraints() {
        NSLayoutConstraint.activate([
            closeBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            closeBtn.topAnchor.constraint(equalTo: view.topAnchor),
            closeBtn.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25, constant: 24),
            closeBtn.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            
            leftCurtainsImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leftCurtainsImage.topAnchor.constraint(equalTo: view.topAnchor),
            leftCurtainsImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            rightCurtainsImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rightCurtainsImage.topAnchor.constraint(equalTo: view.topAnchor),
            rightCurtainsImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            characterImage.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            characterImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            characterImage.leadingAnchor.constraint(equalTo: leftCurtainsImage.trailingAnchor, constant: 84),
        
            secondCharacterImage.widthAnchor.constraint(equalTo: characterImage.widthAnchor),
            secondCharacterImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            secondCharacterImage.trailingAnchor.constraint(equalTo: rightCurtainsImage.leadingAnchor, constant: 84),
        ] + curtainsConstraints + charConstraints)
    }
    
    private func deactivateCurtainsConstraints() {
        NSLayoutConstraint.deactivate(curtainsConstraints)
    }
    
    
    // MARK:- Animation
    func startCharactersAnimation(char: StoryCharacter, duration: Int) {
        var index = 0
        
        if char == .second {
            index = 1
        }
        
        UIView.animate(withDuration: TimeInterval(duration), animations: {
            self.charConstraints[index].constant
//            let angle: CGFloat = menuIsOpen ? .pi / 4 : 0.0
//            menuButton.transform = CGAffineTransform(rotationAngle: angle)
        })
    }
    
    func startCurtainsAnimation() {
        if !isCurtainsClosed {
            deactivateCurtainsConstraints()
            initClosedCurtainsConstraints()
            animateCurtains()
            isCurtainsClosed = false
        }

        deactivateCurtainsConstraints()
        initOpenCurtainsConstraints()
        animateCurtains()
    }
    
    private func animateCurtains() {
        UIView.animate(withDuration: 1, animations: {
            NSLayoutConstraint.activate(self.curtainsConstraints)
            self.view.layoutIfNeeded()
        })
    }
}
