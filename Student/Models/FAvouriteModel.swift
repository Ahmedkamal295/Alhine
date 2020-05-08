//
//  FAvouriteModel.swift
//  Student
//
//  Created by MOHAB on 1/31/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import Foundation
import ObjectMapper

struct FavouriteModel : Mappable {
    var message : String?
    var favourite : [Favourite]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        message <- map["message"]
        favourite <- map["favourite"]
    }
    
}
struct Favourite : Mappable {
    var id : Int?
    var name : String?
    var email : String?
    var logo : String?
    var language : String?
    var cv : CvFAvourite?
    var job : FavouriteJob?
    var is_cv : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        logo <- map["logo"]
        language <- map["language"]
        cv <- map["cv"]
        job <- map["job"]
        is_cv <- map["is_cv"]
    }
    
}
struct CvFAvourite : Mappable {
    var id : Int?
    var job_title : String?
    var phone : String?
    var username : String?
    var email : String?
    var date_of_birth : String?
    var nationality : NationalityFAvourite?
    var martial_status : String?
    var residence_country : Residence_country?
    var religion : ReligionFAvourite?
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
struct FavouriteJob : Mappable {
    var id : Int?
    var job_title : String?
    var companyName : String?
    var image : String?
    var phone : String?
    var email : String?
    var total_experience : String?
    var residence_country : Residence_country?
    var company : CompanyFAvourite?
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
struct ReligionFAvourite : Mappable {
    var id : Int?
    var religion : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        religion <- map["religion"]
    }
    
}
struct NationalityFAvourite : Mappable {
    var id : Int?
    var nationality : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        nationality <- map["nationality"]
    }
    
}
struct CompanyFAvourite : Mappable {
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
struct Residence_country : Mappable {
    var id : Int?
    var country : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        country <- map["country"]
    }
    
}
