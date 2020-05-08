//
//  jobsCell.swift
//  Student
//
//  Created by MOHAB on 2/12/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//
///
//

import UIKit


protocol isVavourite {
    
    func reFavourite(indexpath : Int)
    
    
}


protocol Apply {
    func applyjob(indexpath : Int)
}

class jobsCell: UITableViewCell {

    @IBOutlet weak var jobTitleTF: UILabel!
    
    var delegate : isVavourite!
    
    var applyDelegate : Apply!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var ImgView: UIImageView!
    
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var ComponyName: UILabel!
    
    
    @IBOutlet weak var ApplyBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func favouriteAction(_ sender: Any) {
        
        delegate.reFavourite(indexpath: favouriteBtn.tag)
        
    }
    
    @IBAction func AbblyBtn(_ sender: Any) {
        
        
        applyDelegate.applyjob(indexpath: ApplyBtn.tag)
        
    }
    
    
    
    
}
