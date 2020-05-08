//
//  JobsnameModel.swift
//  Student
//
//  Created by MOHAB on 2/3/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import Foundation
import ObjectMapper

struct jobsNameModel : Mappable {
    var message : String?
    var jobsName : [JobsName]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        message <- map["message"]
        jobsName <- map["jobsName"]
    }
    
}
struct JobsName : Mappable {
    var id : Int?
    var name : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
    }
    
}
