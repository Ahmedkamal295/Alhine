//
//  helperToken.swift
//  Student
//
//  Created by MOHAB on 1/31/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//


import UIKit

class HelperToken : NSObject {
    
    class func api_toket()->String {
        
        let api_token = "token"
        return api_token
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
    
    class func employee()->String {
        
        let employee = "employee"
        return employee
    }
    
    
    
    
    
    class func Saveemployee(isemployee : Bool){
        
        let def = UserDefaults.standard
        def.setValue(isemployee, forKey: employee())
        def.synchronize()
        
        
    }
    
    
    class func getemployee()->Bool {
        
        let def = UserDefaults.standard
        return def.object(forKey: employee()) as? Bool ?? false
        
        
        
    }
  
    class func Email()->String {
        
        let api_token = "email"
        return api_token
    }
    
    
    
    
    
    class func SaveEmail(email : String?){
        
        let def = UserDefaults.standard
        def.setValue(email, forKey: Email())
        def.synchronize()
        
        
    }
    
    
    class func getEmail()->String? {
        
        let def = UserDefaults.standard
        return def.object(forKey: Email()) as? String
        
        
        
    }
    
    
    
    class func namee()->String {
        
        let api_token = "name"
        return api_token
    }
    
    
    
    
    
    class func Savename(name : String?){
        
        let def = UserDefaults.standard
        def.setValue(name, forKey: namee())
        def.synchronize()
        
        
    }
    
    
    class func getname()->String? {
        
        let def = UserDefaults.standard
        return def.object(forKey: namee()) as? String
        
        
        
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
