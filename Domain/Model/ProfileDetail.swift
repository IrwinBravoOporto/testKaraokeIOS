//
//  ProfileDetail.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation


public struct  ProfileDetail{
   
    public var profile:Profile?
    public var description:String?
    public var record_video:String?
    
    public init(profile:Profile?,description:String?,record_video:String?){
        self.profile = profile
        self.description = description
        self.record_video = record_video
    }
}


