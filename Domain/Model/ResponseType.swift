//
//  ResponseType.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//
import Foundation

public enum SuccessResponseType: Int {
    case success                    = 0
    case clientDoesntExists         = 3
    case clientDoesntAccumulate     = 4
    case unknown                    = -1
}

public enum TokenResponseType: Int {
    case success                    = 0
    case wrongUsernamePasswordError = 1
    case maintenanceMode            = 2
    case updateApplication          = 3
    case missingMandatoryFields     = 4
    case serverError                = -1
    case databaseConnectionError    = -2
}

public enum ResponseType: String {
    // Internal errors
    case unknownError
    case networkError               = "-5"
    case technicalErrorThree        = "-3"
    case technicalErrorTwo          = "-2"
    case technicalErrorOne          = "-1"
    case missingMandatoryParameters = "1"
    case missingParameters          = "2"
    case clientDoesntExists         = "3"
    case clientDoesntAccumulate     = "4"
    case couponUnavailable          = "5"
    
    // Request errors
    case invalidUrl
    case paramEncodingFailed
    case multipartEncodingFailed
    
    // Client errors
    case unauthorized
    case notFound
    case badRequest
    case forbidden
    case notAcceptable
    case conflict
    
    // Response errors
    case responseValidationFailed
    case dataFileReadFailed
    case missingContentType
    case unacceptableContentType
    case unacceptableStatusCode
    case serializationFailed
    
    // Server errors
    case internalServerError
    case serviceUnavailable
    case badGateway
    case gatewayTimeout
    
    // Unknown error
    case unknown
    case custom
    case cancelled
    case customLoginOldUser         = "MBBK0044"
}
