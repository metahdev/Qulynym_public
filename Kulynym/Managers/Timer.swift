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
    var timepoints: [Int] { get set }
    
    func notifyOfTimepoints()
    func notifyTimerEnded()
}

class TimerController {
    // MARK:- Properties
    var currentSlide = 1
    var timer = Timer()
    var delegate: TimerControllerDelegate!
    
    var seconds = 0.0
    
    
    // MARK:- Timer
    func startTimer() {
        seconds = AudioPlayer.scenesAudioPlayer.duration
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkState), userInfo: nil, repeats: true)
    }
    
    @objc private func checkState() {
        seconds -= 1
        
        for timepoint in delegate.timepoints {
            if Int(seconds) == timepoint {
                delegate.notifyOfTimepoints()
                currentSlide += 1
            }
        }
        
        if Int(seconds) == 0 {
            timer.invalidate()
            delegate.notifyTimerEnded()
        }
    }
}
