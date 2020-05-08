//
//  NewPasswordVC.swift
//  Student
//
//  Created by MOHAB on 1/30/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit

class NewPasswordVC: UIViewController {

    
    @IBOutlet weak var newPasswordLabel: UILabel!
    
    @IBOutlet weak var confirmpasswordLabel: UILabel!
    
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var confirmnewPasswordTF: UITextField!
    
    var tempToken : String?
    @IBOutlet weak var SaveBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     initViews()
        
    }
    
    
    func initViews(){
        
        newPasswordLabel.text = "الرقم السرى الجديد"
        confirmpasswordLabel.text = "تاكيد الرقم السرى"
        SaveBtn.setTitle("حفظ", for: .normal)
        
    }

    
    @IBAction func dismissAction(_ sender: Any) {
 
    
    navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func SaveAction(_ sender: Any) {
        
        if isNotEmptyString(text: newPasswordTF.text!, withAlertMessage: "please inser new Password") {
            
            guard newPasswordTF.text == confirmnewPasswordTF.text else {
                
                self.showAlertWithTitle(title: "", message: "password and password confirmation is not identical", type: .error)
                return
            }
            cahangePassword()
            
        }
        
        
    }
    
    
    
}
extension NewPasswordVC {
    
    func cahangePassword(){
        
        
        
        view.lock()
        DispatchQueue.main.async {
            //            self.subjectLabel.showAnimatedSkeleton()
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let manager = Manager()
            
            let param = [
                "newPassword" : self.newPasswordTF.text! ,
                "tmpToken" : self.tempToken!
                
                
            ]
            
            manager.perform(methodType: .post, serviceName: .changePassword, parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
                
                self.view.unlock()
                
                if String != nil {
                    
                    self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }else {
                    let response = JSON as! NSDictionary
                    
                    print(response)
                    
                    
                    
             self.navigationController?.popToRootViewController(animated: true)
                    
                    
                    self.view.unlock()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    
                }
                
            }
        }
        
        
        
        
        
        
    }
    
    
}
