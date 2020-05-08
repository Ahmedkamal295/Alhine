//
//  UploadJobVC.swift
//  Student
//
//  Created by MOHAB on 2/17/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class UploadJobVC: UIViewController {

    
    @IBOutlet weak var IMGView: UIImageView!
    
    @IBOutlet weak var ComponyNameTf: UITextField!
    
    
    @IBOutlet weak var jobtitleTF: UITextField!
    
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var EmailTf: UITextField!
    
    @IBOutlet weak var totalExperinceTF: UITextField!
    
    @IBOutlet weak var SalaryTF: UITextField!
    
    @IBOutlet weak var residenceCountryTF: UITextField!
    @IBOutlet weak var backBtn: UIButton!
    
     var LocationsArray = [ResidenceCountry]()
     var location_id : Int?
    
     var location = UIPickerView()
    
    @IBOutlet weak var publishBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let token = HelperToken.getapitoken() else {
            
            
            self.showAlertWithTitle(title: "", message: "you should login first", type: .error)
            HelperToken.restartApp("LoginVC")
            return
        }
        
        
         getLocations()
          self.residenceCountryTF.inputView = location

        GesterRecognizerFu()
        
        
    }
    func GesterRecognizerFu(){
        let TapregognizerIm = UITapGestureRecognizer(target: self, action: #selector(showAllImageToChose))
        TapregognizerIm.numberOfTapsRequired = 1
        self.IMGView.addGestureRecognizer(TapregognizerIm)
        self.IMGView.isUserInteractionEnabled = true
    }
    
    @objc func showAllImageToChose(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func backAction(_ sender: Any) {
    }
    
    
    @IBAction func PublishAction(_ sender: Any) {
        
        if isNotEmptyString(text: ComponyNameTf.text!, withAlertMessage: "please insert Compony name") ,isNotEmptyString(text: jobtitleTF.text!, withAlertMessage: "please insert job title") ,isNotEmptyString(text: phoneNumberTF.text!, withAlertMessage: "please insert phone number") , isNotEmptyString(text: EmailTf.text! , withAlertMessage: "please insert email") ,isNotEmptyString(text: totalExperinceTF.text!, withAlertMessage: "please insert total experince") ,isNotEmptyString(text: SalaryTF.text!, withAlertMessage: "please insert salary"), isNotEmptyString(text: residenceCountryTF.text!, withAlertMessage: "please insert resident compony") {
            
            
            publishJob()
            
            
        }
        
    }
    
  
    
}

extension UploadJobVC : UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
@IBAction func textFieldDidBeginEditing(_ textField: UITextField) {
    
    
    
    if textField  == residenceCountryTF {
        if LocationsArray.count != 0 {
            residenceCountryTF.text = LocationsArray[0].country
            location_id = LocationsArray[0].id
        }
    }
    
    
}


// MARK: - Action Picker Delegate
func initPickers(picker: UIPickerView) {
    picker.dataSource = self
    picker.delegate = self
    picker.tintColor = #colorLiteral(red: 0.840886116, green: 0.6630725861, blue: 0.2519706488, alpha: 1)
    picker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
}

func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
}

func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView == location {
        return LocationsArray.count
    }else {
        
        return 0
    }
    
    
}

func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerView == location{
        
        
        location_id = LocationsArray[row].id
        
        return LocationsArray[row].country
    }
    return ""
}

func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView == location {
        residenceCountryTF.text = LocationsArray[row].country
        location_id = LocationsArray[row].id
        print(location_id)
        
    }
   
}
}

extension UploadJobVC {
    
    func publishJob(){
    
        
        guard let api_token = Helper.getapitoken() else {
            
      
            let alert = UIAlertController(title: "you shold login first", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            
            
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                HelperToken.restartApp("LoginVC")
                
            }))
            
            self.present(alert, animated: true)
            
            return
        }
        
           view.lock()
            
            let image1 = IMGView.image
            let imageData1 =  image1?.jpegData(compressionQuality: 0.2)
            
        
            
            guard imageData1 != nil  else {
                
                if L102Language.currentAppleLanguage() == "ar" {
                    
                    self.showAlertWithTitle(title: "", message: "يجب ان تختار الصورة الصورة اولا", type: .warning)
                }else {
                    
                    self.showAlertWithTitle(title: "", message: "you should select photo first", type: .warning)
                    
                }
               self.view.unlock()
                return
            }
            
            
        print("----------------------------->",imageData1, "----------------------->")
            print(IMGView.image)
            
            let url =  "http://apialhin.77carsael.com/api/job/add"
            let lang = L102Language.currentAppleLanguage() == "en" ? "en" : "ar"
            
            
            
            let parameters = [
                
                "apiToken" : api_token ,
                "phone" : phoneNumberTF.text! ,
                // "image" : "" ,
                "residence_country_id" : "\(location_id!)",
                "total_experience" : totalExperinceTF.text! ,
                "job_title" : self.jobtitleTF.text!,
                "companyName" : ComponyNameTf.text!,
                "salary"  : SalaryTF.text! ,
                "email" : self.EmailTf.text! ,
                "total_exprience" : self.totalExperinceTF.text! ,
              
         
               
                ]
            
            
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                }
                if imageData1 != nil {
                   
                    multipartFormData.append(imageData1!, withName: "image", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                }
                
            }, to:"http://apialhin.77carsael.com/api/job/add")
            { (result) in
                
                
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (Progress) in
                        print("Upload Progress: \(Progress.fractionCompleted)")
                    })
                    
                    upload.responseJSON { response in
                       self.view.unlock()
//                        //self.delegate?.showSuccessAlert()
//                        print(response.request)  // original URL request
//                        print(response.response) // URL response
//                        print(response.data)     // server data
//                        print(response.result)   // result of response serialization
//                        //                        self.showSuccesAlert()
//                        //self.removeImage("frame", fileExtension: "txt")
                        if let JSON = response.result.value as? [String : Any] {
                            
                            
                            
                            print("JSON: \(JSON)")
                            
                            if JSON["message"] as? String == "done" {
                              
                                
                               self.showStatus(image: #imageLiteral(resourceName: "images"), message: "Added successfully")
                                
                                
                              
                            }else {
                                var msg = JSON["message"] as? String
                                
                                self.showAlertWithTitle(title: "", message: msg ?? "", type: .error)
                                
                            }
                        
                        
                        
                    }
                    }
                    
                    
                    
                case .failure(let encodingError):
                    //self.delegate?.showFailAlert()
                    print("A7A")
                    self.view.unlock()
                    print(encodingError)
                }
                
        }
    }
    func getLocations(){
        
        
        view.lock()
        DispatchQueue.main.async {
            //            self.subjectLabel.showAnimatedSkeleton()
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let manager = Manager()
            
            let param = [
                "language" : L102Language.currentAppleLanguage()
                
            ]
            
            manager.perform(methodType: .post, serviceName: .Locations, parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
                
                self.view.unlock()
                
                if String != nil {
                    
                    self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }else {
                    let response = JSON as! NSDictionary
                    
                    print(response)
                    
                    let Response : LocationsModel = Mapper<LocationsModel>().map(JSON: response as! [String : Any])!
                    
                    
                    
                    
                    self.LocationsArray = Response.residenceCountry ?? []
                    self.initPickers(picker: self.location)
                    print(self.LocationsArray)
                    
                    self.view.unlock()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    
                }
                
            }
        }
        
    }
}

extension  UploadJobVC :UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
       
            if let image = info[.originalImage] as? UIImage{
                self.IMGView.image = image
            }else{
                if let imageEdit = info[.editedImage] as? UIImage{
                    self.IMGView.image = imageEdit
                }
          
        }
    
}
}
