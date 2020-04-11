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
    func getProfiles()    
    func getNumberOfRow()->Int
    func getNameUser(from row: Int) -> String
    func getNameUserID(from row: Int) -> String
    func getImgUser(from row: Int) -> String
    func getDescription(from row: Int) -> String
    func getUrlMusic(from row: Int) -> String
    func dissMissProfile()
    func didTapProfileEdit()
}


class ProfileUserPresenter {
    private weak var view:ProfileUserViewControllerProtocol?
    private var router:ProfileUserViewControllerRouterProtocol
    private var interactorProfileUser:ProfileInteractorProtocol
    private var profileListData : [ProfileDetail]?
    private var viewData:ViewData?
    init(view:ProfileUserViewControllerProtocol,router:ProfileUserViewControllerRouterProtocol,interactorProfileUser:ProfileInteractorProtocol,andData viewData:ViewData?) {
        self.view = view
        self.router = router
        self.viewData = viewData
        self.interactorProfileUser = interactorProfileUser
    }
}

extension ProfileUserPresenter:ProfileUserPresenterProtocol{
    func dissMissProfile() {
        router.routeToPreviousDestination()
    }
    
   
    func getProfiles() {
        self.view?.startLoading()
        self.view?.hideErrorView()
        self.profileListData = []
        interactorProfileUser.getProfilePlayMusic(){[weak self] result in
            guard let self = self else {return print("Not self")
            }
            self.view?.finishLoading()
            switch result {
            case .success(let profile):
                if profile.count > 0 {
                    self.profileListData = profile
                    self.view?.loadContent()
                    print(profile)
                    
                }else{
                    self.view?.failedContentShowPlaceHolder(type: .profile)
                }
            case .failure(let error):
                self.view?.failedContentShowPlaceHolder(type: .profile)
                print(error)
                return
            }
            self.view?.reloadData()
        }
        view?.reloadData()
    }
   
    
    func getNumberOfRow() -> Int {
        guard let sections = profileListData else {return 0}
        return sections.count
    }
    
    func getProfile(from row:Int)->ProfileDetail?{
        guard let sections = profileListData  else {return nil }
        return sections[row]
    }
    
    func getNameUser(from row: Int) -> String {
        guard let nameUser = getProfile(from: row) else {return ""}
        return nameUser.profile?.name ?? ""
    }
    func getNameUserID(from row: Int) -> String {
              guard let nameUser = getProfile(from: row) else {return ""}
        return nameUser.profile?.user_name ?? ""
          }
          
    func getImgUser(from row: Int) -> String {
        guard let imgUser = getProfile(from: row) else {return ""}
        return imgUser.profile?.img ?? ""
    }
    func getDescription(from row: Int) -> String {
        guard let descriptionUser = getProfile(from: row) else {return ""}
        return descriptionUser.description ?? ""
    }
    
    func getUrlMusic(from row: Int) -> String {
        guard let urlMusic = getProfile(from: row) else {return ""}
        return urlMusic.record_video ?? ""
    }
    
    func didTapProfileEdit() {
        router.routerGoToProfileDetail()
        
    }
}



