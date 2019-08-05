/*
* Kulynym
* MessageViewController.swift
*
* Created by: Metah on 6/6/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

class MessageViewController: UIViewController {
    // MARK:- Properties
    var charImageName: String! {
        didSet {
            emotionImage.image = UIImage(named: charImageName)
        }
    }
    var instruction: String! {
        didSet {
            firstImageView.image = UIImage(named: instruction + "First")
            secondImageView.image = UIImage(named: instruction + "Second")
        }
    }
    var audioName: String!
    var message: MessageManager!
    
    private weak var closeBtn: UIButton!
    private weak var emotionImage: UIImageView!
    private weak var firstImageView: UIImageView!
    private weak var secondImageView: UIImageView!
    private weak var titleLabel: UILabel!
    private var messageView: MessageViewProtocol!
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
        messageView.setupLayout()
        assignViews()
        assignActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AudioPlayer.setupExtraAudio(with: audioName, audioPlayer: .message)
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        messageView =  MessageView(view)
    }
    
    private func assignViews() {
        self.closeBtn = messageView.closeBtn
        self.emotionImage = messageView.emotionImage
        self.firstImageView = messageView.firstInstructionImage
        self.secondImageView = messageView.secondInstructionImage 
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
    }
    
    @objc func closeBtnPressed() {
        message.visualEffectView.removeFromSuperview()
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
        AudioPlayer.messageAudioPlayer.stop()
    }
}
