//
//  CVListVC.swift
//  Student
//
//  Created by MOHAB on 1/31/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit
import ObjectMapper




class CVListVC: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cvLabel: UILabel!
    
    var cvArray = [Cv]()
     var jobsnameArray = [JobsName]()
    
    var Jobtitle = UIPickerView()
     var jobName_id : Int?

    @IBOutlet weak var jobtitleTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if L102Language.currentAppleLanguage() == "ar" {
            
            cvLabel.text = "قائمة السيرة الذاتية"
            
        }
        
        jobtitleTF.setPadding(left: 40, right: 40)
        
        getJobsNAme()
           self.jobtitleTF.inputView = Jobtitle
        
          navigationController?.isNavigationBarHidden = true
  tableView.separatorStyle = .none
     tableView.dataSource = self
        tableView.delegate = self
        getcvList()
        
    }
    

    

}

extension CVListVC : UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    @IBAction func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        
        
            if jobsnameArray.count != 0 {
                jobtitleTF.text = jobsnameArray[0].name
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
            jobtitleTF.text = jobsnameArray[row].name
            jobName_id = jobsnameArray[row].id
          getcvList()
            
        }
        
    }
}

extension CVListVC : isVavourite {
    func reFavourite(indexpath: Int) {
       
        
        makeFAvourite(cv_id: "\(cvArray[indexpath].id ?? 0)")
        
        cvArray[indexpath].isFav = true
        
        tableView.reloadData()
        
    }
    
    
    
    
    
}

extension CVListVC : ViewCv {
    func ViewCv(indexpath: Int) {
    
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "PersonalDetailsVC") as! PersonalDetailsVC
       
        vc.cv_id = cvArray[indexpath].id
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
}


extension CVListVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cvArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CvCell", for: indexPath) as! CvCell
        
        var data = cvArray[indexPath.row]
        
        cell.delegate = self
        cell.FavouriteBtn.tag = indexPath.row
        cell.viewCVDelegate = self
        cell.ApplyBtn.tag = indexPath.row
        cell.jobTitleTF.text = data.job_title
        cell.ComynameLabel.text = data.employeeName
        cell.PriceLabel.text = ""
        cell.ratingLabel.text = "\(data.rate ?? 0)"
        cell.reviewLabel.text =  "\(data.review ?? "") Reviews"  
        var imageUrl = "http://apialhin.77carsael.com/\(data.photo ?? "")"
        
        
        cell.IMGView.loadImage(URL(string: imageUrl))
        
        if cvArray[indexPath.row].isFav ?? false {
        cell.FavouriteBtn.setImage(#imageLiteral(resourceName: "isfavouriteIcon"), for: .normal)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}
extension CVListVC {
    
    
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
    
    
    
    
    func getcvList(){
        
        
        
        view.lock()
        DispatchQueue.main.async {
            //            self.subjectLabel.showAnimatedSkeleton()
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let manager = Manager()
            
             var param = [
            
               "language" : L102Language.currentAppleLanguage()
            
            ]
            
            if let job_name = self.jobtitleTF.text {
             param = [
                "language" : L102Language.currentAppleLanguage() ,
                "job_title" : job_name ,
                //            "total_experience" : "1" ,
                //            "newer" : "true"
                
                
            ]
            }
            
            manager.perform(methodType: .post, serviceName: .cv, parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
                
                self.view.unlock()
                
                if String != nil {
                    
                    self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }else {
                    let response = JSON as! NSDictionary
                    
                    print(response)
                    
                    let Response : CvModel = Mapper<CvModel>().map(JSON: response as! [String : Any])!
                    
                    
                self.cvArray = Response.cv ?? []
                    
                    
                    
                    self.tableView.reloadData()
                    
                    print(Response)
                    
                    
                    self.view.unlock()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    
                }
                
            }
        }
        
    }
    func makeFAvourite(cv_id : String){
        
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
                "cv_id" : cv_id,
                //"job_id" :  ,
                
                
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
    
    
    
    
}
