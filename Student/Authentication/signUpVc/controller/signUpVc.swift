//
//  signUpVc.swift
//  Terhal
//
//  Created by mahroUS on 2/10/1441 AH.
//  Copyright © 1441 AH mahroUS. All rights reserved.
//

import UIKit
import ObjectMapper
import MapKit
import CoreLocation
import Contacts
class signUpVc: UIViewController ,UIPickerViewDataSource,UIPickerViewDelegate,MKMapViewDelegate, CLLocationManagerDelegate{
  
    let manager = CLLocationManager()
    let lat = 31.265656522
    let long = 32.262622622
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var bacGroundImg: UIImageView!
    @IBOutlet weak var iconImg: UIImageView!
 
    @IBOutlet weak var userNameTxt: DesignableUITextField!
    @IBOutlet weak var emailTxt: DesignableUITextField!
    @IBOutlet weak var phoneNumberTxt: DesignableUITextField!
    @IBOutlet weak var gender: DesignableUITextField!
    @IBOutlet weak var dateOfBirthTxt: DesignableUITextField!
    @IBOutlet weak var passwordTxt: DesignableUITextField!
    @IBOutlet weak var confirmPasswordTxt: DesignableUITextField!
    @IBOutlet weak var signUp: UIButton!
   
    
    var pickerOfDate = UIDatePicker()
    
    
    var picker = UIPickerView()
    var genderId: Int?
    var genderList = ["male".localized,"female".localized]
    
    var socialRegiester : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        gender.inputView = picker
        dateOfBirthTxt.inputView = pickerOfDate
        initPickers(picker: picker)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateOfBirthTxt.text = formatter.string(from: pickerOfDate.date)
        self.view.endEditing(true)
        // Do any additional setup after loading the view.
    }
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        let uuid = NSUUID().uuidString
        
        if  isNotEmptyString(text: self.userNameTxt.text!, withAlertMessage: "please Enter User Name".localized) &&
            isNotEmptyString(text: self.emailTxt.text!, withAlertMessage: "please insert Email".localized) &&
            isNotEmptyString(text: self.phoneNumberTxt.text!, withAlertMessage: "please insert Phone Number".localized) &&
            isNotEmptyString(text: self.gender.text!, withAlertMessage: "please insert Gender".localized) &&
            isNotEmptyString(text: self.dateOfBirthTxt.text!, withAlertMessage: "please insert Birthday".localized) &&
            isNotEmptyString(text: self.passwordTxt.text!, withAlertMessage: "please insert Password".localized)  &&
            isNotEmptyString(text: self.confirmPasswordTxt.text!, withAlertMessage: "please insert Confirm Password".localized)
{
    
    if self.passwordTxt.text! == self.confirmPasswordTxt.text! {
        if self.socialRegiester == false{
            if self.emailTxt.text != "" {
                if isValidEmail(testStr: self.emailTxt.text!){
                    let params = ["username": self.userNameTxt.text! as AnyObject,
                                  "email": self.emailTxt.text!  as AnyObject,
                                  "mobile": self.phoneNumberTxt.text! as AnyObject,
                                  "gender": self.gender.text! as AnyObject,
                                  "birthday": self.dateOfBirthTxt.text! as AnyObject,
                                  "password": self.passwordTxt.text! as AnyObject,
                                  "lat": self.lat,"lng": self.long,
                                  "serial_num":"123",
                                  "serial_num": uuid,
                                  "device_token" : UserDefaults.standard.value(forKey: "mobileToken")]as[String:AnyObject]
                    signUP(parameters: params)
                }else{
                    self.showAlertWithTitle(title: "Warning".localized, message: "please insert correct email".localized, type: .error)
                }
            }else{
                let params = ["username": self.userNameTxt.text!,
                                            "email": self.emailTxt.text!,
                                            "mobile": self.phoneNumberTxt.text!,
                                            "gender": self.gender.text!,
                                            "birthday": self.dateOfBirthTxt.text!,
                                            "password": self.passwordTxt.text!,
                                             "lat": self.lat,"lng": self.long,
                                             "serial_num":"123",
                                            "serial_num": uuid,
                                            "device_token" : UserDefaults.standard.value(forKey: "mobileToken")]as[String:AnyObject]
                signUP(parameters: params)
            }
        }else{
            let params = ["username": self.userNameTxt.text!,
                          "email": self.emailTxt.text!,
                          "mobile": self.phoneNumberTxt.text!,
                          "gender": self.gender.text!,
                          "birthday": self.dateOfBirthTxt.text!,
                          "lat": self.lat,"lng": self.long,
                          "serial_num":"123",
                          "password": self.passwordTxt.text!,
                          "serial_num": uuid,
                          "device_token" : UserDefaults.standard.value(forKey: "mobileToken")]as[String:AnyObject]
           

            signUP(parameters: params )
        }
        
        
    }else{
        self.showAlertWithTitle(title: "Warning".localized, message: "password don't matching ".localized, type: .error)
        }
     }
    }
    @IBAction func iHaveAccBtn(_ sender: Any) {
        let backToSign = storyboard?.instantiateViewController(withIdentifier: "logInVc") as? logInVc
        present(backToSign!,animated: false)
    }
    
}


extension signUpVc {
    
    func signUP(parameters: [String: AnyObject]) {
        DispatchQueue.main.async {
            let manager = Manager()
            self.signUp.startAnimating(with: #colorLiteral(red: 0.8944095373, green: 0.7580962181, blue: 0, alpha: 1))
            manager.perform(methodType: .post, serviceName: .register, parameters: parameters) { (JSON, String) -> Void in

                if String != nil {
                    self.showAlertWithTitle(title: "Warning".localized, message: String!, type: .error)
                    self.signUp.stopAnimating()
                    Vibration.error.vibrate()

                }else {

                    let response = JSON as! NSDictionary

                    let user: User = Mapper<User>().map(JSON: response["data"] as! [String : Any])!

                    User.shared.setIsRegister(registered: true)
                    Vibration.success.vibrate()
                    User.shared.fillUserModel(model: user)
                    User.shared.saveData()
                    User.shared.setApiToken(user.token!)
                    appDelegate.setRoot(storyBoard: .landing, vc: .home)
                    print("User is logged in, his name: \(user.email ?? "nil") and his email: \(user.username ?? "nil")")
                    self.signUp.stopAnimating()

                }

            }
        }

    }
    
}
extension signUpVc {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      
        return 2
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender.text =  genderList[row]
    }
    func initPickers(picker: UIPickerView) {
        picker.dataSource = self
        picker.delegate = self
        picker.tintColor = #colorLiteral(red: 0.840886116, green: 0.6630725861, blue: 0.2519706488, alpha: 1)
        picker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        picker.layer.cornerRadius = 13
    }

    
    @objc func donedatePicker(){
        
      
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
}

