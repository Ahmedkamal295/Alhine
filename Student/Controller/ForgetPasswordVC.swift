//
//  ForgetPasswordVC.swift
//  Student
//
//  Created by MOHAB on 1/31/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit
import ObjectMapper

class ForgetPasswordVC: UIViewController {
    
    
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var saveBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        
        if isNotEmptyString(text: emailTF.text!, withAlertMessage: "please insert your email")
    {
        
        forgetPassword()
        
        }
        
        
        
    }
    
    

}


extension ForgetPasswordVC {
    
    func forgetPassword(){
        
        
        
        view.lock()
        DispatchQueue.main.async {
            //            self.subjectLabel.showAnimatedSkeleton()
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let manager = Manager()
            
            let param = [
                "email" : self.emailTF.text!
               
                
            ]
            
            manager.perform(methodType: .post, serviceName: .forgetPassword, parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
                
                self.view.unlock()
                
                if String != nil {
                    
                    self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }else {
                    let response = JSON as! NSDictionary
                    
                    print(response)
                   
                    
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc  = storyboard.instantiateViewController(withIdentifier: "verivicationCodeVC") as! verivicationCodeVC
                   
                    vc.email = self.emailTF.text
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
                    self.view.unlock()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    
                }
                
            }
        }
        
        
    }
    
    
}
