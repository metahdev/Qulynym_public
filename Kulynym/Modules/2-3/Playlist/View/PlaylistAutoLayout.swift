/*
* Kulynym
* PlaylistAutoLayout.swift
*
* Created by: Metah on 5/12/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol PlaylistAutoLayoutProtocol: class {
    var listTableView: UITableView { get set }
    var closeBtn: UIButton { get set }
    var titleLabel: UILabel { get set }
    
    func setupLayout()
}

class PlaylistAutoLayout: PlaylistAutoLayoutProtocol {
    // MARK:- Properties
    lazy var listTableView: UITableView = {
        let tv = UITableView()
        tv.register(PlaylistTableViewCell.self, forCellReuseIdentifier: "reuseID")
        return tv
    }()
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        return btn
    }()
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 50)
        lbl.textColor = UIColor(red: 97/255, green: 104/255, blue: 189/255, alpha: 1)
        return lbl
    }()
    private weak var view: UIView!
    private var innerViews = [UIView]()
    
    
    // MARK:- Initialization
    required init(view: UIView) {
        self.view = view
    }
    
    
    // MARK:- Layout
    func setupLayout() {
        addViewsToInnerViews()
        addInnerViewsToTheViewAndMaskFalse()
        activateConstraints()
    }
    
    private func addViewsToInnerViews() {
        innerViews.append(listTableView)
        innerViews.append(closeBtn)
        innerViews.append(titleLabel)
    }
    
    private func addInnerViewsToTheViewAndMaskFalse() {
        for innerView in innerViews {
            view.addSubview(innerView)
            innerView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func activateConstraints() {
        let constant = view.frame.height * 0.25
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            listTableView.topAnchor.constraint(equalTo: view.topAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            closeBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            closeBtn.widthAnchor.constraint(equalToConstant: constant + 24),
            closeBtn.heightAnchor.constraint(equalToConstant: constant),
        ])
    }
}
