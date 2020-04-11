//
//  LoginUserRouter.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/10/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation
import UIKit

protocol LoginUserRouterProtocol {
    func routeToProfile()
    func routeToSingUp()

}

class LoginUserRouter{
    weak var  currentViewController:LoginUserProfileViewController?
    init(withView viewController:LoginUserProfileViewController) {
        self.currentViewController = viewController
    }
}

extension LoginUserRouter:LoginUserRouterProtocol{
    func routeToSingUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewProfile = storyboard.instantiateViewController(withIdentifier: "SingUpUserViewController") as? SingUpUserViewController, let view = currentViewController else {return}
        view.navigationController?.pushViewController(viewProfile, animated: true)
    }
    
   
    func routeToProfile() {
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
              
              guard let viewProfile = storyboard.instantiateViewController(withIdentifier: "ProfileUserViewController") as? ProfileUserViewController, let view = currentViewController else {return}
              view.navigationController?.pushViewController(viewProfile, animated: true)
    }
    
    
}
