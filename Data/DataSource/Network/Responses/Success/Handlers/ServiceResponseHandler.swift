//
//  ServiceResponseHandler.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation

enum ServiceResponseCode: String {
    case success                   = "JA0000"
    case success1                 = "000000"
    case databaseTimeoutError      = "-1"
    case entityMappingError        = "-2"
    case internalError             = "-3"
    case databaseAvailabilityError = "-4"
}
