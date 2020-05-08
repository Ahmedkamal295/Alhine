//
//  CvInfoModel.swift
//  Student
//
//  Created by MOHAB on 2/12/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import Foundation
import ObjectMapper

struct cvInfoModel : Mappable {
    var message : String?
    var cv : CvInfo?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        message <- map["message"]
        cv <- map["cv"]
    }
    
}
struct CvInfo : Mappable {
    var id : Int?
    var job_title : String?
    var phone : String?
    var username : String?
    var email : String?
    var date_of_birth : String?
    var nationality : Nationality?
    var martial_status : String?
    var residence_country : Residence_country?
    var religion : Religion?
    var total_experience : String?
    var note : String?
    var photo : String?
    var expectedSalary : String?
    var work_experience_job_title : String?
    var work_experience_company_name : String?
    var work_experience_experirnce_years : String?
    var rate : Int?
    var isFav : Bool?
    var review : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        job_title <- map["job_title"]
        phone <- map["phone"]
        username <- map["Username"]
        email <- map["email"]
        date_of_birth <- map["date_of_birth"]
        nationality <- map["nationality"]
        martial_status <- map["martial_status"]
        residence_country <- map["residence_country"]
        religion <- map["religion"]
        total_experience <- map["total_experience"]
        note <- map["note"]
        photo <- map["photo"]
        expectedSalary <- map["expectedSalary"]
        work_experience_job_title <- map["work_experience_job_title"]
        work_experience_company_name <- map["work_experience_company_name"]
        work_experience_experirnce_years <- map["work_experience_experirnce_years"]
        rate <- map["rate"]
        isFav <- map["isFav"]
        review <- map["review"]
    }
    
}
struct Nationality : Mappable {
    var id : Int?
    var nationality : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        nationality <- map["nationality"]
    }
    
}

struct Religion : Mappable {
    var id : Int?
    var religion : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        religion <- map["religion"]
    }
    
}
struct CvResidence_country : Mappable {
    var id : Int?
    var country : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        country <- map["country"]
    }
    
}
