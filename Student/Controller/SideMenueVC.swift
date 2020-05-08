//
//  SideMenueVC.swift
//  Student
//
//  Created by MOHAB on 1/31/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit

class SideMenueVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    
    @IBOutlet weak var HomeLabel: UILabel!
    
    @IBOutlet weak var ApplicationsLabel: UILabel!
    
    
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var FAvouriteLabel: UILabel!
    
    @IBOutlet weak var contactusLabel: UILabel!
    
    @IBOutlet weak var termsBtn: UIButton!
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    @IBOutlet weak var AboutusBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        if let name = HelperToken.getname() {
            
            nameLabel.text = name
            
        }
    }
    
    func initViews(){
        
        
        AboutusBtn.setTitle("حول التطبيق", for: .normal)
        termsBtn.setTitle("الشروط والاحكام", for: .normal)
          logoutBtn.setTitle("تسجيل خروج", for: .normal)
        
        contactusLabel.text = "تواصل معنا"
        FAvouriteLabel.text = "المفضلة"
        languageLabel.text = "اللغة"
        ApplicationsLabel.text = "الاعلانات"
        HomeLabel.text = "الرئيسية"
        
    }
    

    @IBAction func homeAction(_ sender: Any) {
        
        appDelegate.SideMenu()
       // let centerVC: UIViewController = storyboard!.instantiateViewController(withIdentifier: "HomeVC")
       // centerVC.modalPresentationStyle = .fullScreen
        
        
       // let centerNavVC = UINavigationController(rootViewController: centerVC)
        
      //  panel!.center(centerNavVC)
        
    }
    
    @IBAction func appliedforAction(_ sender: Any) {
        
        let centerVC: UIViewController = storyboard!.instantiateViewController(withIdentifier: "AppliedForVC")
        centerVC.modalPresentationStyle = .fullScreen
        
        
        let centerNavVC = UINavigationController(rootViewController: centerVC)
        
        panel!.center(centerNavVC)
        
    }
    
    @IBAction func LanguageAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Language", message: "Please Select language", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "English", style: .default , handler:{ (UIAlertAction)in
            
            if L102Language.currentAppleLanguage() == "ar" {
            
            self.changeLanguage(vcId: .AdsVC)
                
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Arabic", style: .default , handler:{ (UIAlertAction)in
            
            if L102Language.currentAppleLanguage() == "en" {
            self.changeLanguage(vcId: .AdsVC)
            }
                
                
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive , handler:{ (UIAlertAction)in
            print("User click Delete button")
        }))
        
        
        
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
        
    }
    
    
    @IBAction func favouriteAction(_ sender: Any) {
        
        
        let centerVC: UIViewController = storyboard!.instantiateViewController(withIdentifier: "FavouriteVC")
        centerVC.modalPresentationStyle = .fullScreen
        
        
        let centerNavVC = UINavigationController(rootViewController: centerVC)
        
        panel!.center(centerNavVC)
        
        
    }
    @IBAction func ContactUnAction(_ sender: Any) {
        
        let centerVC: UIViewController = storyboard!.instantiateViewController(withIdentifier: "ContactusVC")
        centerVC.modalPresentationStyle = .fullScreen
        
        
        let centerNavVC = UINavigationController(rootViewController: centerVC)
        
        panel!.center(centerNavVC)
        
        
    }
    
    
    @IBAction func AboutusAction(_ sender: Any) {
        
        let centerVC: UIViewController = storyboard!.instantiateViewController(withIdentifier: "AboutusVC")
        centerVC.modalPresentationStyle = .fullScreen
        
        
        let centerNavVC = UINavigationController(rootViewController: centerVC)
        
        panel!.center(centerNavVC)
        
    }
    
    @IBAction func termsAction(_ sender: Any) {
        
        
        let centerVC: UIViewController = storyboard!.instantiateViewController(withIdentifier: "TermsVC")
        centerVC.modalPresentationStyle = .fullScreen
        
        let centerNavVC = UINavigationController(rootViewController: centerVC)
        
        panel!.center(centerNavVC)
        
        
    }
    
    
    @IBAction func LogoutAction(_ sender: Any) {
        
        HelperToken.Savename(name: nil)
        HelperToken.SaveEmail(email: nil)
        HelperToken.SaveApitoken(token: nil)
       HelperToken.restartApp("AdsVC")
        
        
    }
    
    
    
    
    
}
