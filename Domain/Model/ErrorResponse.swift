//
//  ErrorResponse.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation

public class ErrorResponse: Error {
    
    public var type: ResponseType?
    public var description: String?
    
    public init(type: ResponseType?, description: String?) {
        self.type = type
        self.description = description
    }
}
