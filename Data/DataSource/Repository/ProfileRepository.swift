//
//  ProfileRepository.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation


public class ProfileRepository: ProfileRepositoryProtocol {
    
    
    
    private let dataSource: ServiceDataSource
    public init() {
        self.dataSource = ServiceDataSourceImplementation()
    }
    
    public func getProfile(completion: @escaping (Result<[ProfileDetail], Error>) -> Void) {
        self.dataSource.getProfileMusic(request: ProfileRequest()) { result in
            switch result {
            case .success(let profile):
                completion(.success(ProfileDetailEntity.mapperArray(profileDetail: profile)))
            case .failure(let error):
                if error is HttpError {
                    completion(.failure(HttpError.get(error)))
                }else {
                    completion(.failure(ServiceError.get(error)))
                }
            }
        }
    }
    
}


