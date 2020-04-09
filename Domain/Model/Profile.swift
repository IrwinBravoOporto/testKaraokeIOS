//
//  Profile.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation

public struct Profile{
    public var img:String?
    public var name:String?
    public var user_name:String?
//    public var biografi:String
    
    public init(img:String?,name:String?,user_name:String?){
        self.img = img
        self.name = name
        self.user_name = user_name
    }
}
