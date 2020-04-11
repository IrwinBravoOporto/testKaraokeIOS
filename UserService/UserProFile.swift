//
//  UserProFile.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/10/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation


class UserProFile{
    var username:String
    var photoUrl:URL
    
    init(username:String,photoUrl:URL) {
        self.username = username
        self.photoUrl = photoUrl
    }
}
