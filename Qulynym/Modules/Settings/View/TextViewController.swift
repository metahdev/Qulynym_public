/*
 * Qulynym
 * InfoForParentsViewController.swift
 *
 * Created by: Baubek on 8/6/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol TextViewControllerProtocol: class {
    var content: NSAttributedString! { get set }
    var titleText: String! { get set }
}

class TextViewController: UIViewController, TextViewControllerProtocol {
    //MARK:- Properties
    var content: NSAttributedString!
    var titleText: String!
    
    private lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Gill Sans", size: view.frame.height * 0.15)
        lbl.textAlignment = .center
        return lbl
    }()
    private lazy var textView: UITextView = {
        var tv = UITextView()
        tv.backgroundColor = .clear
        tv.textAlignment = .center
        tv.isEditable = false
        tv.isScrollEnabled = true
        return tv
    }()
    private lazy var linksCV: UICollectionView = {
        let cv = configureImagesCollectionView(scroll: .horizontal, background: .clear)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()

    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        assignActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.attributedText = content
        titleLabel.text = titleText
    }
    
    
    // MARK:- Layout
    func setupLayout() {
        view.backgroundColor = .beigePink
        
        addSubviews()
        makeMaskFalse()
        closeBtn.configureCloseBtnFrame(view)
        activateConstraints()
    }

    
    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(textView)
        view.addSubview(closeBtn)
        view.addSubview(linksCV)
    }
    
    func makeMaskFalse() {
        for subview in view.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: closeBtn.topAnchor),
        
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            linksCV.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            linksCV.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 0.7),
            linksCV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            linksCV.widthAnchor.constraint(equalTo: linksCV.heightAnchor, multiplier: 2)
        ])
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
    }
    
    @objc
    private func closeBtnPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}


// MARK:- UICollectionView Protocols
extension TextViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Content.links.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseID", for: indexPath) as! ImageCollectionViewCell
        cell.image = UIImage(named: Content.links[indexPath.row].imageName)
        return cell
    }
}

extension TextViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = URL(string: Content.links[indexPath.row].link) else { return }
        UIApplication.shared.open(url)
    }
}


extension TextViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = collectionView.frame.width * 0.5 - 8
        return CGSize(width: side, height: side)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
