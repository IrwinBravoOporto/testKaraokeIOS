//
//  LoginUserConfigurator.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/10/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation

protocol LoginUserConfiguratorProtocol{
     func configure(viewController: LoginUserProfileViewController)
}

class LoginUserConfigurator: LoginUserConfiguratorProtocol {
    func configure(viewController: LoginUserProfileViewController) {
        viewController.presenter = LoginUserPresenter(view: viewController, router: LoginUserRouter(withView: viewController))
    }
    
    
}


