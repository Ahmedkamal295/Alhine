//
//  Helper.swift
//  Student
//
//  Created by MOHAB on 11/14/19.
//  Copyright © 2019 e3gaz. All rights reserved.
//

import UIKit

class Helper: NSObject {
    
    class func api_toket()->String {
        
        let api_token = "token"
        return api_token
    }
    
    
    class func Lang()->String {
        
        let lang = "lang"
        return lang
    }
    
    
    
    class func SaveApitoken(token : String?){
        
        let def = UserDefaults.standard
        def.setValue(token, forKey: api_toket())
        def.synchronize()
        
        
    }
    
    
    class func getapitoken()->String? {
        
        let def = UserDefaults.standard
        return def.object(forKey: api_toket()) as? String
        
        
        
    }
    
    
    class func Savelang(lang : String?){
        
        let def = UserDefaults.standard
        def.setValue(lang, forKey: Lang())
        def.synchronize()
        
        
    }
    
    
    class func Getlang()->String? {
        
        let def = UserDefaults.standard
        return def.object(forKey: Lang()) as? String
        
        
    }
    class func CountryId()->String {
        
        let CountryId = "CountryId"
        return CountryId
    }
    
    class func SaveCountryId(Id : Int?){
        
        let def = UserDefaults.standard
        def.setValue(Id, forKey: CountryId())
        def.synchronize()
        
        
    }
    
    
    class func getCountryId()->Int? {
        
        let def = UserDefaults.standard
        return def.object(forKey: CountryId()) as? Int
        
        
        
    }
    
    
    
    class func LanguageId()->String {
        
        let LanguageId = "LanguageId"
        return LanguageId
    }
    
    
    
    class func SaveLanguageId(Id : String?){
        
        let def = UserDefaults.standard
        def.setValue(Id, forKey: LanguageId())
        def.synchronize()
        
        
    }
    
    
    class func getLanguageId()->String? {
        
        let def = UserDefaults.standard
        def.synchronize()
        return def.object(forKey: LanguageId()) as? String
        
        
        
    }
    
    
    
    class func Fcm_toket()->String {
        
        let Fcm_token = "Fcmtoken"
        return Fcm_token
    }
    
    
    
    
    
    class func SaveFcmtoken(Fcmtoken : String?){
        
        let def = UserDefaults.standard
        def.setValue(Fcmtoken, forKey: Fcm_toket())
        def.synchronize()
        
        
    }
    
    
    class func getFcmtoken()->String? {
        
        let def = UserDefaults.standard
        return def.object(forKey: Fcm_toket()) as? String
        
        
        
    }
    
    
    
    class func restartApp(_ id : String){
        guard let window = UIApplication.shared.keyWindow else{return}
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var vc : UIViewController
        
        
        vc = sb.instantiateViewController(withIdentifier: id)
        
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        
    }
    
    func restartApplication() {
        
        
    }
    
}
