//
//  jobListVC.swift
//  Student
//
//  Created by MOHAB on 1/31/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit
import ObjectMapper

class jobListVC: UIViewController {

    
    @IBOutlet weak var JobListTF: UITextField!
    
    var jobName = ""

    var country_id :Int?
    
    var JobsArray = [Jobs]()
    var jobsnameArray = [JobsName]()
    
    var Jobtitle = UIPickerView()
    var jobName_id : Int?
    
    @IBOutlet weak var jobnameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if L102Language.currentAppleLanguage() == "ar" {
            
            jobnameLabel.text = "قائمة الوظائف"
            
            
        }
        
        getJobsNAme()
        getJobsList()
        JobListTF.setPadding(left: 40, right: 40)
        JobListTF.inputView = Jobtitle
       
        
        JobListTF.text = jobName

        self.tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
    }
    

   
    
}

extension jobListVC : isVavourite {
    func reFavourite(indexpath: Int) {
        
        makeFAvourite(job_id: "\(JobsArray[indexpath].id ?? 0)")
    JobsArray[indexpath].isFav = true
        tableView.reloadData()
   
        
    }
    
    
    
    
    
}

extension jobListVC : Apply {
    func applyjob(indexpath: Int) {
        
//      Applyjob(job_id: "\(JobsArray[indexpath].id ?? 0)")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "JobDetailsVC") as! JobDetailsVC
        vc.job_id = JobsArray[indexpath].id
      
        // present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}

extension jobListVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JobsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobsCell", for: indexPath) as! jobsCell
        
        var data = JobsArray[indexPath.row]
        cell.delegate = self
        cell.favouriteBtn.tag = indexPath.row
        cell.applyDelegate = self
        cell.ApplyBtn.tag = indexPath.row
        
        
        cell.jobTitleTF.text = data.job_title
        cell.ComponyName.text = data.companyName
        var imageUrl = "http://apialhin.77carsael.com/\(data.image ?? "")"
        cell.PriceLabel.text = "$ \(data.salary ?? "")"
        cell.ImgView.loadImage(URL(string: imageUrl))
        cell.ratingLabel.text = "\(data.rate ?? 0)"
        cell.reviewLabel.text = "\(data.review ?? "") Reviews"  
        
        if data.isFav ?? false {
            
            cell.favouriteBtn.setImage(#imageLiteral(resourceName: "isfavouriteIcon"), for: .normal)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "JobDetailsVC") as! JobDetailsVC
        
        vc.job_id = JobsArray[indexPath.row].id
        
        
        
        navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    
}
extension jobListVC : UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    @IBAction func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        
        
        if jobsnameArray.count != 0 {
            JobListTF.text = jobsnameArray[0].name
            jobName_id = jobsnameArray[0].id
            
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
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == Jobtitle{
            
            jobName_id = jobsnameArray[row].id
            
            return jobsnameArray[row].name
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == Jobtitle {
            JobListTF.text = jobsnameArray[row].name
            jobName_id = jobsnameArray[row].id
             getJobsList()
            
        }
        
    }
}
extension jobListVC {
    
    
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
                    print(self.jobsnameArray)
                    
                    self.view.unlock()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    
                }
                
            }
        }
        
    }
    
    
    
func getJobsList(){
    
    
    
    view.lock()
    DispatchQueue.main.async {
        //            self.subjectLabel.showAnimatedSkeleton()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let manager = Manager()
        
       var param = [
        
        String : Any
        
        ]()
        
        if let country_Id = self.country_id , let jobname_id = self.jobName_id {

        param = [
            "language" : L102Language.currentAppleLanguage() ,
            "residence_country_id" : country_Id  ,
            "job_title" : jobname_id ,
//            "total_experience" : "1" ,
//            "newer" : "true"
            
            
        ]
        }else if let country_Id = self.country_id {
            
            param = [
                "language" : L102Language.currentAppleLanguage() ,
                "residence_country_id" : country_Id  ,
               
                
                
            ]
            
        }else if let jobname_id = self.jobName_id {
            
            param = [
                "language" : L102Language.currentAppleLanguage() ,
               
                "job_title" : jobname_id ,
                //            "total_experience" : "1" ,
                //            "newer" : "true"
                
                
            ]
            
        }
        
        manager.perform(methodType: .post, serviceName: .recomendedJobs, parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
            }else {
                let response = JSON as! NSDictionary
                
                print(response)
                
                let Response : JobListModel = Mapper<JobListModel>().map(JSON: response as! [String : Any])!
                
                
                self.JobsArray = Response.jobs ?? []
                
           
                
                self.tableView.reloadData()
                
                print(Response)
                
                
                self.view.unlock()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                
            }
            
        }
    }
    
}

    func makeFAvourite(job_id : String){
        
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
                "job_id" : job_id ,
                
                
            ]
            
            manager.perform(methodType: .post, serviceName: .makeFavourite, parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
                
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
                    print(self.jobsnameArray)
                    
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
