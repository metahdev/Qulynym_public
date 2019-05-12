//
/*
* Kulynym
* PlaylistTableViewCell.swift
*
* Created by: Metah on 5/12/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

class PlaylistTableViewCell: UITableViewCell {
    // MARK:- Properties
    var imageName: String! {
        didSet {
            mainImageView.image = UIImage(named: imageName)
        }
    }
    lazy var mainImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    
    // MARK:- View Lifecycle
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(mainImageView)
        setImageViewMaskAndMode()
        setupConstraints()
    }
    
    
    // MARK:- Layout
    private func setImageViewMaskAndMode() {
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: self.topAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
