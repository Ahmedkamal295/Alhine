/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct MyLogin : Mappable {
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

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

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
