//
//  LoginUserRouter.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/10/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation
import UIKit
protocol SingUpUserRouterProtocol {
    func routeToPrevious()
    func routeToProfileUser()
    func routeToLoginUser()
}

class SingUpUserRouter {
    weak var  currentViewController:SingUpUserViewController?
    init(withView viewController:SingUpUserViewController) {
        self.currentViewController = viewController
    }
}

extension SingUpUserRouter:SingUpUserRouterProtocol{
    func routeToProfileUser() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewProfile = storyboard.instantiateViewController(withIdentifier: "ProfileUserViewController") as? ProfileUserViewController, let view = currentViewController else {return}
        view.navigationController?.pushViewController(viewProfile, animated: true)
    }
    func routeToPrevious() {
        guard let view = self.currentViewController else { return }
        view.navigationController?.popViewController(animated: true)
    }
    
    func routeToLoginUser() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewProfile = storyboard.instantiateViewController(withIdentifier: "LoginUserViewController") as? LoginUserProfileViewController, let view = currentViewController else {return}
        view.navigationController?.pushViewController(viewProfile, animated: true)
    }
    
    
}
