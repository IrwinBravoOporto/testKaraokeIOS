//
//  ProfileUserPresenterRouter.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileUserViewControllerRouterProtocol {
    func routerGoToProfileDetail()
    func routeToPreviousDestination()
}


class ProfileUserViewControllerRouter{
    weak var currentViewController:ProfileUserViewController?
    
    init(withView viewController:ProfileUserViewController) {
        self.currentViewController = viewController
    }
}

//MARK: PROTOCOL METHODS
extension ProfileUserViewControllerRouter:ProfileUserViewControllerRouterProtocol{
    func routerGoToProfileDetail() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewProfileDetail = storyboard.instantiateViewController(withIdentifier: "ProfileDetailEditViewController") as? ProfileDetailEditViewController, let view = currentViewController else {return}
        view.navigationController?.pushViewController(viewProfileDetail, animated: true)
    }
    func routeToPreviousDestination() {
        guard let viewRef = currentViewController else { return }
        viewRef.dismiss(animated: true, completion: nil)
    }
    
    
}
