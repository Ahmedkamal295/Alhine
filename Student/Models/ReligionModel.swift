//
//  ReligionModel.swift
//  Student
//
//  Created by MOHAB on 2/12/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import Foundation
import ObjectMapper

struct ReligionModel : Mappable {
    var message : String?
    var religion : [Religiondata]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        message <- map["message"]
        religion <- map["religion"]
    }
    
}
struct Religiondata : Mappable {
    var id : Int?
    var religion : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        religion <- map["religion"]
    }
    
}
