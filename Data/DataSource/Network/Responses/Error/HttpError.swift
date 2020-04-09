//
//  HttpError.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation

struct HttpError: Error {
    var type: HttpErrorType
    var reason: String
}

extension HttpError {
    
    static func get(_ error: Error) -> ErrorResponse {
        guard let httpError = error as? HttpError else {
            return ErrorResponse(type: .unknown, description: "Parsing Error")
        }
        return ErrorResponse(type: ResponseType(rawValue: httpError.type.rawValue) , description: httpError.reason)
    }
    
}
