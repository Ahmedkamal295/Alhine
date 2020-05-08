//
//  RegisterVC.swift
//  Student
//
//  Created by MOHAB on 1/30/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit
import ObjectMapper

class RegisterVC: UIViewController {
    
   
    var type : String = "employee"
    
    @IBOutlet weak var LoginBtn: UIButton!
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    @IBOutlet weak var PasswordConfirmationTF: UITextField!
    
    @IBOutlet weak var EmployeeBtn: UIButton!
    
    @IBOutlet weak var EmployerBtn: UIButton!
    @IBOutlet weak var sgnUpBtn: UIButton!
    
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        initViews()
        
        
    }
    
    
    func initViews(){
        

        if L102Language.currentAppleLanguage() == "ar" {
        sgnUpBtn.setTitle("تسجيل", for: .normal)
        
        EmployerBtn.setTitle("شركة", for: .normal)
        
         EmployeeBtn.setTitle("موظف", for: .normal)
        
        usernameTF.placeholder = "اسم المستخدم"
        
        emailTF.placeholder = "البريد الاكترونى"
        PasswordTF.placeholder = "الرقم السرى"
        PasswordConfirmationTF.placeholder = "تاكيد الرقم السرى"
        
        LoginBtn.setTitle("تسجيل دخول", for: .normal)
        backBtn.setImage(#imageLiteral(resourceName: "RightLogo"), for: .normal)
        }
        
        
    }
    
    
    
    @IBAction func EmployeeAction(_ sender: Any) {
   
        type = "employee"
        EmployeeBtn.setTitleColor(#colorLiteral(red: 0.0717042163, green: 0.2324477136, blue: 0.3586467505, alpha: 1), for: .normal)
        EmployerBtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
    
    }
    
    @IBAction func EmployerAction(_ sender: Any) {
  
         type = "company"
         EmployerBtn.setTitleColor(#colorLiteral(red: 0.0717042163, green: 0.2324477136, blue: 0.3586467505, alpha: 1), for: .normal)
         EmployeeBtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
    }
    
    @IBAction func LoginAction(_ sender: Any) {
   
    
        
        if isNotEmptyString(text: usernameTF.text!, withAlertMessage: "please insert your name") , isNotEmptyString(text: emailTF.text!, withAlertMessage: "please insert your email") , isNotEmptyString(text: PasswordTF.text!, withAlertMessage: "please insert your password") , isNotEmptyString(text: PasswordConfirmationTF.text!, withAlertMessage: "please insert password confirmation") {
            
            guard PasswordConfirmationTF.text == PasswordTF.text else {
                
                self.showAlertWithTitle(title: "", message: "password and password confirmation is not identical", type: .error)
                
                return
                
            }
            
            Register()
            
        }
    
    }
    
    @IBAction func backAction(_ sender: Any) {
  
  
        navigationController?.popViewController(animated: true)
    
    }
    
}


extension RegisterVC {
    
    func Register(){
     
        
        view.lock()
        LoginBtn.startAnimating()
        
        
        
        DispatchQueue.main.async {
            //            self.subjectLabel.showAnimatedSkeleton()
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let manager = Manager()
            
            
            
            let urlll = "http://apialhin.77carsael.com/api/register/\(self.type)"
            
            var lang = "en"
            
            if L102Language.currentAppleLanguage() == "ar" {
                
                lang = "ar"
                
            }
            
            let param = [
                "language" : lang ,
                "name" : self.usernameTF.text! ,
                "email" : self.emailTF.text! ,
                "password" : self.PasswordTF.text!
            
            
            ]
            
            manager.perform(methodType: .post, useCustomeURL: true, urlStr: urlll, serviceName: .empty, parameters: param as [String : AnyObject]) { (JSON, String) -> Void in
                self.view.unlock()
                self.LoginBtn.stopAnimating()
                
                
                if String != nil {
                    
                    self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }else {
                    let response = JSON as! NSDictionary
                    
                    if self.type == "employee" {
                        
                         let Response : registerModel = Mapper<registerModel>().map(JSON: response as! [String : Any])!
                         HelperToken.SaveApitoken(token: Response.employee?.apiToken)
                        HelperToken.Savename(name: Response.employee?.name)
                        HelperToken.SaveEmail(email: Response.employee?.email)
                        
                        appDelegate.SideMenu()
                    }else {
                         let Response : ComponyRegisterModel = Mapper<ComponyRegisterModel>().map(JSON: response as! [String : Any])!
                         HelperToken.SaveApitoken(token: Response.company?.apiToken)
                        HelperToken.Savename(name: Response.company?.name)
                        HelperToken.SaveEmail(email: Response.company?.email)
                              appDelegate.SideMenu()
                    }
                   
                    
                    
                   
                  
                   
                    
                 
                 
                    
                    
                    
                    
                    
                }
                
            }
        }
        
        
        
        
        
    }
    
    
    
}
//func getAlloffers(){
//
//
//
//
//
//
//    view.lock()
//    DispatchQueue.main.async {
//        //            self.subjectLabel.showAnimatedSkeleton()
//
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        let manager = Manager()
//
//        manager.perform(methodType: .get, serviceName: .offers, parameters: nil ) { (JSON, String) -> Void in
//
//            self.view.unlock()
//
//            if String != nil {
//
//                self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//
//            }else {
//                let response = JSON as! NSDictionary
//
//                print(response)
//
//                let Response : offersModel = Mapper<offersModel>().map(JSON: response as! [String : Any])!
//
//
//
//
//                self.OffersArray = Response.offers ?? []
//
//
//
//                for i in 0...self.OffersArray.count - 1 {
//                    self.arrOfBool.append(false)
//                }
//                self.offersTable.animateTable(tableView: self.offersTable)
//
//
//
//                print(Response)
//
//
//                self.view.unlock()
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//
//
//            }
//
//        }
//    }
//}
//
//
//
//
