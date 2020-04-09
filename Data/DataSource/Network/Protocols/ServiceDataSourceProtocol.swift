//
//  ServiceDataSourceProtocol.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation


internal protocol ServiceDataSource {
    
    func getProfileMusic(request: RequestObject,completion: @escaping (Swift.Result<[ProfileDetailEntity], Error>) -> Void)
    
        
}
