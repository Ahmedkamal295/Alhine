//
//  JobAppliedModel.swift
//  Student
//
//  Created by MOHAB on 2/12/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import Foundation
import ObjectMapper

struct jobAppliedModel : Mappable {
    var message : String?
    var appley : [Appley]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        message <- map["message"]
        appley <- map["appley"]
    }
    
}
struct Appley : Mappable {
    var id : Int?
    var job : Job?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        job <- map["job"]
    }
    
}
struct Job : Mappable {
    var id : Int?
    var job_title : String?
    var companyName : String?
    var image : String?
    var rate : Int?
    var isFav : Bool?
    var review : String?
    var salary : String?
    var total_experience : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        job_title <- map["job_title"]
        companyName <- map["companyName"]
        image <- map["image"]
        rate <- map["rate"]
        isFav <- map["isFav"]
        review <- map["review"]
        salary <- map["salary"]
        total_experience <- map["total_experience"]
    }
    
}
