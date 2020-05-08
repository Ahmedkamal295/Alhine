//
//  HomeVC.swift
//  Student
//
//  Created by MOHAB on 1/31/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit
import ObjectMapper

class HomeVC: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var jobtitleTF: UITextField!
    @IBOutlet weak var LocationTF: UITextField!
    
    @IBOutlet weak var searchBtn: UIButton!
    
    
    @IBOutlet weak var homeLabel: UILabel!
    
    
    
    
     var Jobtitle = UIPickerView()
    var location = UIPickerView()
    
    var LocationsArray = [ResidenceCountry]()
    var jobsnameArray = [JobsName]()
    var recomendedJobsArray = [Jobs]()
    
    @IBOutlet weak var RecomendedLabel: UILabel!
    var jobName_id : Int?
    
    var location_id : Int?
    
    @IBOutlet weak var searchMillionLabel: UILabel!
    
    func initViews(){
        
        if L102Language.currentAppleLanguage() == "ar" {
            RecomendedLabel.text = "الوظائف المقترحة"
            searchMillionLabel.text = "بحث عن مليون وظيفة"
            jobtitleTF.placeholder = "عنوان الوظيفة"
            LocationTF.placeholder = "الدول"
            searchBtn.setTitle("البحث", for: .normal)
            homeLabel.text = "الرئيسية"
            
        }
        
        
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        
        getLocations()
        
        getJobsNAme()
        
        getRecomendedJobs()
        
        self.jobtitleTF.inputView = Jobtitle
        self.LocationTF.inputView = location
         let tapSelectContry = UITapGestureRecognizer(target: self, action: #selector(selectContry(_:)))
        
        navigationController?.isNavigationBarHidden = true
        
      setShadow(view: jobtitleTF, width: 1, height: 1, shadowRadius: 2, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.2967801094, green: 0.7321691513, blue: 0.8268392086, alpha: 1))
         setShadow(view: LocationTF, width: 1, height: 1, shadowRadius: 2, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.2967801094, green: 0.7321691513, blue: 0.8268392086, alpha: 1))
        setShadow(view: searchBtn, width: 1, height: 1, shadowRadius: 2, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        
        jobtitleTF.setPadding(left: 40, right: 40)
        LocationTF.setPadding(left: 40, right: 40)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    @objc func selectContry(_ sender:UITapGestureRecognizer){
        
        print("Done")
        showStatus(image: #imageLiteral(resourceName: "ic_star"), message: "profile")
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func menueAction(_ sender: Any) {
        
        if L102Language.currentAppleLanguage() == englishLang {
            panel?.openLeft(animated: true)
        }else{
            panel?.openRight(animated: true)
        }
        
        
    }
    
    @IBAction func notificationAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
         present(vc, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func SearchAction(_ sender: Any) {
        //getRecomendedJobs()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "jobListVC") as! jobListVC
        print(self.jobtitleTF.text)
     
        vc.jobName = self.jobtitleTF.text ?? ""
        vc.jobName_id = self.jobName_id
        vc.country_id = self.location_id
        
        navigationController?.pushViewController(vc, animated: true)
        
     
        
    }
    
}


extension HomeVC : UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    @IBAction func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        
        if textField == jobtitleTF {
            if jobsnameArray.count != 0 {
                jobtitleTF.text = jobsnameArray[0].name
                jobName_id = jobsnameArray[0].id
                
            }
        }else if textField == LocationTF {
            if LocationsArray.count != 0 {
                LocationTF.text = LocationsArray[0].country
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
        if pickerView == Jobtitle {
            return jobsnameArray.count
        }else if pickerView == location{
            return LocationsArray.count
        }
        else {
            
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
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == Jobtitle {
            jobtitleTF.text = jobsnameArray[row].name
            jobName_id = jobsnameArray[row].id
          
            
        }
        else if pickerView == location{
            LocationTF.text = LocationsArray[row].country
            location_id = LocationsArray[row].id
            
            
        }
    }
}

extension HomeVC : UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return recomendedJobsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        
        var imageUrl = "http://apialhin.77carsael.com/\(recomendedJobsArray[indexPath.row].image ?? "")"
        
        cell.IMGView.loadImage(URL(string: imageUrl))
        
       cell.jobTitle.text = recomendedJobsArray[indexPath.row].job_title
        cell.rateLabel.text = "\(recomendedJobsArray[indexPath.row].rate ?? 0)"
        cell.reviewsLabel.text = "\( recomendedJobsArray[indexPath.row].review ?? "") Reviews" 
    
        cell.comp_name.text = recomendedJobsArray[indexPath.row].companyName
        
        setShadow(view: cell, width: 1, height: 1, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1))
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "JobDetailsVC") as! JobDetailsVC
        
        vc.job_id = recomendedJobsArray[indexPath.row].id
        
     
 
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}


extension HomeVC {
    
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
                    print(self.jobsnameArray)
                    
                    self.view.unlock()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    
                }
                
            }
        }
        
    }

    
    func getRecomendedJobs(){
        
        
        view.lock()
        DispatchQueue.main.async {
            //            self.subjectLabel.showAnimatedSkeleton()
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let manager = Manager()
            
            var param = [
             "language" : L102Language.currentAppleLanguage()
            ]
            
            if self.jobName_id != nil , self.location_id != nil {
             param = [
                "language" : L102Language.currentAppleLanguage() ,
                "job_title" : "\(self.jobName_id!)",
                "newer" : "true" ,
                "residence_country_id" :  "\(self.location_id!)" ,
               // "total_experience" : "1"
                
                
                ] 
                
            }else if self.jobName_id != nil {
                
                param = [
                    "language" : L102Language.currentAppleLanguage() ,
                    "job_title" : "\(self.jobName_id!)" ,
                    "newer" : "true" ,
                   // "residence_country_id" :  self.location_id! ,
                    // "total_experience" : "1"
                    
                    
                    ]
                
            }else if self.location_id != nil {
                param = [
                    "language" : L102Language.currentAppleLanguage() ,
                    //"job_title" : self.jobName_id! ,
                    "newer" : "true" ,
                     "residence_country_id" : "\(self.location_id!)" ,
                    // "total_experience" : "1"
                    
                    
                    ]
                
            }
            
            self.recomendedJobsArray.removeAll()
            manager.perform(methodType: .post, serviceName: .recomendedJobs, parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
                
                self.view.unlock()
                
                if String != nil {
                    
                    self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }else {
                    let response = JSON as! NSDictionary
                    
                    print(response)
                    
                    let Response : RecomendedJobsModel = Mapper<RecomendedJobsModel>().map(JSON: response as! [String : Any])!
                    
                    
                    self.recomendedJobsArray = Response.jobs ?? []
                    
                  self.collectionView.reloadData()
                    
                    self.view.unlock()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    
                }
                
            }
        }
        
    }
    
    
    
}
