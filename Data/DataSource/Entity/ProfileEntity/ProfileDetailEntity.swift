//
//  ProfileEntity.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation



struct ProfileDetailEntity:Codable {
     var profile:ProfileEditEntity?
     var description:String?
     var record_video:String?
}
//MARK: - MAPPER

extension ProfileDetailEntity{
    
    static func mapperArray(profileDetail:[ProfileDetailEntity])->[ProfileDetail]{
        return profileDetail.map {
            ProfileDetail(profile: ProfileEditEntity.mapperArray(profile: $0.profile), description: $0.description, record_video: $0.record_video)
        }
    }
}
