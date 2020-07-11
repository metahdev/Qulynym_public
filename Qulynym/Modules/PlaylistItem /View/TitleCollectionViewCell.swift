//
/*
* Qulynym
* TitleCollectionViewCell.swift
*
* Created by: Баубек on 7/12/20
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.numberOfLines = 4
        return lbl
    }()
    
    // MARK: - View lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    func setupLayout() {
        generalLayoutSetup()
        setupLyricsLabel()
    }
    func generalLayoutSetup() {
        self.backgroundColor = .clear
    }
    func setupLyricsLabel() {
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
