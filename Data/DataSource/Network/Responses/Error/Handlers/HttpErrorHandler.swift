//
//  HttpErrorHandler.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//
import Foundation
import Alamofire

enum HttpErrorType: String {
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
    case notImplemented
    case serviceUnavailable
    case badGateway
    case gatewayTimeout
    
    // Unknown error
    case unknown
    case cancelled
}

class HttpErrorHandler {
    
    static func get(_ error: Error) -> Error {
        guard let errorResponse = error as? AFError else {
            if (error as NSError).code == NSURLErrorCancelled {
                return HttpError(type: .cancelled, reason: "")
            }else{
               return HttpError(type: .unknown, reason: "")
         }
        }
        switch errorResponse {
        case .invalidURL(let url):
            return HttpError(type: .invalidUrl, reason: "\(url), Reason: \(errorResponse.localizedDescription)")
        case .parameterEncodingFailed(let reason):
            return HttpError(type: .paramEncodingFailed, reason: "\(errorResponse.localizedDescription), Reason: \(reason)")
        case .multipartEncodingFailed(let reason):
            return HttpError(type: .multipartEncodingFailed, reason: "\(errorResponse.localizedDescription), Reason: \(reason)")
        case .responseValidationFailed(let reason):
            switch reason {
            case .dataFileNil, .dataFileReadFailed:
                return HttpError(type: .dataFileReadFailed, reason: "Downloaded file could not be read")
            case .missingContentType(let acceptableContentTypes):
                return HttpError(type: .missingContentType, reason: "Content Type Missing: \(acceptableContentTypes)")
            case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                return HttpError(type: .unacceptableContentType, reason: "Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
            case .unacceptableStatusCode(let code):
                print("unacceptableStatusCode",code)
                switch code {
                // Client errors
                case 400:
                    return HttpError(type: .badRequest, reason: "\(code) - Bad Request")
                case 401:
                    return HttpError(type: .unauthorized, reason: "\(code) - Unauthorized")
                case 403:
                    return HttpError(type: .forbidden, reason: "\(code) - Forbidden")
                case 404:
                    return HttpError(type: .notFound, reason: "\(code) - Not Found")
                case 406:
                    return HttpError(type: .notAcceptable, reason: "\(code) - Not Acceptable")
                case 409:
                    return HttpError(type: .conflict, reason: "\(code) - Conflict")
                // Server errors
                case 500:
                    return HttpError(type: .internalServerError, reason: "\(code) - Internal Server Error")
                case 501:
                    return HttpError(type: .notImplemented, reason: "\(code) - Not implemented")
                case 502:
                    return HttpError(type: .badGateway, reason: "\(code) - Bad Gateway")
                case 503:
                    return HttpError(type: .serviceUnavailable, reason: "\(code) - Service Unavailable")
                case 504:
                    return HttpError(type: .gatewayTimeout, reason: "\(code) - Gateway Timeout")
                default:
                    return HttpError(type: .unknown, reason: "\(code) - Unknown Error")
                }
            }
        case .responseSerializationFailed(let reason):
            return HttpError(type: .serializationFailed, reason: "\(errorResponse.localizedDescription) Reason: \(reason)")
        }
    }
    
}


