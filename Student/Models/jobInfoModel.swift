//
//  jobInfoModel.swift
//  Student
//
//  Created by MOHAB on 2/12/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import Foundation
import ObjectMapper

struct jobInfoModel : Mappable {
    var message : String?
    var jobs : JobsInfo?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        message <- map["message"]
        jobs <- map["jobs"]
    }
    
}
struct JobsInfo : Mappable {
    var id : Int?
    var job_title : String?
    var companyName : String?
    var image : String?
    var phone : String?
    var email : String?
    var total_experience : String?
    var residence_country : Residence_country?
    var company : Company?
    var rate : Int?
    var isFav : Bool?
    var review : String?
    var salary : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        job_title <- map["job_title"]
        companyName <- map["companyName"]
        image <- map["image"]
        phone <- map["phone"]
        email <- map["email"]
        total_experience <- map["total_experience"]
        residence_country <- map["residence_country"]
        company <- map["company"]
        rate <- map["rate"]
        isFav <- map["isFav"]
        review <- map["review"]
        salary <- map["salary"]
    }
    
}

struct Company : Mappable {
    var id : Int?
    var name : String?
    var email : String?
    var logo : String?
    var language : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        logo <- map["logo"]
        language <- map["language"]
    }
    
}
