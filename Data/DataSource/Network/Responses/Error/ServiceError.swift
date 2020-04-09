//
//  ServiceError.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation

struct ServiceError: Error {
    var type: ServiceErrorType
    var reason: String
}

extension ServiceError {
    
    static func get(_ error: Error) -> ErrorResponse {
        guard let serviceError = error as? ServiceError else {
            return ErrorResponse(type: .unknown, description: NSLocalizedString("defaultError", comment: "defaultError"))
        }
        return ErrorResponse(type: ResponseType(rawValue: serviceError.type.rawValue), description: serviceError.reason)
    }
    
}
