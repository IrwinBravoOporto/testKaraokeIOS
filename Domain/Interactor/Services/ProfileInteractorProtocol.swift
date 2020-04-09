//
//  ProfileInteractorProtocol.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation


protocol ProfileInteractorProtocol {
     func getProfilePlayMusic(completion: @escaping (Result<[ProfileDetail], Error>) -> Void)
}


public class ProfileInteractor:Interactor,ProfileInteractorProtocol{
    func getProfilePlayMusic(completion: @escaping (Result<[ProfileDetail], Error>) -> Void) {
        return (self.repository as! ProfileRepositoryProtocol).getProfile(completion: completion)
    }
}

