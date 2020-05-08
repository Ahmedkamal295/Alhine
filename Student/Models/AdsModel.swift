//
//  AdsModel.swift
//  Student
//
//  Created by MOHAB on 1/31/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import Foundation
import ObjectMapper

struct AdsModel : Mappable {
    var message : String?
    var ads : Ads?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        message <- map["message"]
        ads <- map["ads"]
    }
    
}

struct Ads : Mappable {
    var id : Int?
    var image : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        image <- map["image"]
    }
    
}
