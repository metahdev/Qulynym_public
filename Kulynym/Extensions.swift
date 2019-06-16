/*
* Kulynym
* Extensions.swift
*
* Created by: Metah on 3/3/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

extension UIButton {
    func configureCloseBtnFrame(_ view: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25, constant: 24),
            self.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
        ])
    }
    
    func configureForwardBtnFrame(_ view: UIView) {
        NSLayoutConstraint.activate([
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25, constant: 40),
            self.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)
        ])
    }
}

extension UILabel {
    func setupContentLabel(size: CGFloat) {
        self.font = UIFont(name: "Arial Rounded MT Bold", size: size)
        self.textColor = UIColor(red: 97/255, green: 104/255, blue: 189/255, alpha: 1)
        self.textAlignment = .center
    }
}

extension UIImageView {
    func configureBackgroundImagePosition(_ view: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
