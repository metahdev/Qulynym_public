//
/*
* Kulynym
* KaraokeInteractor.swift
*
* Created by: Metah on 8/4/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol KaraokeInteractorProtocol: class {
    
}

class KaraokeInteractor: KaraokeInteractorProtocol {
    weak var presenter: KaraokePresenterProtocol!
    
    required init(_ presenter: KaraokePresenterProtocol) {
        self.presenter = presenter
    }
}
