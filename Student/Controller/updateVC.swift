//
//  updateVC.swift
//  Student
//
//  Created by MOHAB on 1/31/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit

class updateVC: UIViewController {
    
    
    @IBOutlet weak var personalJobname: UITextField!
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var Phone: UITextField!
    @IBOutlet weak var Email: UITextField!
    
    @IBOutlet weak var DateOfBirth: UITextField!
    
    
    @IBOutlet weak var nationality: UITextField!
    
    
    @IBOutlet weak var matarialStatus: UITextField!
    
    @IBOutlet weak var ResidendencyStatus: UITextField!
    
    @IBOutlet weak var Religion: UITextField!
    
    @IBOutlet weak var totalExperienceTF: UITextField!
    
    @IBOutlet weak var jobtitleTF: UITextField!
    
    @IBOutlet weak var CompanyName: UITextField!
    
    @IBOutlet weak var noExperienceTF: UITextField!
    
    @IBOutlet weak var NotesTV: UITextView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        InitViews()
        
    }
    

    func InitViews(){
        
        personalJobname.placeHolderColor = #colorLiteral(red: 0.3100231886, green: 0.7627651095, blue: 0.8575230241, alpha: 1)
        nameTf.placeHolderColor = #colorLiteral(red: 0.3100231886, green: 0.7627651095, blue: 0.8575230241, alpha: 1)
        Phone.placeHolderColor = #colorLiteral(red: 0.3100231886, green: 0.7627651095, blue: 0.8575230241, alpha: 1)
        Email.placeHolderColor = #colorLiteral(red: 0.3100231886, green: 0.7627651095, blue: 0.8575230241, alpha: 1)
        DateOfBirth.placeHolderColor = #colorLiteral(red: 0.3100231886, green: 0.7627651095, blue: 0.8575230241, alpha: 1)
        nationality.placeHolderColor = #colorLiteral(red: 0.3100231886, green: 0.7627651095, blue: 0.8575230241, alpha: 1)
        matarialStatus.placeHolderColor = #colorLiteral(red: 0.3100231886, green: 0.7627651095, blue: 0.8575230241, alpha: 1)
        ResidendencyStatus.placeHolderColor = #colorLiteral(red: 0.3100231886, green: 0.7627651095, blue: 0.8575230241, alpha: 1)
        Religion.placeHolderColor = #colorLiteral(red: 0.3100231886, green: 0.7627651095, blue: 0.8575230241, alpha: 1)
        totalExperienceTF.placeHolderColor = #colorLiteral(red: 0.3100231886, green: 0.7627651095, blue: 0.8575230241, alpha: 1)
        jobtitleTF.placeHolderColor = #colorLiteral(red: 0.3100231886, green: 0.7627651095, blue: 0.8575230241, alpha: 1)
        CompanyName.placeHolderColor = #colorLiteral(red: 0.3100231886, green: 0.7627651095, blue: 0.8575230241, alpha: 1)
        noExperienceTF.placeHolderColor = #colorLiteral(red: 0.3100231886, green: 0.7627651095, blue: 0.8575230241, alpha: 1)
        if L102Language.currentAppleLanguage() == "ar" {
        personalJobname.placeholder = "عنوان الوظيفة"
        nameTf.placeholder = "الاسم"
        Phone.placeholder = "رقم التليفون"
        Email.placeholder = "البريد الاكترونى"
        DateOfBirth.placeholder = "تاريخ الميلاد"
        nationality.placeholder = "الجنسية"
        matarialStatus.placeholder = "الحالة الاجتماعية"
        ResidendencyStatus.placeholder = ""
        Religion.placeholder = "الديانة"
        totalExperienceTF.placeholder = "عدد سنين الخبرة"
        jobtitleTF.placeholder = "عنوان الوظيفة"
        CompanyName.placeholder = "اسم الشركة"
        noExperienceTF.placeholder = "عدد سنين الخبرة"
        }
        
        personalJobname.setPadding(left: 20, right: 20)
        nameTf.setPadding(left: 20, right: 20)
        Phone.setPadding(left: 20, right: 20)
        Email.setPadding(left: 20, right: 20)
        DateOfBirth.setPadding(left: 20, right: 20)
        nationality.setPadding(left: 20, right: 20)
        matarialStatus.setPadding(left: 20, right: 20)
        ResidendencyStatus.setPadding(left: 20, right: 20)
        Religion.setPadding(left: 20, right: 20)
        totalExperienceTF.setPadding(left: 20, right: 20)
        jobtitleTF.setPadding(left: 20, right: 20)
        CompanyName.setPadding(left: 20, right: 20)
        noExperienceTF.setPadding(left: 20, right: 20)
        
        
    }
    

}
