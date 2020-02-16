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
    
    func notifyOfSecondPassed()
    func notifyTimerEnded()
}

class TimerController {
    // MARK:- Properties
    var timer: Timer?
    var delegate: TimerControllerDelegate!
    
    var seconds = 0
    var scrollTimepoint: Int?
    
    // MARK:- Timer
    func nullifyData() {
        timer?.invalidate()
        timer = nil
        seconds = 0
    }
    
    #warning("bug with time: timeInterval should be less")
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkState), userInfo: nil, repeats: true)
    }
    
    @objc private func checkState() {
        seconds += 1
        
        delegate.notifyOfSecondPassed()
        
        if seconds == Int(delegate.duration) {
            timerEnded()
        }
    }
    
    func timerEnded() {
        nullifyData()
        delegate.notifyTimerEnded()
    }
}
