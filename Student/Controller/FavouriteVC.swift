//
//  FavouriteVC.swift
//  Student
//
//  Created by MOHAB on 1/30/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit
import ObjectMapper

class FavouriteVC: UIViewController {

    @IBOutlet weak var FavouriteLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var backBtn: UIButton!
    var FAvouriteArray = [Favourite]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

          navigationController?.isNavigationBarHidden = true
       tableView.delegate = self
        tableView.dataSource = self
        
        getFavourite()
        
    }
    
    func initViews(){
        
        FavouriteLabel.text = "المفضلة"

        backBtn.setImage(#imageLiteral(resourceName: "rightArrow-1"), for: .normal)
        
        
    }
    

    @IBAction func backAction(_ sender: Any) {
        
        if L102Language.currentAppleLanguage() == englishLang {
            panel?.openLeft(animated: true)
        }else{
            panel?.openRight(animated: true)
        }
        
        
    }
    

}


extension FavouriteVC : Apply {
    func applyjob(indexpath: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "JobDetailsVC") as! JobDetailsVC
        
        vc.job_id = FAvouriteArray[indexpath].id
        // present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

extension FavouriteVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FAvouriteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath) as! FavouriteCell
        
        cell.ApplyBtn.tag = indexPath.row
        cell.delegate = self
        
        cell.LikeBtn.setImage(#imageLiteral(resourceName: "isfavouriteIcon"), for: .normal)
        cell.conservoortLabel.text = FAvouriteArray[indexPath.row].cv?.job_title
        cell.rateLabel.text = "\(FAvouriteArray[indexPath.row].cv?.rate ?? 0)"
        var imageUrl = "http://apialhin.77carsael.com/\(FAvouriteArray[indexPath.row].cv?.photo ?? "")"
        
        cell.IMGView.loadImage(URL(string: imageUrl))
        
        cell.conservoortLabel.text = FAvouriteArray[indexPath.row].job?.job_title
        cell.f1Label.text = ""
        cell.gurugamLabel.text = FAvouriteArray[indexPath.row].job?.companyName
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


extension FavouriteVC {
    
    
    func getFavourite(){
        
  
        
      
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
              self.view.lock()
            
            let param = [
                "apiToken" : token
               
                
            ]
            
            manager.perform(methodType: .post, serviceName: .favourite, parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
                
                self.view.unlock()
                
                if String != nil {
                    
                    self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }else {
                    let response = JSON as! NSDictionary
                    
                    print(response)
                    
                    let Response : FavouriteModel = Mapper<FavouriteModel>().map(JSON: response as! [String : Any])!
                    
                    
                    
                 
                    self.FAvouriteArray = Response.favourite ?? []
                    
                    self.tableView.reloadData()
                    
                    print(Response)
                    
                    
                    self.view.unlock()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    
                }
                
            }
        }
        
    }
    
    
    
}
