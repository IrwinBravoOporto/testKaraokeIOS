//
//  ProfileRepositoryProtocol.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation

public protocol RepositoryProtocol {
}

public protocol ProfileRepositoryProtocol: RepositoryProtocol {
//   FavoriteService
    func getProfile(completion: @escaping (Result<[ProfileDetail], Error>) -> Void)
}
