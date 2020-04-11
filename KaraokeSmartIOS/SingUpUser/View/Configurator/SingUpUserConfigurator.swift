//
//  LoginUserConfigurator.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/10/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation


protocol SingUpUserConfiguratorProtocol{
     func configure(viewController: SingUpUserViewController)
}

class SingUpUserConfigurator: SingUpUserConfiguratorProtocol {
    func configure(viewController: SingUpUserViewController) {
        viewController.presenter = SingUpUserPresenter(view: viewController, router: SingUpUserRouter(withView: viewController))
    }
    
    
}
