/*
* Kulynym
* QuizPresenter.swift
*
* Created by: Metah on 7/31/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol QuizPresenterProtocol: class {
    func getCards()
    func getRandom()
    func deleteItem(at index: Int)
    func closeView()
    func backToItem()
}

class QuizPresenter: QuizPresenterProtocol {
    // MARK:- Properites
    weak var view: QuizViewControllerProtocol!
    var interactor: QuizInteractorProtocol!
    var router: QuizRouterProtocol!
    private var modifiedCards = [String]()
    
    
    // MARK:- Initialization
    required init(_ view: QuizViewControllerProtocol) {
        self.view = view
    }
}

extension QuizPresenter {
    // MARK:- Protocol Methods
    func getCards() {
        view.cards = interactor.getCards(at: view.slideCount)
        modifiedCards = view.cards
    }
    
    func getRandom() {
        view.randomCard = modifiedCards[Int.random(in: 0...modifiedCards.count)]
    }
    
    func deleteItem(at index: Int) {
        if modifiedCards.count == 0 {
            router.backToItem(slide: view.slideCount + 1)
            return
        }
        modifiedCards.remove(at: index)
    }
    
    func closeView() {
        router.close() 
    }
    
    func backToItemWithRepeat() {
        router.backToItem(slide: view.slideCount - 4)
    }
}
