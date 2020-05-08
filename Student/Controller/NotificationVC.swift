//
//  NotificationVC.swift
//  Student
//
//  Created by MOHAB on 1/30/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var notificationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func initViews(){
        
        backBtn.setImage(#imageLiteral(resourceName: "rightArrow-1"), for: .normal)
        notificationLabel.text = "الاشعارات"
        
        
    }
    
    
    @IBAction func disMissAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    

}

extension NotificationVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        
        
        
        return cell 
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}
