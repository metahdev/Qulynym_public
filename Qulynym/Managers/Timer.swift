 /*
* Qulynym
* Timer.swift
*
* Created by: Metah on 5/10/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
 */

import Foundation

protocol TimerControllerDelegate: class {
    var duration: TimeInterval { get }
    
    func notifyOfMillisecondPassed()
    func notifyTimerEnded()
}

class TimerController {
    // MARK:- Properties
    var timer: Timer?
    var delegate: TimerControllerDelegate!
    
    var counter = 0.0
    var scrollTimepoint: Int?
    
    // MARK:- Timer
    func nullifyData() {
        timer?.invalidate()
        timer = nil
        counter = 0.0
    }
    
    func startTimer() {
        timer = Timer(timeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.checkState()
        }
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    @objc private func checkState() {
        counter += 0.1
        
        print(counter)
        delegate.notifyOfMillisecondPassed()
    }
    
    func timerEnded() {
        nullifyData()
        delegate.notifyTimerEnded()
    }
}
