//
//  JobDetailsVC.swift
//  Student
//
//  Created by MOHAB on 2/12/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit
import ObjectMapper

class JobDetailsVC: UIViewController {

    @IBOutlet weak var jobImage: UIImageView!
    
    @IBOutlet weak var ComponyName: UILabel!
    
    @IBOutlet weak var jobtitleTF: UILabel!
    
    @IBOutlet weak var EmailTF: UILabel!
    
    @IBOutlet weak var phoneTF: UILabel!
    
    @IBOutlet weak var totalExperince: UILabel!
    
    @IBOutlet weak var salaryTF: UILabel!
    
    @IBOutlet weak var residenceCountry: UILabel!
    
    @IBOutlet weak var ApplyBtn: UIButton!
    
    var job_id : Int?
    
    @IBOutlet weak var backBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        if job_id != nil {
            jobInfo(id: job_id!)
        }
    
        
    }
    @IBAction func ApplyAction(_ sender: Any) {
        
        guard let token = HelperToken.getapitoken() else {
            
            
            self.showAlertWithTitle(title: "", message: "you should login first", type: .error)
            HelperToken.restartApp("LoginVC")
            return
        }
        
        if let id = job_id {
        Applyjob(job_id: "\(id)")
            
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
}
extension JobDetailsVC {
    
    
    func jobInfo(id : Int){
        
        view.lock()
        DispatchQueue.main.async {
            //            self.subjectLabel.showAnimatedSkeleton()
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let manager = Manager()
            
            let param = [
                "language" : L102Language.currentAppleLanguage() ,
                "jobId" : "\(id)"
                
            ]
            
            manager.perform(methodType: .post, serviceName: .jobInfo, parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
                
                self.view.unlock()
                
                if String != nil {
                    
                    self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }else {
                    let response = JSON as! NSDictionary
                    
                    print(response)
                    
                    
                    
                    let Response : jobInfoModel = Mapper<jobInfoModel>().map(JSON: response as! [String : Any])!
                    
                    
                    
                  
                    self.ComponyName.text = Response.jobs?.companyName
                    self.jobtitleTF.text = Response.jobs?.job_title
                    self.EmailTF.text = Response.jobs?.email
                    self.phoneTF.text = Response.jobs?.phone
                    self.totalExperince.text = "\(Response.jobs?.total_experience ?? "") year(s)"
                    self.salaryTF.text = Response.jobs?.salary
                    self.residenceCountry.text = Response.jobs?.residence_country?.country
                    
                    var imageUrl = "http://apialhin.77carsael.com/\(Response.jobs?.image ?? "")"
                    
                   self.jobImage.loadImage(URL(string: imageUrl))
                    
                    self.view.unlock()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    
                }
                
            }
        }
        
        
        
    }
    func Applyjob(job_id : String){
        
        guard let token = HelperToken.getapitoken() else {
            
            let alert = UIAlertController(title: "you shold login first", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            
            
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                HelperToken.restartApp("LoginVC")
                
            }))
            
            self.present(alert, animated: true)
            return
        }
        view.lock()
        DispatchQueue.main.async {
            //            self.subjectLabel.showAnimatedSkeleton()
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let manager = Manager()
            
            let param = [
                "apiToken" : token ,
                // "cv_id" : ,
                "jobId" : job_id ,
                
                
                ]
            
            manager.perform(methodType: .post, serviceName: .ApplyJob , parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
                
                self.view.unlock()
                
                if String != nil {
                    
                    self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }else {
                    let response = JSON as! NSDictionary
                    
                    print(response)
                    
                    
                    
                    let Response : jobsNameModel = Mapper<jobsNameModel>().map(JSON: response as! [String : Any])!
                    
                    
                    
                    self.showStatus(image: #imageLiteral(resourceName: "images"), message: "Apply Suuceesfuly")
                    self.view.unlock()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    
                }
                
            }
        }
        
    }
    
    
}
