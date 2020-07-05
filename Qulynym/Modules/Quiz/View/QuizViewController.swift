/*
 * Qulynym
 * QuizViewController.swift
 *
 * Created by: Metah on 7/31/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit


protocol QuizViewControllerProtocol: class {
    var categoryName: String { get set }
    var randomCard: String { get set }
    var cards: [String]! { get set }
    var areImagesTransparent: Bool! { get set }
    var closeBtnHasBeenPressed: Bool { get set }
    
    func returnCellState(_ cellIndex: Int)
    func changeViewsEnableState(enable: Bool)
    func changeSelectedCellOpacity(to number: Float)
    func shuffleCards()
}

class QuizViewController: UIViewController, QuizViewControllerProtocol {
    // MARK:- Properties
    var categoryName = "" {
        didSet {
            AudioPlayer.setupExtraAudio(with: categoryName + "Q", audioPlayer: .question)
        }
    }
    var randomCard = "" {
        didSet {
            AudioPlayer.setupExtraAudio(with: randomCard, audioPlayer: .content)
        }
    }
    var cards: [String]!
    var areImagesTransparent: Bool!

    var presenter: QuizPresenterProtocol!
    weak var itemView: ItemViewControllerProtocol!
    
    var selectedIndex: Int?

    var closeBtnHasBeenPressed = false
    private var cardsCollectionView: UICollectionView!
    private var closeBtn: UIButton!
    private var soundsBtn: UIButton!
    
    private var quizView: QuizViewProtocol!
    private var configurator: QuizConfiguratorProtocol = QuizConfigurator()
    

    // MARK:- Status Bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        initView()
        quizView.setupLayout()
        assignViews()
        setupCV()
        assignActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.setCards()
        presenter.getRandom()
        presenter.playAudio()
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
        self.closeBtnHasBeenPressed = true
        presenter.closeView()
    }
    
    @objc
    private func soundsBtnPressed() {
        presenter.playAudio()
    }
}

extension QuizViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK:- UICollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseID", for: indexPath) as! ImageCollectionViewCell
        cell.image = UIImage(named: cards[indexPath.row])
        if areImagesTransparent {
            cell.imageView.contentMode = .scaleAspectFit
        } else {
            cell.layer.borderWidth = 5
            cell.layer.borderColor = UIColor.white.cgColor
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        let indexOfRandCard = cards.firstIndex(of: randomCard)
        selectedIndex = indexPath.row
        
        self.changeSelectedCellOpacity(to: 0.5)
        
        changeViewsEnableState(enable: false)
        if selectedIndex == indexOfRandCard {
            cell.layer.borderColor = UIColor.green.cgColor
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                if !self.closeBtnHasBeenPressed {
                    AudioPlayer.setupExtraAudio(with: "wellDone", audioPlayer: .effects)
                    self.presenter.playAudio()
                    self.changeSelectedCellOpacity(to: 1.0)
                    self.presenter.deleteItem()
                }
            })
        } else {
            cell.layer.borderColor = UIColor.red.cgColor
            presenter.stopAudios()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                if !self.closeBtnHasBeenPressed {
                    AudioPlayer.setupExtraAudio(with: "tryAgain", audioPlayer: .effects)
                    while AudioPlayer.sfxAudioPlayer.isPlaying {}
                    self.changeSelectedCellOpacity(to: 1.0)
                    self.presenter.backToItemWithRepeat()
                }
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.3, height: view.frame.height * 0.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let rightLeftDistance = (view.frame.width - view.frame.width * 0.6) / 3
        let topBottomDistance = (view.frame.height - view.frame.height * 0.6) / 3
        return UIEdgeInsets(top: topBottomDistance, left: rightLeftDistance, bottom: topBottomDistance, right: rightLeftDistance)
    }
}

extension QuizViewController {
    // MARK:- Protocol Methods
    func returnCellState(_ cellIndex: Int) {
        let indexPath = IndexPath(item: cellIndex, section: 0)
        let cell = cardsCollectionView.cellForItem(at: indexPath)
        cell!.layer.borderColor = UIColor.white.cgColor
    }
    
    func changeViewsEnableState(enable: Bool) {
        for cell in cardsCollectionView.visibleCells {
            cell.isUserInteractionEnabled = enable
        }
        soundsBtn.isEnabled = enable
        closeBtn.isEnabled = enable
    }
    
    func changeSelectedCellOpacity(to number: Float) {
        let indexPath = IndexPath(row: selectedIndex!, section: 0)
        let cell = cardsCollectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell
        cell!.imageView.layer.opacity = number
    }
    
    func shuffleCards() {
//        for cell in cardsCollectionView.visibleCells {
//            cardsCollectionView.performBatchUpdates(nil)
//            UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromRight, animations: {
//                UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromRight, animations: {
                        self.cards = self.cards.shuffled()
                        self.cardsCollectionView.reloadData()
//                }, completion: nil)
//            }, completion: nil)
//        }
    }

}
