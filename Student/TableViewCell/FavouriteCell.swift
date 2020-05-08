//
//  FavouriteCell.swift
//  Student
//
//  Created by MOHAB on 1/30/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit

class FavouriteCell: UITableViewCell {
    
    
    @IBOutlet weak var IMGView: UIImageView!
    @IBOutlet weak var LikeBtn: UIButton!
    
    @IBOutlet weak var conservoortLabel: UILabel!
    
    @IBOutlet weak var reviewsLabel: UILabel!
    
    @IBOutlet weak var f1Label: UILabel!
    @IBOutlet weak var gurugamLabel: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var ApplyBtn: UIButton!
    
    var delegate : Apply!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
    }
    
    
    
    @IBAction func LikeAction(_ sender: Any) {
    }
    
    @IBAction func ApplyAction(_ sender: Any) {
        
        delegate.applyjob(indexpath: ApplyBtn.tag)
        
    }
    
}
