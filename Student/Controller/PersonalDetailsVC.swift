//
//  PersonalDetailsVC.swift
//  Student
//
//  Created by MOHAB on 1/31/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit
import ObjectMapper

class PersonalDetailsVC: UIViewController {

    @IBOutlet weak var JobImage: UIImageView!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var editeBtn: UIButton!
    
    
    @IBOutlet weak var jobtitleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dateofbirthLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    
    @IBOutlet weak var matarialStatus: UILabel!
    
    @IBOutlet weak var residienceCountryLabel: UILabel!
    
    @IBOutlet weak var religionLabel: UILabel!
    
    
    @IBOutlet weak var totalExperienceLabel: UILabel!
    
    @IBOutlet weak var WorkJobtitleLabel: UILabel!
    
    
    @IBOutlet weak var CountryNameLabel: UILabel!
    
    @IBOutlet weak var noOfExperience: UILabel!
    
    
    @IBOutlet weak var noteTV: UITextView!
    
    
    
    
    
    
    
    
    
    
    
    
    
    var cv_id : Int?
    
    var salar = "0"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let token = HelperToken.getapitoken() else {
            
            
            self.showAlertWithTitle(title: "", message: "you should login first", type: .error)
             HelperToken.restartApp("LoginVC")
            return
        }
  
        if let id = cv_id {
            
            getCvDetails(cv_id : id)
            
        }else {
            getpersonalCvCv()
            
        }
        
        
    }
    
    @IBAction func editeAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "EditeCvVC") as! EditeCvVC
       
        vc.jobtitle = self.jobtitleLabel.text ?? ""
        vc.phone = self.phoneLabel.text ?? ""
        vc.salary = self.salar 
        vc.date = self.dateofbirthLabel.text ?? ""
        vc.nationalitys = self.nationalityLabel.text ?? ""
        vc.matarialsatatus = self.matarialStatus.text ?? ""
        vc.country = self.residienceCountryLabel.text ?? ""
        vc.religions = self.religionLabel.text ?? ""
        vc.totalexperience = self.totalExperienceLabel.text ?? ""
        vc.workjobtitle = self.WorkJobtitleLabel.text ?? ""
        vc.compony = self.CountryNameLabel.text ?? ""
        vc.workexperience = self.noOfExperience.text ?? ""
        vc.note = self.noteTV.text ?? ""
        
        
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    

    @IBAction func backAction(_ sender: Any) {
   
    
    navigationController?.popViewController(animated: true)
    
    }
    
    
}


extension PersonalDetailsVC  {
    
    
    func getCvDetails(cv_id : Int){
        
        
        
        view.lock()
        DispatchQueue.main.async {
            //            self.subjectLabel.showAnimatedSkeleton()
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let manager = Manager()
        
            
            let param = [
                "language" : L102Language.currentAppleLanguage() ,
                "cvId" : "\(cv_id)"
                
                
            ]
            
            manager.perform(methodType: .post, serviceName: .cvInfo, parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
                
                self.view.unlock()
                
                if String != nil {
                    
                    self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }else {
                    let response = JSON as! NSDictionary
                    
                    print(response)
                    
                    let Response : cvInfoModel = Mapper<cvInfoModel>().map(JSON: response as! [String : Any])!
                    
                    
                    self.jobtitleLabel.text = Response.cv?.job_title
                    self.nameLabel.text = Response.cv?.username
                    self.phoneLabel.text = Response.cv?.phone
                    self.dateofbirthLabel.text = Response.cv?.date_of_birth
                    self.emailLabel.text = Response.cv?.email
                    self.nationalityLabel.text = Response.cv?.nationality?.nationality
                    self.matarialStatus.text = Response.cv?.martial_status
                    self.religionLabel.text = Response.cv?.religion?.religion
                    self.totalExperienceLabel.text = "\(Response.cv?.total_experience ?? "") year(s)"
               
                    self.residienceCountryLabel.text = Response.cv?.residence_country?.country
                    
                    self.WorkJobtitleLabel.text = Response.cv?.work_experience_job_title
                    self.CountryNameLabel.text = Response.cv?.work_experience_company_name
                    self.noOfExperience.text = "\(Response.cv?.work_experience_experirnce_years ?? "") year(s)"
                    
                    self.noteTV.text = Response.cv?.note
                    self.salar = Response.cv?.expectedSalary ?? ""
                    print(Response)
                    
                    var imageUrl = "http://apialhin.77carsael.com/\(Response.cv?.photo ?? "")"
                    
                    self.JobImage.loadImage(URL(string: imageUrl))
                    self.view.unlock()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    
                }
                
            }
        }
        
    }
    
    
    
}
extension PersonalDetailsVC {
    
    
    
    func getpersonalCvCv(){
        
        
        
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
                "language" : L102Language.currentAppleLanguage() ,
                "apiToken" : "\(token)"
                
                
            ]
            
            manager.perform(methodType: .post, serviceName: .personalCv, parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
                
                self.view.unlock()
                
                if String != nil {
                    
                    self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }else {
                    let response = JSON as! NSDictionary
                    
                    print(response)
                    
                    let Response : cvInfoModel = Mapper<cvInfoModel>().map(JSON: response as! [String : Any])!
                    
                    
                    self.jobtitleLabel.text = Response.cv?.job_title
                    self.nameLabel.text = Response.cv?.username
                    self.phoneLabel.text = Response.cv?.phone
                    self.dateofbirthLabel.text = Response.cv?.date_of_birth
                    self.emailLabel.text = Response.cv?.email
                    self.nationalityLabel.text = Response.cv?.nationality?.nationality
                    self.matarialStatus.text = Response.cv?.martial_status
                    self.religionLabel.text = Response.cv?.religion?.religion
                    self.totalExperienceLabel.text = "\(Response.cv?.total_experience ?? "") year(s)"
                    
                    self.residienceCountryLabel.text = Response.cv?.residence_country?.country
                    
                    self.WorkJobtitleLabel.text = Response.cv?.work_experience_job_title
                    self.CountryNameLabel.text = Response.cv?.work_experience_company_name
                    self.noOfExperience.text = "\(Response.cv?.work_experience_experirnce_years ?? "") year(s)"
                    
                    self.noteTV.text = Response.cv?.note
                    
                    print(Response)
                    
                    
                    self.view.unlock()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    
                }
                
            }
        }
        
    }
    
    
    
}
