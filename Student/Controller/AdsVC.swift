//
//  AdsVC.swift
//  Student
//
//  Created by MOHAB on 1/31/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit
import ObjectMapper
class AdsVC: UIViewController {

    
    @IBOutlet weak var IMGView: UIImageView!
    var time = 0

  
    var timer = Timer()

    @IBOutlet weak var skibBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
      
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
        getAds()
        
    }
    
    @objc func fire()
    {
        print(time)

        if time != 3 {
        skibBtn.setTitle("\(time)", for: .normal)
            
        }else {
            
            timer.invalidate()
            
            if L102Language.currentAppleLanguage() == "en" {
             skibBtn.setTitle("Skip Ad", for: .normal)
            }else {
                 skibBtn.setTitle("تخطى", for: .normal)
            }
            
        }

        time = time + 1
    }
    
    @IBAction func BookingAction(_ sender: Any) {
        
        
        
        
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        
        
        
    }
    
    
    @IBAction func skipAction(_ sender: Any) {
        if skibBtn.titleLabel?.text == "Skip Ad" || skibBtn.titleLabel?.text == "تخطى" {
            
            if Helper.getapitoken() != nil {
            
       appDelegate.SideMenu()
            }else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "LoginVC")
               present(vc, animated: true, completion: nil)
               // navigationController?.pushViewController(vc, animated: true)
        
                
            }
        }
        
    }
    
}


extension AdsVC {
    
    func getAds(){
        
        
        
        
        view.lock()
        DispatchQueue.main.async {
            //            self.subjectLabel.showAnimatedSkeleton()
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let manager = Manager()
          
            
            
            manager.perform(methodType: .post, serviceName: .ads, parameters: nil) { (JSON, String) -> Void in
                
                self.view.unlock()
                
                if String != nil {
                    
                    self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }else {
                    let response = JSON as! NSDictionary
                    
                    print(response)
                    
                    let Response : AdsModel = Mapper<AdsModel>().map(JSON: response as! [String : Any])!
                    
                    
                    var imageUrl = "http://apialhin.77carsael.com/\(Response.ads?.image ?? "")"
                    self.IMGView.loadImage(URL(string: imageUrl))
                    
                    print(Response)
                    
                    
                    self.view.unlock()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    
                }
                
            }
        }
        
        
        
    }
    
    
}
