/*
* Kulynym
* KaraokeRouter.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol KaraokeRouterProtocol: class {
    func close()
}

class KaraokeRouter: KaraokeRouterProtocol {
    // MARK:- Properties
    weak var view: KaraokeViewController!
    
    required init(view: KaraokeViewController) {
        self.view = view
    }
}

extension KaraokeRouter {
    func close() {
        view.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
