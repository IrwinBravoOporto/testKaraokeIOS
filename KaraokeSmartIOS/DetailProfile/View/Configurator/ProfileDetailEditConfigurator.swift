//
//  ProfileDetailEditConfigurator.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/9/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation


protocol ProfileDetailEditConfiguratorProtocol{
     func configure(viewController: ProfileDetailEditViewController)
}

class ProfileDetailEditConfigurator: ProfileDetailEditConfiguratorProtocol {
    func configure(viewController: ProfileDetailEditViewController) {
        viewController.presenter = ProfileDetailEditPresenter(view: viewController, router: ProfileDetailEditRouter(withView: viewController), andData: viewController.viewData) 
    }
    
    
}
