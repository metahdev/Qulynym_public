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
    var forwardTimepoints: [Int: Int]! { get }
    var rewindTimepoints: [Int: Int]! { get }
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
    var scrollTimepoint: Int?
    
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
        
        if delegate.forwardTimepoints[seconds] != nil {
            scrollTimepoint = seconds
            delegate.notifyOfTimepoints()
            self.scrollTimepoint = nil
        }
        
        if seconds == Int(delegate.duration) {
            timerEnded()
        }
    }
    
    func timerEnded() {
        nullifyData()
        delegate.notifyTimerEnded()
    }
    
    func checkForScroll(rewind: Bool) {
        let timepointsArray: [Int]!
        
        if rewind {
            timepointsArray = Array(delegate.forwardTimepoints.keys)
        } else {
            timepointsArray = Array(delegate.rewindTimepoints.keys)
        }
        
        if rewind {
            checkForForwardScroll(timepointsArray)
        } else {
            checkForRewindScroll(timepointsArray)
        }
        
        if scrollTimepoint != nil {
            delegate.notifyOfTimepoints()
        }
        
        scrollTimepoint = nil
    }
    
    func checkForForwardScroll(_ arr: [Int]) {
        for timepoint in arr {
            if seconds > timepoint {
                self.scrollTimepoint = timepoint
            } else {
                break
            }
        }
    }
    
    func checkForRewindScroll(_ arr: [Int]) {
        for timepoint in arr {
            if seconds < timepoint {
                self.scrollTimepoint = timepoint
            } else {
                break
            }
        }
    }
}
