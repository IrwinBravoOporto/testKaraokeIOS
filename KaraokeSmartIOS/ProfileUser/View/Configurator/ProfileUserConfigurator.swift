//
//  ProfileUserConfigurator.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation
import UIKit


protocol ProfileUserConfiguratorProtocol {
    func configure(viewController:ProfileUserViewController)
}
class ProfileUserConfigurator: ProfileUserConfiguratorProtocol {
    func configure(viewController: ProfileUserViewController) {
//        let interactorProfile
        
        viewController.presenter = ProfileUserPresenter(view: viewController, router: ProfileUserViewControllerRouter(withView: viewController), interactorProfileUser: ProfileInteractor(repository: ProfileRepository()), andData: viewController.viewData)
    }
}


