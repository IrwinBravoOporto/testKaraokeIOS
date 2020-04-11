//
//  ProfileDetailEditRouter.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/9/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation


protocol ProfileDetailEditRouterProtocol {
    func routeToPrevious()
    func routeToShareUser()
    
}


class ProfileDetailEditRouter {
    weak var  currentViewController:ProfileDetailEditViewController?
    init(withView viewController:ProfileDetailEditViewController) {
        self.currentViewController = viewController
    }
}

extension ProfileDetailEditRouter:ProfileDetailEditRouterProtocol{
    func routeToShareUser() {
        guard let view = self.currentViewController else { return }
            view.navigationController?.popViewController(animated: true)
    }
    
    func routeToPrevious() {
        guard let view = self.currentViewController else { return }
        view.navigationController?.popViewController(animated: true)
    }
}
