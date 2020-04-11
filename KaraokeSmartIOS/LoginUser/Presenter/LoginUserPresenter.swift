//
//  LoginUserPresenter.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/10/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation

protocol LoginUserPresenterProtocol {
    func goToProfile()
    func goToSingUp()
}



class LoginUserPresenter {
    private weak var view:LoginUserViewControllerProtocol?
    private var router:LoginUserRouterProtocol
    
    
    init(view:LoginUserViewControllerProtocol, router:LoginUserRouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension LoginUserPresenter:LoginUserPresenterProtocol{
    func goToProfile() {
        router.routeToProfile()
    }
    
    func goToSingUp() {
        router.routeToSingUp()
    }
    
}
