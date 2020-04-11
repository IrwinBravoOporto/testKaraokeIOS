//
//  LoginUserPresenter.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/10/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation

protocol SingUpUserPresenterProtocol {
    func goToPreviousView()
    func goToProfileUser()
    func goToLoginUser()

}


class SingUpUserPresenter{
    private weak var view:SingUpUserViewControllerProtocol?
    private var router:SingUpUserRouterProtocol
    
    init(view:SingUpUserViewControllerProtocol, router:SingUpUserRouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension SingUpUserPresenter:SingUpUserPresenterProtocol{
    func goToPreviousView() {
        router.routeToPrevious()
    }
    func goToProfileUser() {
        router.routeToLoginUser()
    }
    
    func goToLoginUser() {
        router.routeToLoginUser()

    }
    
    
}
