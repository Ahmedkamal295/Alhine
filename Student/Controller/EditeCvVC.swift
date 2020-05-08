//
//  EditeCvVC.swift
//  Student
//
//  Created by MOHAB on 2/12/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit
import ObjectMapper

class EditeCvVC: UIViewController {
    
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    

    var jobtitle = ""
    @IBOutlet weak var jobtitleTF: UITextField!
    
    var phone = ""
    @IBOutlet weak var phoneTF: UITextField!
    
    
    var salary = ""
    @IBOutlet weak var SalaryTF: UITextField!
    
    var date = ""
    @IBOutlet weak var dateTF: UITextField!
    
    
    var nationalitys = ""
    @IBOutlet weak var nationalitTF: UITextField!
    
    var matarialsatatus = ""
    @IBOutlet weak var matarialStatusTf: UITextField!
    
    var country = ""
    @IBOutlet weak var residenceCountryTF: UITextField!
    
    var religions = ""
    @IBOutlet weak var ReligionTF: UITextField!
    
    
    var totalexperience = ""
    @IBOutlet weak var totalExperinceTF: UITextField!
    
    
      var compony = ""
    
    @IBOutlet weak var ComponyTF: UITextField!
    
    var workexperience = ""
    @IBOutlet weak var WorkTotalExperinceTF: UITextField!
    
    
    var workjobtitle = ""
    @IBOutlet weak var workjobTitle: UITextField!
    
    var note = ""
    @IBOutlet weak var NoteTV: UITextView!
    
    
    var LocationsArray = [ResidenceCountry]()
    var jobsnameArray = [JobsName]()
    var religionArray = [Religiondata]()
    var nationalityArray = [NationalityData]()
    
    
    var jobName_id : Int?
    
    var location_id : Int?
    
    var religion_id : Int?
    
    var nationality_id : Int?
    
    var workJob_id : Int?
    
    var Jobtitle = UIPickerView()
    var location = UIPickerView()
    var religion = UIPickerView()
    var nationality = UIPickerView()
    var workJobtitle = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initViews()
        
        getLocations()
        
        getJobsNAme()
        
        getreligions()
        getNationality()
        
        
        self.jobtitleTF.inputView = Jobtitle
        self.residenceCountryTF.inputView = location
        self.ReligionTF.inputView = religion
        self.nationalitTF.inputView = nationality
        self.workjobTitle.inputView = workJobtitle
        
       
        
        
    }
    
    func initViews(){
        
        
        jobtitleTF.text = jobtitle
        jobtitleTF.setPadding(left: 20, right: 20)
        phoneTF.text = phone
        phoneTF.setPadding(left: 20, right: 20)
        SalaryTF.text = salary
        SalaryTF.setPadding(left: 20, right: 20)
        dateTF.text = date
        dateTF.setPadding(left: 20, right: 20)
        nationalitTF.text = nationalitys
        nationalitTF.setPadding(left: 20, right: 20)
        matarialStatusTf.text = matarialsatatus
        matarialStatusTf.setPadding(left: 20, right: 20)
        residenceCountryTF.text = country
        residenceCountryTF.setPadding(left: 20, right: 20)
        ReligionTF.text = religions
        ReligionTF.setPadding(left: 20, right: 20)
        totalExperinceTF.text = totalexperience
        totalExperinceTF.setPadding(left: 20, right: 20)
        WorkTotalExperinceTF.text = workjobtitle
        WorkTotalExperinceTF.setPadding(left: 20, right: 20)
        ComponyTF.text = compony
        ComponyTF.setPadding(left: 20, right: 20)
        WorkTotalExperinceTF.text = workexperience
        WorkTotalExperinceTF.setPadding(left: 20, right: 20)
        NoteTV.text = note
        
        
        
    }
    
    
    
    @IBAction func backAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    @IBAction func saveAction(_ sender: Any) {
        
        updateCV()
        
    }
    
    

}

extension EditeCvVC : UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    @IBAction func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        
        if textField == jobtitleTF {
            if jobsnameArray.count != 0 {
                jobtitleTF.text = jobsnameArray[0].name
                jobName_id = jobsnameArray[0].id
                
            }
        }else if textField == residenceCountryTF {
            if LocationsArray.count != 0 {
                residenceCountryTF.text = LocationsArray[0].country
                location_id = LocationsArray[0].id
            }
        }else if textField == ReligionTF {
            
            if religionArray.count != 0 {
                
                ReligionTF.text = religionArray[0].religion
                religion_id = religionArray[0].id
            }
            
        }else if textField == nationalitTF {
            
            nationalitTF.text = nationalityArray[0].nationality
            
            nationality_id = nationalityArray[0].id
        }else if textField == workjobTitle {
            if jobsnameArray.count != 0 {
                workjobTitle.text = jobsnameArray[0].name
               workJob_id = jobsnameArray[0].id
                
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
        if pickerView == Jobtitle {
            return jobsnameArray.count
        }else if pickerView == location{
            return LocationsArray.count
        }
        else if pickerView == religion {
            
            return religionArray.count
        }else if  pickerView == nationality {
            
            return nationalityArray.count
        }else if pickerView == workJobtitle {
            
            return jobsnameArray.count
        }else {
            
            return 0
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == Jobtitle{
            
            jobName_id = jobsnameArray[row].id
            
            return jobsnameArray[row].name
        }else if pickerView == location{
            
            
            location_id = LocationsArray[row].id
            
            return LocationsArray[row].country
        }else if pickerView == religion {
            
            
            religion_id = religionArray[row].id
            
            return religionArray[row].religion
        }else if pickerView == nationality {
            
            
            nationality_id = nationalityArray[row].id
            
            return nationalityArray[row].nationality
        }else if pickerView == workJobtitle {
            
            
            workJob_id = jobsnameArray[row].id
            
            return jobsnameArray[row].name
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == Jobtitle {
            jobtitleTF.text = jobsnameArray[row].name
            jobName_id = jobsnameArray[row].id
            
            
        }
        else if pickerView == location{
            residenceCountryTF.text = LocationsArray[row].country
            location_id = LocationsArray[row].id
            
            
        }else if pickerView == religion {
            ReligionTF.text = religionArray[row].religion
            religion_id = religionArray[row].id
            
            
        }else if pickerView == nationality {
            nationalitTF.text = nationalityArray[row].nationality
            nationality_id = nationalityArray[row].id
            
            
        }else if pickerView == workJobtitle {
            workjobTitle.text = jobsnameArray[row].name
            workJob_id = jobsnameArray[row].id
            
            
        }
    }
}


extension EditeCvVC {
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
    
    func getJobsNAme(){
        
        
        view.lock()
        DispatchQueue.main.async {
            //            self.subjectLabel.showAnimatedSkeleton()
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let manager = Manager()
            
            let param = [
                "language" : L102Language.currentAppleLanguage()
                
            ]
            
            manager.perform(methodType: .post, serviceName: .jobsName, parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
                
                self.view.unlock()
                
                if String != nil {
                    
                    self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }else {
                    let response = JSON as! NSDictionary
                    
                    print(response)
                    
                    
                    
                    let Response : jobsNameModel = Mapper<jobsNameModel>().map(JSON: response as! [String : Any])!
                    
                    
                    
                    self.jobsnameArray = Response.jobsName ?? []
                    self.initPickers(picker: self.Jobtitle)
                      self.initPickers(picker: self.workJobtitle)
                    print(self.jobsnameArray)
                    
                    self.view.unlock()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    
                }
                
            }
        }
        
    }
    
    
    func getreligions(){
        
        
        view.lock()
        DispatchQueue.main.async {
            //            self.subjectLabel.showAnimatedSkeleton()
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let manager = Manager()
            
            let param = [
                "language" : L102Language.currentAppleLanguage()
                
            ]
            
            manager.perform(methodType: .post, serviceName: .religion, parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
                
                self.view.unlock()
                
                if String != nil {
                    
                    self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }else {
                    let response = JSON as! NSDictionary
                    
                    print(response)
                    
                    
                    
                    let Response : ReligionModel = Mapper<ReligionModel>().map(JSON: response as! [String : Any])!
                    
                    
                    self.religionArray = Response.religion ?? []
                   
                    self.initPickers(picker: self.religion)
                    print(self.jobsnameArray)
                    
                    self.view.unlock()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    
                }
                
            }
        }
        
    }
    
    
    func getNationality(){
        
        
        view.lock()
        DispatchQueue.main.async {
            //            self.subjectLabel.showAnimatedSkeleton()
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let manager = Manager()
            
            let param = [
                "language" : L102Language.currentAppleLanguage()
                
            ]
            
            manager.perform(methodType: .post, serviceName: .nationality, parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
                
                self.view.unlock()
                
                if String != nil {
                    
                    self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }else {
                    let response = JSON as! NSDictionary
                    
                    print(response)
                    
                    
                    
                    let Response : nationalityModel = Mapper<nationalityModel>().map(JSON: response as! [String : Any])!
                    
                    
                    self.nationalityArray = Response.nationality ?? []
                    
                    self.initPickers(picker: self.nationality)
                   
                    
                    self.view.unlock()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    
                }
                
            }
        }
        
    }
}


extension EditeCvVC {
    
    
    func updateCV(){
        
        
        view.lock()
        DispatchQueue.main.async {
            //            self.subjectLabel.showAnimatedSkeleton()
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let manager = Manager()
            
            guard let token = HelperToken.getapitoken() else {
                
                let alert = UIAlertController(title: "you shold login first", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                
                
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    
                    HelperToken.restartApp("LoginVC")
                    
                }))
                
                self.present(alert, animated: true)
                return
            }
            
           
                
                
            let param = [
                "apiToken" : token ,
                
                
                "phone" : self.phoneTF.text ?? "" ,
                "date_of_birth" : self.dateTF.text ?? "" ,
              //  "martial_status" : "" ,
                
                
                "expectedSalary" : self.SalaryTF.text ?? "" ,
                
                "residence_country_id" : "\(self.location_id ?? 0)" ,
                "religion_id" : "\(self.religion_id ?? 0)" ,
               // "total_experience" : "" ,
                "job_title" : self.jobtitleTF.text ?? "" ,
                "note" : self.NoteTV.text ?? "",
                "nationality_id" : "\(self.nationality_id ?? 0)" ,
              //  "work_experience_job_title" : "" ,
                "work_experience_company_name" : self.ComponyTF.text ?? "" ,
              //  "work_experience_experirnce_years" : ""
                
                ] as [String : Any]
          
            
            manager.perform(methodType: .post, serviceName: .updateCV, parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
                
                self.view.unlock()
                
                if String != nil {
                    
                    self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }else {
                    let response = JSON as! NSDictionary
                    
                    print(response)
                    
                    
                    
                    let Response : nationalityModel = Mapper<nationalityModel>().map(JSON: response as! [String : Any])!
                    
                  
                    self.showStatus(image: #imageLiteral(resourceName: "images"), message: "Done")
                    self.view.unlock()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    
                }
                
            }
        }
        
    }
    
    
}
