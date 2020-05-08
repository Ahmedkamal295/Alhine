//
//  LoginVC.swift
//  Student
//
//  Created by MOHAB on 1/30/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginVC: UIViewController {

   
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var LoginBtn: UIButton!
    
    @IBOutlet weak var signBtn: UIButton!
    
    @IBOutlet weak var signupBtn: UIButton!
    
    @IBOutlet weak var forgetPasswordBtn: UIButton!
    
    @IBOutlet weak var skipBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      initViews()
       
        
        
    }
    
    func initViews(){
        
        if L102Language.currentAppleLanguage() == "ar" {
            
            signBtn.setTitle("تسجيل دخول", for: .normal)
            
            signupBtn.setTitle("تسجيل", for: .normal)
            
            emailTF.placeholder = ""
            
            passwordTF.placeholder = ""
            
            LoginBtn.setTitle("تسجيل دخول", for: .normal)
            skipBtn.setTitle("تخطى", for: .normal)
            
            forgetPasswordBtn.setTitle("نسيت كلمة السر", for: .normal)
            
            
           
            
        }
        
        
    }
    
    

    @IBAction func DissmissAction(_ sender: Any) {
  
    
    
    }
    
    @IBAction func SignAction(_ sender: Any) {
    }
    
    @IBAction func RegisterAction(_ sender: Any) {
        
    
        goVC("RegisterVC")
        
    }
    
    
    @IBAction func SkipAtion(_ sender: Any) {
        
           appDelegate.SideMenu()
    }
    
    @IBAction func LoginAction(_ sender: Any) {
        
        if isNotEmptyString(text: emailTF.text!, withAlertMessage: "please isert your email".localized) , isNotEmptyString(text: passwordTF.text!, withAlertMessage:"please insert your password") {
            
            
            Login()
            
            
        }
        
    }
    
    
    
    @IBAction func ForgetPasswordAction(_ sender: Any) {
        
        goVC("ForgetPasswordVC")
        
    }
}

extension LoginVC {
    
    func Login(){
    
        
            view.lock()
            DispatchQueue.main.async {
                //            self.subjectLabel.showAnimatedSkeleton()
        
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                let manager = Manager()
                
                let param = [
                    "email" : self.emailTF.text! ,
                    "password" : self.passwordTF.text!
                
                ]
        
                manager.perform(methodType: .post, serviceName: .Login, parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
        
                    self.view.unlock()
        
                    if String != nil {
        
                        self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
                    }else {
                        let response = JSON as! NSDictionary
        
                        print(response)
        
                        let Response : LoginModel = Mapper<LoginModel>().map(JSON: response as! [String : Any])!
        
        
        
        
                        HelperToken.SaveApitoken(token: Response.user?.apiToken)
                        HelperToken.SaveEmail(email: Response.user?.email)
                        HelperToken.Savename(name: Response.user?.name)
                        if Response.user?.is_employee == 1 {
                            
                            HelperToken.Saveemployee(isemployee: true)
                            
                        }else if Response.user?.is_employee == 0 {
                            
                               HelperToken.Saveemployee(isemployee: false)
                            
                        }
        
        
        
                        appDelegate.SideMenu()
                        
        
        
                        self.view.unlock()
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        
                    }
        
                }
            }
        
    }
    
    
    
    
}
