//
//  ProfileUserPresenter.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileUserPresenterProtocol{
    func getProfile()
    func getNameUserProfile(from row: Int) -> String
    func getImgUserProfile(from row: Int) -> String
    func getNameUserIDProfile(from row: Int) -> String
    
    func getNameUser(from row: Int) -> String
    func getImgUser(from row: Int) -> String
    func getDescription(from row: Int) -> String
    func getUrlMusic(from row: Int) -> String
    func didTapProfileEdit()
}


class ProfileUserPresenter {
    private weak var view:ProfileUserViewControllerProtocol?
    private var router:ProfileUserViewControllerRouterProtocol
    private var interactorProfileUser:ProfileInteractorProtocol
    private var profileList:[ProfileDetail] = []
    private var viewData:ViewData?
    init(view:ProfileUserViewControllerProtocol,router:ProfileUserViewControllerRouterProtocol,interactorProfileUser:ProfileInteractorProtocol,andData viewData:ViewData?) {
        self.view = view
        self.router = router
        self.viewData = viewData
        self.interactorProfileUser = interactorProfileUser
    }
}

extension ProfileUserPresenter:ProfileUserPresenterProtocol{
    
    
    func getProfile() {
        self.view?.startLoading()
        self.view?.hideErrorView()
        profileList = []
        view?.reloadData()
        interactorProfileUser.getProfilePlayMusic(){[weak self] result in
            self?.view?.finishLoading()
            switch result {
            case .success(let profile):
                if profile.count > 0 {
                    self?.view?.loadContent()
                    print(profile)
                }
                
            case .failure(let error):
                self?.view?.failedContentShowPlaceHolder(type: .profile)
                print(error)
                return
            }
        }
        
    }
    
    func getNameUserProfile(from row: Int) -> String {
        guard let nameUser = profileList[0].profile?.name else {return ""}
        return nameUser
    }
    func getNameUserIDProfile(from row: Int) -> String {
        guard let nameId = profileList[0].profile?.user_name else {return ""}
        return nameId
    }
    
    func getImgUserProfile(from row: Int) -> String {
        guard let imgUser = profileList[0].profile?.img else {return ""}
        return imgUser
    }
    
    
    func getNameUser(from row: Int) -> String {
        guard let nameUser = profileList[row].profile?.name else {return ""}
        return nameUser
    }
    func getImgUser(from row: Int) -> String {
        guard let imgUser = profileList[row].profile?.img else {return ""}
        return imgUser
    }
    func getDescription(from row: Int) -> String {
        guard let description = profileList[row].description else {return ""}
        return description
    }
    
    func getUrlMusic(from row: Int) -> String {
        guard let urlMusic = profileList[row].record_video else {return ""}
        return urlMusic
    }
    
    func didTapProfileEdit() {
        router.routerGoToProfileDetail()
        
    }
}



