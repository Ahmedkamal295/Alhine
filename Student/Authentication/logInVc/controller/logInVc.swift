//
//  logInVc.swift
//  Terhal
//
//  Created by mahroUS on 2/10/1441 AH.
//  Copyright © 1441 AH mahroUS. All rights reserved.
//

import UIKit
import ObjectMapper

class logInVc: UIViewController {
    var scrollView: UIScrollView!

    @IBOutlet weak var backGroundImg: UIImageView!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var mobileTxt: DesignableUITextField!
    @IBOutlet weak var passwordTxt: DesignableUITextField!
    @IBOutlet weak var loginBtn: UIButton!

        var code: String?
        var phone: String?
    
        override func viewDidLoad() {
            super.viewDidLoad()
            self.passwordTxt.placeholder = "password".localized
            self.mobileTxt.placeholder = "Phone".localized
            
        // Do any additional setup after loading the view.
    }
    

    @IBAction func logInBtn(_ sender: Any) {
        if isNotEmptyString(text: self.mobileTxt.text!, withAlertMessage: "please insert phone number".localized) && isNotEmptyString(text: self.passwordTxt.text!, withAlertMessage: "please insert password".localized){
            let params  = ["mobile":self.mobileTxt.text! as AnyObject,
                           "password":self.passwordTxt.text! as AnyObject,
                          "device_token":UserDefaults.standard.value(forKey: "mobileToken")]as[String:AnyObject]
            print(params)
            login(paramater: params)
    }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "validationCodeVc"{
            let vc = segue.destination as! validationCodeVc
            vc.code = self.code
            vc.phone = self.phone
        }
    }
    
    @IBAction func newUserBtn(_ sender: Any) {
        
        let goToLogOut = (storyboard?.instantiateViewController(withIdentifier: "signUpVc") as? signUpVc)!
        present(goToLogOut,animated: false)
        
    }
    
    @IBAction func forrgetPasswordBtn(_ sender: Any) {
    }
}
extension logInVc {
    func login(paramater: [String:AnyObject]){
        DispatchQueue.main.async {
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.loginBtn.startAnimating(with: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
            let manager = Manager()
            manager.perform(methodType: .post, serviceName: .Login, parameters: paramater) { (JSON, String) -> Void in
                
                if String != nil {
                    self.showAlertWithTitle(title: "Warning".localized, message: String!, type: .warning)
//                    self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                    Vibration.error.vibrate()
                    self.loginBtn.stopAnimating()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }else {
                    
                    let response = JSON as! NSDictionary
                    
                    let user: User = Mapper<User>().map(JSON: response["data"] as! [String : Any])!
                    self.phone = user.mobile
                    self.code = "\(user.code ?? 0)"
                    print(user.status)
                    
                    if user.status == "active"{
                        User.shared.setIsRegister(registered: true)
                        Vibration.success.vibrate()
                        User.shared.fillUserModel(model: user)
                        User.shared.saveData()
                        User.shared.setApiToken(user.token!)
                        appDelegate.setRoot(storyBoard: .landing, vc: .home)
                    }else{
                        print(user.code)
                        
                        self.performSegue(withIdentifier: "confirmLoginCode", sender: self)
                        
                    }
                   
                    print("User is logged in, his name: \(user.username ?? "nil") and his email: \(user.mobile ?? "nil")")
                    self.loginBtn.stopAnimating()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    
                }
                
            }
        }
    }
}
