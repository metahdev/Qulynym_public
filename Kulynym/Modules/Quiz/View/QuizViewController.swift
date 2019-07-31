/*
* Kulynym
* QuizViewController.swift
*
* Created by: Metah on 7/31/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol QuizViewControllerProtocol: class {
    var slideCount: Int { get set }
    var randomCard: String { get set }
    var cards: [String] { get set }
}

class QuizViewController: UIViewController, QuizViewControllerProtocol {
    // MARK:- Properties
    var slideCount = 0
    var randomCard = ""
    var cards = [String]()
    
    var presenter: QuizPresenterProtocol!
    
    private var cardsCollectionView: UICollectionView!
    private var closeBtn: UIButton!
    private var soundsBtn: UIButton!
    
    private var quizView: QuizViewProtocol!
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        assignViews()
        setupCV()
        assignActions()
        presenter.getRandom()
    }
    
    
    // MARK:- Layout
    private func initView() {
        quizView = QuizView(view)
    }
    
    private func assignViews() {
        self.cardsCollectionView = quizView.cardsCollectionView
        self.closeBtn = quizView.closeBtn
        self.soundsBtn = quizView.soundsButton
    }
    
    private func setupCV() {
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
        soundsBtn.addTarget(self, action: #selector(soundsBtnPressed), for: .touchUpInside)
    }
    
    @objc
    private func closeBtnPressed() {
        presenter.closeView()
    }
    
    @objc
    private func soundsBtnPressed() {
        presenter.closeView()
    }
}

extension QuizViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseID", for: indexPath) as! ImageCollectionViewCell
        cell.imageName = cards[indexPath.row]
        
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 5
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseID", for: indexPath)
        let indexOfRandCard = cards.firstIndex(of: randomCard)
        if indexPath.row == indexOfRandCard {
            cell.layer.borderColor = UIColor.green.cgColor
            presenter.deleteItem(at: indexOfRandCard)
        } else {
            presenter.backToItemWithRepeat()
        }
    }
}
