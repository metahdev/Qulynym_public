/*
* Qulynym
* MenuImageCollectionViewCell.swift
*
* Created by: Metah on 8/16/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

class MenuImageCollectionViewCell: ImageCollectionViewCell {
    // MARK:- Properties
    var text: String! {
        didSet {
            sectionTitleLabel.text = text
        }
    }
    private lazy var sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial Rounded MT Bold", size: self.frame.height * 0.2)
        label.textColor = UIColor(red: 97/255, green: 104/255, blue: 189/255, alpha: 1)
        label.shadowColor = .black
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    
    // MARK:- Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(sectionTitleLabel)
        activateLabelConstraints()
    }
    
    private func activateLabelConstraints() {
        NSLayoutConstraint.activate([
            sectionTitleLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 16),
            sectionTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sectionTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
