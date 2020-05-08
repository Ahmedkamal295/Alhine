//
//  NotificationCell.swift
//  Student
//
//  Created by MOHAB on 1/30/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {

    
    @IBOutlet weak var IMG: UIImageView!
    
    
    @IBOutlet weak var nameLAbel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
