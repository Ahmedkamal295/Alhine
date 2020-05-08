//
//  verivicationCodeVC.swift
//  Student
//
//  Created by MOHAB on 1/31/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit
import ObjectMapper

class verivicationCodeVC: UIViewController ,UITextFieldDelegate {

    
    
    @IBOutlet weak var tf1: UITextField!
    @IBOutlet weak var tf2: UITextField!
    @IBOutlet weak var tf3: UITextField!
    @IBOutlet weak var tf4: UITextField!
    
    @IBOutlet weak var backBtn: UIButton!
    
    var email : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tf1.addTarget(self, action: #selector(textFieldDidChange1), for: .editingChanged)
        tf2.addTarget(self, action: #selector(textFieldDidChange2), for: .editingChanged)
        tf3.addTarget(self, action: #selector(textFieldDidChange3), for: .editingChanged)
        tf4.addTarget(self, action: #selector(textFieldDidChange4), for: .editingChanged)
        
        
        
        
        tf1.delegate = self
        tf2.delegate = self
        tf3.delegate = self
        tf4.delegate = self
    }
    

    @IBAction func backAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    @objc func textFieldDidChange1()  {
        if tf1.text?.count == 1 {
            tf2.becomeFirstResponder()
        }
    }
    
    @objc func textFieldDidChange2()  {
        if tf2.text?.count == 1 {
            tf3.becomeFirstResponder()
        }
    }
    
    @objc func textFieldDidChange3()  {
        if tf3.text?.count == 1 {
            tf4.becomeFirstResponder()
        }
    }
    
    @objc func textFieldDidChange4()  {
        if tf4.text?.count == 1 {
            tf4.resignFirstResponder()
        }
    }
    
    
    @IBAction func SaveAction(_ sender: Any) {
        
        if isNotEmptyString(text: tf1.text!, withAlertMessage: "please inser first number") , isNotEmptyString(text: tf2.text!, withAlertMessage: "please inser second number") , isNotEmptyString(text: tf3.text!, withAlertMessage: "please inser third number") , isNotEmptyString(text: tf4.text!, withAlertMessage: "please insert four number") {
            
            
            verificationCode()
            
            
        }
        
        
    }
    
    

}


extension verivicationCodeVC {
    
    func verificationCode(){
        
        
        view.lock()
        DispatchQueue.main.async {
            //            self.subjectLabel.showAnimatedSkeleton()
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let manager = Manager()
            
            let param = [
                "email" : self.email ,
                "code" : "123456"
               // "code" : "\(self.tf1.text!),\(self.tf2.text!)\(self.tf3.text!)\(self.tf4.text!)"
                
                
            ]
            
            manager.perform(methodType: .post, serviceName: .validateCode, parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
                
                self.view.unlock()
                
                if String != nil {
                    
                    self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }else {
                    let response = JSON as! NSDictionary
                    
                    print(response)
                     let Response : VerificationModel = Mapper<VerificationModel>().map(JSON: response as! [String : Any])!
                   
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc  = storyboard.instantiateViewController(withIdentifier: "NewPasswordVC") as! NewPasswordVC
                    
                  
                    vc.tempToken =  Response.tmpApiToken
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
                    self.view.unlock()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    
                }
                
            }
        }
        
        
        
        
    }
    
    
}
