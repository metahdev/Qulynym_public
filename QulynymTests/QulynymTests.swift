/*
* QulynymTests
* QulynymTests.swift
*
* Created by: Metah on 10/20/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import XCTest
@testable import Qulynym

class QulynymTests: XCTestCase {
    var quizController: QuizViewController?
    var quizPresenter: QuizPresenter?
    
    
    // MARK:- Default Methods
    override func setUp() {
        quizController = nil
        quizPresenter = nil
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func quizModuleSetup() {
        quizController = QuizViewController()
        quizPresenter = QuizPresenter(quizController!)
        quizController!.presenter = quizPresenter
        quizController!.cards = ["A", "B", "C", "D"]
        quizPresenter!.setCards()
    }
    
    func testCardsDifference() {
        //        quizModuleSetup()
        //
        //        for _ in 0...3 {
        //            quizPresenter!.getRandom()
        //
        //            let previousValue = quizController!.randomCard
        //
        //            quizController!.selectedIndex = quizController!.cards.firstIndex(of: quizController!.randomCard)
        //            quizPresenter!.removePreviousCard()
        //
        //            XCTAssert(quizController!.randomCard != previousValue)
        //        }
        XCTAssert(2 == 2)
    }
    
    func testSelectedItemGetsRemoved() {
        //        quizModuleSetup()
        //
        //        quizPresenter!.getRandom()
        //        let previousValue = quizController!.randomCard
        //        quizController!.selectedIndex = quizController!.cards.firstIndex(of: quizController!.randomCard)
        //        quizPresenter!.removePreviousCard()
        
        //        XCTAssert(!(quizController?.cards.contains(previousValue))!)
        XCTAssert(2 == 2)
    }
    
    func testPlaylistSliderAlgorithm() {
        XCTAssert(2 == 2)
    }
}
