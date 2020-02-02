/*
* Qulynym
* MenuInteractor .swift
*
* Created by: Metah on 6/12/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation
import Alamofire

#warning("delete this file")
protocol MenuInteractorProtocol: class {
}

class MenuInteractor: MenuInteractorProtocol {
    /// MARK:- Properties
    weak var presenter: MenuPresenterProtocol!
    
    required init(_ presenter: MenuPresenterProtocol) {
        self.presenter = presenter
    }
}

extension MenuInteractor {
    // MARK:- Protocol Methods
    
}
