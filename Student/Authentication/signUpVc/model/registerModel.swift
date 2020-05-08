

import Foundation
import ObjectMapper

class registerModel : Mappable {
    
    
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
    
    required init?(map: Map) {
        
    }
    
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
    }
    
}
