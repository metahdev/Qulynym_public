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
    var fontSize: CGFloat! {
        didSet {
            titleLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        }
    }
    var current: Bool = false {
        didSet {
            titleLabel.textColor = current ? UIColor(red: 0.153, green: 0.682, blue: 0.376, alpha: 1) : .darkGray
        }
    }
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.numberOfLines = 4
        lbl.textColor = .darkGray
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
    
    private func generalLayoutSetup() {
        self.backgroundColor = .clear
    }
    
    private func setupLyricsLabel() {
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        current = false
    }
}
