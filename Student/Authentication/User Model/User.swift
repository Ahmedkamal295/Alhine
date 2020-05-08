//
//  User.swift
//  WomenAccessories
//
//  Created by mahrous
//  Copyright © 2018 Gra7. All rights reserved.
//

import Foundation
import ObjectMapper

class User: NSObject, Mappable, Codable, NSCoding {
    
    static let shared = User()
    
    var id : Int?
    var username : String?
    var email : String?
    var mobile : String?
    var gender : String?
    var birthday : String?
    var type : String?
    var status : String?
    var wallet : String?
    var notification : String?
    var lat : String?
    var lng : String?
    var rate : Int?
    var car_type_id : Int?
    var car_model_id : String?
    var car_model : String?
    var year_id : String?
    var year : String?
    var car_number : String?
    var car_color : String?
    var driver_status : String?
    var image : String?
    var id_image_front : String?
    var id_image_back : String?
    var license_image_front : String?
    var license_image_back : String?
    var car_image_front : String?
    var car_image_back : String?
    var personal_license_front : String?
    var personal_license_back : String?
    var setting_policy : String?
    var setting_mobile : String?
    var setting_app_ratio : String?
    var first_offer : String?
    var first_offer_status : String?
    var token : String?
    var code : Int?
    override init() {
        super.init()
    }
    
    
    required init?(map: Map) {}
    
    
    func mapping(map: Map) {
        
        id <- map["id"]
        username <- map["username"]
        email <- map["email"]
        mobile <- map["mobile"]
        gender <- map["gender"]
        birthday <- map["birthday"]
        type <- map["type"]
        status <- map["status"]
        wallet <- map["wallet"]
        notification <- map["notification"]
        lat <- map["lat"]
        lng <- map["lng"]
        rate <- map["rate"]
        car_type_id <- map["car_type_id"]
        car_model_id <- map["car_model_id"]
        car_model <- map["car_model"]
        year_id <- map["year_id"]
        year <- map["year"]
        car_number <- map["car_number"]
        car_color <- map["car_color"]
        driver_status <- map["driver_status"]
        image <- map["image"]
        id_image_front <- map["id_image_front"]
        id_image_back <- map["id_image_back"]
        license_image_front <- map["license_image_front"]
        license_image_back <- map["license_image_back"]
        car_image_front <- map["car_image_front"]
        car_image_back <- map["car_image_back"]
        personal_license_front <- map["personal_license_front"]
        personal_license_back <- map["personal_license_back"]
        setting_policy <- map["setting_policy"]
        setting_mobile <- map["setting_mobile"]
        setting_app_ratio <- map["setting_app_ratio"]
        first_offer <- map["first_offer"]
        first_offer_status <- map["first_offer_status"]
        token <- map["token"]
        code <- map["code"]
    }
    
    func fillUserModel(model: User) {
        self.id = model.id
        self.username = model.username
        self.email = model.email
        self.mobile = model.mobile
        self.gender = model.gender
        self.birthday = model.birthday
        self.type = model.type
        self.status = model.status
        self.wallet = model.wallet
        self.notification = model.notification
        self.lat = model.lat
        self.lng = model.lng
        self.rate = model.rate
        self.car_type_id = model.car_type_id
        self.car_model_id = model.car_model_id
        self.car_model = model.car_model
        self.year_id = model.year_id
        self.year = model.year
        self.car_number = model.car_number
        self.car_color = model.car_color
        self.driver_status = model.driver_status
        self.image = model.image
        self.id_image_front = model.id_image_front
        self.id_image_back = model.id_image_back
        self.license_image_front = model.license_image_front
        self.license_image_back = model.license_image_back
        self.car_image_front = model.car_image_front
        self.car_image_back = model.car_image_back
        self.personal_license_front = model.personal_license_front
        self.personal_license_back = model.personal_license_back
        self.setting_policy = model.setting_policy
        self.setting_mobile = model.setting_mobile
        self.setting_app_ratio = model.setting_app_ratio
        self.first_offer = model.first_offer
        self.first_offer_status = model.first_offer_status
        self.token = model.token
        self.code = model.code
    }
    
    
    required convenience init(coder aDecoder: NSCoder) {
        
        self.init()
        User.shared.id            = aDecoder.decodeObject(forKey: "id") as? Int
        User.shared.username          = aDecoder.decodeObject(forKey: "username") as? String
        User.shared.email         = aDecoder.decodeObject(forKey: "email") as? String
        User.shared.mobile         = aDecoder.decodeObject(forKey: "mobile") as? String
        User.shared.gender      = aDecoder.decodeObject(forKey: "gender") as? String
        User.shared.birthday       = aDecoder.decodeObject(forKey: "birthday") as? String
        User.shared.image         = aDecoder.decodeObject(forKey: "image") as? String
        User.shared.lat           = aDecoder.decodeObject(forKey: "lat") as? String
        User.shared.lng          = aDecoder.decodeObject(forKey: "lng") as? String
        User.shared.notification          = aDecoder.decodeObject(forKey: "notification") as? String
        User.shared.status          = aDecoder.decodeObject(forKey: "status") as? String
        User.shared.rate            = aDecoder.decodeObject(forKey: "rate") as? Int
        User.shared.car_type_id            = aDecoder.decodeObject(forKey: "car_type_id") as? Int
        User.shared.car_model_id            = aDecoder.decodeObject(forKey: "car_model_id") as? String
        User.shared.car_model            = aDecoder.decodeObject(forKey: "id") as? String
        User.shared.year_id            = aDecoder.decodeObject(forKey: "year_id") as? String
        User.shared.year            = aDecoder.decodeObject(forKey: "year") as? String
        User.shared.car_number            = aDecoder.decodeObject(forKey: "car_number") as? String
        User.shared.id_image_front            = aDecoder.decodeObject(forKey: "id_image_front") as? String
        User.shared.driver_status            = aDecoder.decodeObject(forKey: "driver_status") as? String
        User.shared.car_color            = aDecoder.decodeObject(forKey: "car_color") as? String
        User.shared.id_image_front            = aDecoder.decodeObject(forKey: "id_image_front") as? String
        User.shared.id_image_back            = aDecoder.decodeObject(forKey: "id_image_back") as? String
        User.shared.license_image_front            = aDecoder.decodeObject(forKey: "license_image_front") as? String
        User.shared.license_image_back            = aDecoder.decodeObject(forKey: "license_image_back") as? String
        User.shared.car_image_front            = aDecoder.decodeObject(forKey: "car_image_front") as? String
        User.shared.car_image_back            = aDecoder.decodeObject(forKey: "car_image_back") as? String
        User.shared.setting_policy            = aDecoder.decodeObject(forKey: "setting_policy") as? String
        User.shared.setting_mobile            = aDecoder.decodeObject(forKey: "setting_mobile") as? String
        User.shared.setting_app_ratio            = aDecoder.decodeObject(forKey: "setting_app_ratio") as? String
        User.shared.first_offer            = aDecoder.decodeObject(forKey: "first_offer") as? String
        User.shared.first_offer_status            = aDecoder.decodeObject(forKey: "first_offer_status") as? String
        User.shared.token         = aDecoder.decodeObject(forKey: "token") as? String
        User.shared.code        = aDecoder.decodeObject(forKey: "code") as? Int
    }
    
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(email, forKey: "email")
        coder.encode(username, forKey: "username")
        coder.encode(mobile, forKey: "mobile")
        coder.encode(gender, forKey: "gender")
        coder.encode(image, forKey: "image")
        coder.encode(token, forKey: "token")
        coder.encode(notification, forKey: "notification")
        coder.encode(lat, forKey: "lat")
        coder.encode(lng, forKey: "lng")
        coder.encode(rate, forKey: "city")
        coder.encode(car_type_id, forKey: "car_type_id")
        coder.encode(car_model_id, forKey: "car_model_id")
        coder.encode(car_model, forKey: "car_model")
        coder.encode(year_id, forKey: "year_id")
        coder.encode(year, forKey: "year")
        coder.encode(car_number, forKey: "car_number")
        coder.encode(id_image_front, forKey: "id_image_front")
        coder.encode(driver_status, forKey: "driver_status")
        coder.encode(car_color, forKey: "car_color")
        coder.encode(id_image_front, forKey: "id_image_front")
        coder.encode(id_image_back, forKey: "id_image_back")
        coder.encode(license_image_front, forKey: "license_image_front")
        coder.encode(license_image_back, forKey: "license_image_back")
        coder.encode(car_image_front, forKey: "car_image_front")
        coder.encode(car_image_back, forKey: "car_image_back")
        coder.encode(setting_policy, forKey: "setting_policy")
        coder.encode(setting_mobile, forKey: "setting_mobile")
        coder.encode(setting_app_ratio, forKey: "setting_app_ratio")
        coder.encode(first_offer, forKey: "first_offer")
        coder.encode(first_offer_status, forKey: "first_offer_status")
        coder.encode(code, forKey: "code")

    }
    
    
    func loadData(){
        let userDefaults = UserDefaults.standard
        NSKeyedUnarchiver.unarchiveObject(with: (userDefaults.object(forKey: "User") as! NSData) as Data)
    }
    
    
    func saveData(){
        print("self:\(self)")
        let data = NSKeyedArchiver.archivedData(withRootObject: self)
        UserDefaults.standard.set(data, forKey: "User")
    }
    
    
    func apiToken() -> String{
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "ApiToken") != nil{
            return defaults.string(forKey: "ApiToken")!
        }
        else{
            return ""
        }
    }
    func setApiToken(_ deviceToken: String){
        let defaults = UserDefaults.standard
        defaults.set(deviceToken, forKey: "ApiToken")
    }
    
    func isRegistered() -> Bool{
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "IsRegistered")
    }
    
    
    func setIsRegister(registered: Bool){
        let defaults = UserDefaults.standard
        defaults.set(registered, forKey: "IsRegistered")
    }
    
    func logout() {
        self.id = nil
        self.username = nil
        self.email = nil
        self.mobile = nil
        self.gender = nil
        self.birthday = nil
        self.type = nil
        self.status = nil
        self.wallet = nil
        self.notification = nil
        self.lat = nil
        self.lng = nil
        self.rate = nil
        self.car_type_id = nil
        self.car_model_id = nil
        self.car_model = nil
        self.year_id = nil
        self.year = nil
        self.car_number = nil
        self.car_color = nil
        self.driver_status = nil
        self.image = nil
        self.id_image_front = nil
        self.id_image_back = nil
        self.license_image_front = nil
        self.license_image_back = nil
        self.car_image_front = nil
        self.car_image_back = nil
        self.personal_license_front = nil
        self.personal_license_back = nil
        self.setting_policy = nil
        self.setting_mobile = nil
        self.setting_app_ratio = nil
        self.first_offer = nil
        self.first_offer_status = nil
        self.token = nil
        self.code = nil

        self.setIsRegister(registered: false)
    }
}

