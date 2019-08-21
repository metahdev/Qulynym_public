//
/*
* Kulynym
* Timer.swift
*
* Created by: Metah on 5/10/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol TimerControllerDelegate: class {
    var timepoints: [Int: Int]! { get }
    var duration: TimeInterval { get }
    
    func notifyOfSecondPassed()
    func notifyOfTimepoints()
    func notifyTimerEnded()
}

class TimerController {
    // MARK:- Properties
    var timer: Timer?
    var delegate: TimerControllerDelegate!
    
    var seconds = 0
    var timepoint: Int?
    
    // MARK:- Timer
    func nullifyData() {
        timer?.invalidate()
        timer = nil
        seconds = 0 
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkState), userInfo: nil, repeats: true)
    }
    
    @objc private func checkState() {
        seconds += 1
        
        delegate.notifyOfSecondPassed()
        
        if delegate.timepoints[seconds] != nil {
            delegate.notifyOfTimepoints()
        }
        
        if seconds == Int(delegate.duration) {
            timerEnded()
        }
    }
    
    func timerEnded() {
        nullifyData()
        delegate.notifyTimerEnded()
    }
    
    func checkForForwardScroll() {
        var lastTimepoint: Int?
        
        for timepoint in Array(delegate.timepoints.keys) {
            if seconds > timepoint {
                lastTimepoint = timepoint
            } else {
                break
            }
        }
        
        if let timepoint = lastTimepoint {
            self.timepoint = timepoint
            delegate.notifyOfTimepoints()
        }
    }
    
    func checkForRewindScroll() {
        var lastTimepoint: Int?
        
        for timepoint in Array(delegate.timepoints.keys) {
            if seconds < timepoint {
                lastTimepoint = timepoint
            } else {
                continue
            }
        }
        
        if let timepoint = lastTimepoint {
            self.timepoint = timepoint
            delegate.notifyOfTimepoints()
        }
    }
}
