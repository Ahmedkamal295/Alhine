//
//  validationCodeVc.swift
//  Terhal
//
//  Created by mahroUS on 2/10/1441 AH.
//  Copyright © 1441 AH mahroUS. All rights reserved.
//

import UIKit

class validationCodeVc: UIViewController {


    var Confirm: Bool = false
    var code: String?
    var phone: String?
    
    
    @IBOutlet weak var backGroundImg: UIImageView!
    
    @IBOutlet weak var iconImag: UIImageView!
    @IBOutlet weak var validationLb: UILabel!
    @IBOutlet weak var validationTxt: DesignableUITextField!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmBtn(_ sender: Any) {
        let gOmainVc = storyboard?.instantiateViewController(withIdentifier: "mainMapsVC") as? mainMapsVC
        show(gOmainVc!, sender: Any?.self)
    }
    

}
