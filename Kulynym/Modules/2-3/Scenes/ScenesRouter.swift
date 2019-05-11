/*
* Kulynym
* ScenesRouter.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol ScenesRouterProtocol: class {
    func presentItemVC(category: String)
    func presentPlaylistVC(case: Playlist)
    func presentDrawing() 
}

class ScenesRouter: ScenesRouterProtocol {
    weak var view: ScenesViewController!
    
    required init(view: ScenesViewController) {
        self.view = view
    }
}

extension ScenesRouter {
    // MARK:- Protocol Methods
    func presentItemVC(category: String) {
        let itemView = ItemViewController()
        view.itemViewDelegate = itemView
        view.itemViewDelegate.category = category
        itemView.transitioningDelegate = view
        
        view.present(itemView, animated: true, completion: nil)
    }
    
    func presentPlaylistVC(case: Playlist) {
        
    }
    
    func presentDrawing() {
        
    }
}
