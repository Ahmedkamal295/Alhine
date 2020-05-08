//
//  TermsModel.swift
//  Student
//
//  Created by MOHAB on 2/3/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//


import Foundation
import ObjectMapper

struct TermsModel : Mappable {
    var message : String?
    var appInfo : AppInfo?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        message <- map["message"]
        appInfo <- map["appInfo"]
    }
    
}
struct AppInfo : Mappable {
    var about_us : String?
    var terms_conditions : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        about_us <- map["about_us"]
        terms_conditions <- map["terms_conditions"]
    }
    
}
