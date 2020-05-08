//
//  AboutusVC.swift
//  Student
//
//  Created by MOHAB on 1/30/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit
import ObjectMapper

class AboutusVC: UIViewController {

   
   
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var DataTV: UITextView!
    
    @IBOutlet weak var aboutLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        if L102Language.currentAppleLanguage() == "ar" {
        aboutLabel.text = "حول التطبيق"
            backBtn.setImage(#imageLiteral(resourceName: "rightArrow-1"), for: .normal)
            
        }
        
        navigationController?.isNavigationBarHidden = true
        GetAppinfo()
    }
    
    @IBAction func backAction(_ sender: Any) {
        
        if L102Language.currentAppleLanguage() == englishLang {
            panel?.openLeft(animated: true)
        }else{
            panel?.openRight(animated: true)
        }
        
        
        
    }
    
    

}

extension AboutusVC {
    
    
    func GetAppinfo(){
        
        
        view.lock()
        DispatchQueue.main.async {
            //            self.subjectLabel.showAnimatedSkeleton()
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let manager = Manager()
            
            let param = [
                "language" : L102Language.currentAppleLanguage()
                
                
                ]
            
            manager.perform(methodType: .post, serviceName: .appInfo, parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
                
                self.view.unlock()
                
                if String != nil {
                    
                    self.showMessage(title: "Warning".localized, sub:  String!, type: .error, layout: .statusLine)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }else {
                    let response = JSON as! NSDictionary
                    
                    print(response)
                    
                    let Response : TermsModel = Mapper<TermsModel>().map(JSON: response as! [String : Any])!
                    
                    
                    
                    self.DataTV.text = Response.appInfo?.about_us
                    
                    self.view.unlock()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    
                }
                
            }
        }
        
    }
    
    

    
}
