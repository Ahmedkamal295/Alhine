//
//  AppliedjobCell.swift
//  Student
//
//  Created by MOHAB on 2/12/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit

class AppliedjobCell: UITableViewCell {
    
    @IBOutlet weak var jobtitleLAbel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var ComponynameLabel: UILabel!
    
    @IBOutlet weak var AppliedImage: UIImageView!
    @IBOutlet weak var LikeBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
