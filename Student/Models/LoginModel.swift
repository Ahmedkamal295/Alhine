//
//  LoginModel.swift
//  Student
//
//  Created by MOHAB on 1/31/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import Foundation
import ObjectMapper

struct LoginModel : Mappable {
    var message : String?
    var user : LoginUser?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        message <- map["message"]
        user <- map["user"]
    }
    
}
struct LoginUser : Mappable {
    var apiToken : String?
    var name : String?
    var email : String?
    var logo : String?
    var language : String?
    var cv : String?
    var is_employee : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        apiToken <- map["apiToken"]
        name <- map["name"]
        email <- map["email"]
        logo <- map["logo"]
        language <- map["language"]
        cv <- map["cv"]
        is_employee <- map["is_employee"]
    }
    
}
