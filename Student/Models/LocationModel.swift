//
//  LocationModel.swift
//  Student
//
//  Created by MOHAB on 2/3/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import Foundation
import ObjectMapper

struct LocationsModel : Mappable {
    var message : String?
    var residenceCountry : [ResidenceCountry]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        message <- map["message"]
        residenceCountry <- map["residenceCountry"]
    }
    
}
struct ResidenceCountry : Mappable {
    var id : Int?
    var country : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        country <- map["country"]
    }
    
}
