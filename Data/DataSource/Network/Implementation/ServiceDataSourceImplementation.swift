//
//  ServiceDataSourceImplementation.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation
import Alamofire


class ServiceDataSourceImplementation:ServiceDataSource{
    
    private var sessionManager: SessionManager?
    
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadRevalidatingCacheData
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 20
        let serverTrustPolicies: [String: ServerTrustPolicy] = [:]
        
        let configurationForlog = TimberjackHelper.defaultSessionConfiguration()
        configurationForlog.requestCachePolicy = .reloadRevalidatingCacheData
        configurationForlog.timeoutIntervalForRequest = 20
        configurationForlog.timeoutIntervalForResource = 20
        self.sessionManager = Alamofire.SessionManager(configuration: configuration, serverTrustPolicyManager:  ServerTrustPolicyManager(policies: serverTrustPolicies))
    }
    
    func getProfileMusic(request: RequestObject, completion: @escaping (Swift.Result<[ProfileDetailEntity], Error>) -> Void) {
        guard let requestRef = request as? ProfileRequest else{return}
        if Reachability.isConnectedToNetwork() {
            sessionManager?.session.getAllTasks{ (tasks) in
                print("TASKS",tasks)
                tasks.forEach({$0.cancel()})
            }
        sessionManager?.request("http://www.mocky.io/v2/5e3a01073200006700ddfe05", method: requestRef.method, parameters: nil, encoding: requestRef.encoding, headers: requestRef.headers).validate().responseData(completionHandler: { (response) in
                        
                        let resstr = NSString(data: response.data ?? Data(), encoding: String.Encoding.utf8.rawValue)
                        debugPrint(resstr!)
                        switch response.result {
                        case .success(let data):
                            guard let dataResponse = try? JSONDecoder().decode( [ProfileDetailEntity].self, from: data) else { return completion(.failure(ServiceErrorHandler.get(code: nil, description: nil))) }
                            completion(.success(dataResponse))
                        case .failure(let error):
                            print("NONE",error)
                        }
                    })
                    
                }else{
                    completion(.failure(ServiceErrorHandler.getNetworkError()))
                }
            }
}
