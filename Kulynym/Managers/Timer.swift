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

protocol TimerManagerDelegate: class {
    var timepoints: [Int] { get set }
    
    func notifyOfTimepoints()
    func notifyTimerEnded()
}

class TimerManager {
    // MARK:- Properties
    var currentSlide = 1
    var timer = Timer()
    var delegate: TimerManagerDelegate!
    private var seconds = 0.0
    
    
    // MARK:- Timer
    func startTimer() {
        seconds = AudioPlayer.scenesAudioPlayer.duration
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkState), userInfo: nil, repeats: true)
    }
    
    @objc private func checkState() {
        seconds -= 1
        
        for timepoint in delegate.timepoints {
            switch Int(seconds) {
            case timepoint:
                delegate.notifyOfTimepoints()
                currentSlide += 1
            default:
                break
            }
        }
        
        if Int(seconds) == 0 {
            timer.invalidate()
            delegate.notifyTimerEnded()
        }
    }
}
