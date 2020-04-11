//
//  ProfileDetailEditPresenter.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/9/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation


protocol ProfileDetailEditPresenterProtocol {
    func goToPreviousView()
    func goToShareView()
}



class ProfileDetailEditPresenter {
    private weak var view:ProfileDetailEditViewControllerProtocol?
    private var router:ProfileDetailEditRouterProtocol
    private var viewData: ViewData?
    
    init(view:ProfileDetailEditViewControllerProtocol, router:ProfileDetailEditRouterProtocol,andData viewData:ViewData?) {
        self.view = view
        self.router = router
        self.viewData = viewData
    }
}


extension ProfileDetailEditPresenter:ProfileDetailEditPresenterProtocol{
    func goToShareView() {
        router.routeToShareUser()
    }
    
    func goToPreviousView() {
        router.routeToPrevious()
    }
    
    
    
}
