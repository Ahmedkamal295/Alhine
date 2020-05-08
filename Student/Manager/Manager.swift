//
//  Manager.swift
//  Levo User Application
//
//  Created by haniielmalky on 12/10/18.
//  Copyright © 2018 Gra7. All rights reserved.
//

import UIKit
import Alamofire


let hostName = "http://apialhin.77carsael.com/api/"

enum ServiceName: String {
    
  
    case empty = ""
    case Login = "login"
    case forgetPassword = "forgetPassword"
    case validateCode = "validateCode"
    case changePassword = "changePassword"
    case favourite = "favourite"
    case makeFavourite = "makeFavourite"
    case contact = "contact"
    case cv = "cv/search"
    case ads = "ads"
    case appInfo = "appInfo"
    case Locations = "residenceCountry"
    case jobsName = "jobs/name"
    case recomendedJobs = "job/search"
    case ApplyJob = "appley"
    case cvInfo = "cv/info"
    case personalCv = "cv/get"
    case jobInfo = "job/info"
    case religion = "religion"
    case nationality = "nationality"
    case updateCV = "cv/update"
    case jobApplied = "appley/get"

    
}

class Manager {
    var lang : String = "ar"
    
   static var DevicToken : String?

    func perform(methodType: HTTPMethod = .post, useCustomeURL: Bool = false, urlStr: String = "", serviceName: ServiceName, parameters: [String: AnyObject]? = nil, completionHandler: @escaping (Any?, String?) -> Void)-> Void {
        
        if L102Language.currentAppleLanguage() == arabicLang {
            self.lang = "ar"
        }else{
            self.lang = "en"
        }
        
        var urlString: String = ""
        var headers: HTTPHeaders? = nil
        
        if useCustomeURL {
            urlString = urlStr
        }else {
            urlString = "\(hostName)\(serviceName.rawValue)"
        }
        
        
        print("ServiceName:\(serviceName)  parameters: \(String(describing: parameters))")
        
//
//        if User.shared.token != "" && User.shared.token != nil{
//            headers = [
//                "Accept-Language": self.lang,
//                "Authorization": "Bearer \(User.shared.token!)"
//            ]
//        }else{
//            headers = [
//                "Accept-Language": self.lang
//            ]
//        }

        
        Alamofire.request(urlString, method: methodType, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON{ response in
            
            
            debugPrint(response)
            
            if response.result.isSuccess {
                
                let dict = response.result.value! as! [String: Any]
                
                if dict["message"] as? String == "done" || dict["message"] as? String == "تم " {
                    completionHandler(dict, nil)
                }else{
                    if let dictError = dict["error"] as? String {
                        completionHandler(nil, dictError)
                    }else {
                        guard let errorStr = dict["message"] as? String else {
                            let errorsDict = dict["message"] as! [String: Any]
                            let errorsArr = errorsDict.values.first as! [String]
                            
                            completionHandler(nil, errorsArr[0])
                            return
                        }
                        completionHandler(nil, errorStr)
                    }
                }
                
            } else { //FAILURE
                print("error \(String(describing: response.result.error)) in serviceName: \(serviceName)")
                completionHandler(nil, response.result.error?.localizedDescription)
            }
        }
    }
    
    
    
    func uploadImage(serviceName: ServiceName,imagesArray: [UIImage]? = nil, profileImage: UIImage? = nil,commercial_register_image: UIImage? = nil,office_license_image:UIImage? = nil,id_image:UIImage? = nil, parameters: [String: AnyObject]? = nil, progress: @escaping (_ percent: Float) -> Void, completionHandler: @escaping (Any?, String?) -> Void) {
        
        var headers: HTTPHeaders? = nil
        
//        if User.shared.token != "" && User.shared.token != nil{
//            headers = [
//                "Accept-Language": "en",
//                "Authorization": "bearer \(User.shared.token!)"
//            ]
//        }else{
//            headers = [
//                "Accept-Language": "en"
//            ]
//        }
        
        let urlString: String =  "\(hostName)\(serviceName.rawValue)"
        
        
        
        let URL = try! URLRequest(url: urlString, method: .post, headers: headers)
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                if(profileImage != nil ){
                    if  let profileImageData = profileImage?.jpegData(compressionQuality: 0.3) {
                        multipartFormData.append(profileImageData , withName: "image", fileName: "image.jpg", mimeType: "image/jpg")
                    }
                }

                if imagesArray != nil{
                    for (image) in imagesArray! {
                        
                        if  let imageData = image.jpegData(compressionQuality: 0.3) {
                            multipartFormData.append(imageData , withName: "images[]", fileName: "image\(image).jpg", mimeType: "image/jpg")
                        }
                    }
                }
                if(commercial_register_image != nil ){
                    if  let profileImageData = commercial_register_image?.jpegData(compressionQuality: 0.3) {
                        multipartFormData.append(profileImageData , withName: "commercial_register_image", fileName: "image.jpg", mimeType: "image/jpg")
                    }
                }
                if(office_license_image != nil ){
                    if  let profileImageData = office_license_image?.jpegData(compressionQuality: 0.3) {
                        multipartFormData.append(profileImageData , withName: "office_license_image", fileName: "image.jpg", mimeType: "image/jpg")
                    }
                }
                if(id_image != nil ){
                    if  let profileImageData = id_image?.jpegData(compressionQuality: 0.3) {
                        multipartFormData.append(profileImageData , withName: "id_image", fileName: "image.jpg", mimeType: "image/jpg")
                    }
                }
                
                for (key, value) in parameters! {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
                
        },
            with: URL,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let request, _, _):
                    print("success")
                    request.uploadProgress(closure: { (progress_) in
                        print("Upload Progress: \(progress_.fractionCompleted)")
                        print("Upload totalUnitCount: \(progress_.totalUnitCount)")
                    })
                    request.validate(statusCode: 200..<500)
                    request.responseJSON { response in
                        
                        debugPrint("uploadRegistration: \(response)")
                        if response.result.isSuccess {
                            request.uploadProgress(closure: { (progress_) in
                                print("Upload Progress: \(progress_.fractionCompleted)")
                                print("Upload totalUnitCount: \(progress_.totalUnitCount)")
                            })
                            let dict = response.result.value! as! Dictionary<String, Any>
                            
                            print(response.result)
                            
                            if (dict["value"] as! Bool == false){
                                let errorMsg = dict["msg"] as! String
                                completionHandler(nil,errorMsg)
                                
                            }else{
                                let statusCode = response.response?.statusCode
                                if statusCode! >= 200 && statusCode! <= 300 {
                                    completionHandler(dict, nil)
                                }else{
                                    completionHandler(nil, "Something Went Wrong.")
                                }
                                
                            }
                        }else { //FAILURE
                            print("error \(String(describing: response.result.error)) in serviceName: Upload Image")
                            completionHandler(nil, response.result.error?.localizedDescription)
                        }
                        
                    }
                case .failure(let errorType):
                    print("encodingError:\(errorType)")
                }
        })
        
    }
    func performJson(methodType: HTTPMethod = .post, useCustomeURL: Bool = false, urlStr: String = "", serviceName: ServiceName, parameters: [String: Any]? = nil, completionHandler: @escaping (Any?, String?) -> Void)-> Void {
        
        var urlString: String = ""
        var headers: HTTPHeaders? = nil
        
        if useCustomeURL {
            urlString = urlStr
        }else {
            urlString = "\(hostName)\(serviceName.rawValue)"
        }
        
        
        print("ServiceName:\(serviceName)  parameters: \(String(describing: parameters))")
        
//
//        if User.shared.token != "" && User.shared.token != nil{
//            headers = [
//                "Accept-Language": "en",
//                "Authorization": "Bearer \(User.shared.token!)"
//            ]
//        }else{
//            headers = [
//                "Accept-Language": "en"
//            ]
//        }
        
        
        Alamofire.request(urlString, method: methodType, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            
            
            debugPrint(response)
            
            if response.result.isSuccess {
                
                let dict = response.result.value! as! [String: Any]
                
                if dict["value"] as? Bool == true || dict["value"] as? String == "true" {
                    completionHandler(dict, nil)
                }else{
                    if let dictError = dict["error"] as? String {
                        completionHandler(nil, dictError)
                    }else {
                        guard let errorStr = dict["msg"] as? String else {
                            let errorsDict = dict["msg"] as! [String: Any]
                            let errorsArr = errorsDict.values.first as! [String]
                            
                            completionHandler(nil, errorsArr[0])
                            return
                        }
                        completionHandler(nil, errorStr)
                    }
                }
                
            } else { //FAILURE
                print("error \(String(describing: response.result.error)) in serviceName: \(serviceName)")
                completionHandler(nil, response.result.error?.localizedDescription)
            }
            
        }
    }
    
    
}
