//
//  CvModel.swift
//  Student
//
//  Created by MOHAB on 2/12/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import Foundation


import Foundation
import ObjectMapper

struct CvModel : Mappable {
    var message : String?
    var cv : [Cv]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        message <- map["message"]
        cv <- map["cv"]
    }
    
}

struct Cv : Mappable {
    var id : Int?
    var job_title : String?
    var employeeName : String?
    var photo : String?
    var rate : Int?
    var expectedSalary : String?
    var total_experience : String?
    var isFav : Bool?
    var review : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        job_title <- map["job_title"]
        employeeName <- map["employeeName"]
        photo <- map["photo"]
        rate <- map["rate"]
        expectedSalary <- map["expectedSalary"]
        total_experience <- map["total_experience"]
        isFav <- map["isFav"]
        review <- map["review"]
    }
    
}
