//
//  ProfileEditEntity.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation



struct ProfileEditEntity:Codable {
     var img:String?
     var name:String?
     var user_name:String?
//    public var biografi:String
}


//MARK: - MAPPER

extension ProfileEditEntity {
    static func mapperArray(profile:ProfileEditEntity?)->Profile?{
        return Profile(img: profile?.img, name: profile?.name, user_name: profile?.user_name)
        
        
        
    }
}
