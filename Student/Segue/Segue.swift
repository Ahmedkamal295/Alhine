//
//  Segue.swift
//  Student
//
//  Created by MOHAB on 12/16/19.
//  Copyright © 2019 e3gaz. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    
    func goVC(_ vc : String)  {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: vc)
        // present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func dismiss()  {
        navigationController?.popViewController(animated: true)
        //  dismiss(animated: true, completion: nil)
    }
}
