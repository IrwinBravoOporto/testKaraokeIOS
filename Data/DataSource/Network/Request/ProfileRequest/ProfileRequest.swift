//
//  ProfileRequest.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation
import Alamofire

var headerAuth = ["Content-Type; charset=UTF-8"  : "application/json","Accept":"application/json"]

internal struct ProfileRequest:RequestObject{
    var path: String = "http://www.mocky.io/v2/5e3a01073200006700ddfe05"
    let method: HTTPMethod = .get
    var headers: HTTPHeaders
    let encoding: JSONEncoding = .default
    var parameters: Parameters = [:]
    
    init() {
        headers = headerAuth
//        headers["Authorization"] = AuthToken.getAccessToken()
//        headers["Refresh-token"] = AuthToken.getRefreshToken()
    }
}



