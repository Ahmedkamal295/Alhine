//
//  ContactusVC.swift
//  Student
//
//  Created by MOHAB on 1/30/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit

class ContactusVC: UIViewController , UITextViewDelegate {

    
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var contactusLabel: UILabel!
    
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var YourMessageTV: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        initViews()
        
          navigationController?.isNavigationBarHidden = true
        EmailTF.setPadding(left: 20, right: 20)
        
        YourMessageTV.delegate = self
        YourMessageTV.text = "Your Message"
        if L102Language.currentAppleLanguage() == "ar" {
            
            YourMessageTV.text = "رسالتك"
            
        }
        
        
        YourMessageTV.textColor = UIColor.lightGray
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if YourMessageTV.textColor == UIColor.lightGray {
            YourMessageTV.text = ""
            YourMessageTV.textColor = UIColor.black
        }
    }
    
    
    func initViews(){
        
        if L102Language.currentAppleLanguage() == "ar" {
            
            EmailTF.placeholder = "البريد الاكترونى"
            sendBtn.setTitle("ارسال", for: .normal)
            contactusLabel.text = "تواصل معنا"
            
            backBtn.setImage(#imageLiteral(resourceName: "rightArrow-1"), for: .normal)
            
        }
        
        
    }
    
    
    @IBAction func backAction(_ sender: Any) {

        if L102Language.currentAppleLanguage() == englishLang {
            panel?.openLeft(animated: true)
        }else{
            panel?.openRight(animated: true)
        }
        

    }
    
   
    @IBAction func SendAction(_ sender: Any) {
        
        if isNotEmptyString(text: EmailTF.text!, withAlertMessage: "please insert your email") , isNotEmptyString(text: YourMessageTV.text!, withAlertMessage: "please insert your message") {
            
            
            ContactUs()
            
            
        }
        
        
        
    }
    

}

extension ContactusVC {
    
    func ContactUs(){
        
        
        
        view.lock()
        DispatchQueue.main.async {
            //            self.subjectLabel.showAnimatedSkeleton()
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let manager = Manager()
            
            let param = [
                "email" : self.EmailTF.text! ,
                "message" : self.YourMessageTV.text!
                
            ]
            
            manager.perform(methodType: .post, serviceName: .contact, parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
                
                self.view.unlock()
                
                if String != nil {
                    
                    self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }else {
                    let response = JSON as! NSDictionary
                    
                    print(response)
                    
                 
                    self.showStatus(image: #imageLiteral(resourceName: "Logog"), message: "Done")
                    
                    
                    self.view.unlock()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    
                }
                
            }
        }
        
        
    }
    
    
}
