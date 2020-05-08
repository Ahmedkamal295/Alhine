//
//  NationalityModel.swift
//  Student
//
//  Created by MOHAB on 2/12/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import Foundation
import ObjectMapper

struct nationalityModel : Mappable {
    var message : String?
    var nationality : [NationalityData]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        message <- map["message"]
        nationality <- map["nationality"]
    }
    
}
struct NationalityData : Mappable {
    var id : Int?
    var nationality : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        nationality <- map["nationality"]
    }
    
}
