//
//  VerificationModel.swift
//  Student
//
//  Created by MOHAB on 1/31/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//


import Foundation
import ObjectMapper

struct VerificationModel : Mappable {
    var message : String?
    var tmpApiToken : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        message <- map["message"]
        tmpApiToken <- map["tmpApiToken"]
    }
    
}
