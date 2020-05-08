//
//  AppliedForVC.swift
//  Student
//
//  Created by MOHAB on 1/31/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit
import ObjectMapper

class AppliedForVC: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var jobAppliedArray = [Appley]()
    
    
    
    @IBOutlet weak var appliedforLabel: UILabel!
    
    @IBOutlet weak var backbtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getJobApplied()
        navigationController?.isNavigationBarHidden = true
        
        
        
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        
        
        if L102Language.currentAppleLanguage() == "ar" {
            
            backbtn.setImage(#imageLiteral(resourceName: "rightArrow-1"), for: .normal)
            
            appliedforLabel.text = "قدم على"
            
        }
     
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        
        if L102Language.currentAppleLanguage() == englishLang {
            panel?.openLeft(animated: true)
        }else{
            panel?.openRight(animated: true)
        }
        
        
        
    }
    
    
}
extension AppliedForVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobAppliedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppliedjobCell", for: indexPath) as! AppliedjobCell
        
        
        let data = jobAppliedArray[indexPath.row]
        
        cell.jobtitleLAbel.text = data.job?.job_title
        cell.ratingLabel.text = "\(data.job?.rate ?? 0)"
        cell.reviewsLabel.text = "\(data.job?.review ?? "") Reviews"
        
        cell.priceLabel.text = data.job?.salary
        cell.ComponynameLabel.text = data.job?.companyName
        var imageUrl = "http://apialhin.77carsael.com/\(data.job?.image ?? "")"
        
       cell.AppliedImage.loadImage(URL(string: imageUrl))
        
        if data.job?.isFav ?? false {
            
            cell.LikeBtn.setImage(#imageLiteral(resourceName: "isfavouriteIcon"), for: .normal)
            
        }
        
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension AppliedForVC {
    
    
    func getJobApplied(){
        
   
            
            
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
                    "apiToken" : token
                    
                    
                ]
                
                manager.perform(methodType: .post, serviceName: .jobApplied, parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
                    
                    self.view.unlock()
                    
                    if String != nil {
                        
                        self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        
                    }else {
                        let response = JSON as! NSDictionary
                        
                        print(response)
                        
                        let Response : jobAppliedModel = Mapper<jobAppliedModel>().map(JSON: response as! [String : Any])!
                        
                        
                        self.jobAppliedArray = Response.appley ?? []
                        
                        
                     
                        self.tableView.reloadData()
                        
                        print(Response)
                        
                        
                        self.view.unlock()
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        
                        
                    }
                    
                }
            }
            
        }
        
        
        
    }
    
  
