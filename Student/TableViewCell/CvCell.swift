//
//  CvCell.swift
//  Student
//
//  Created by MOHAB on 2/12/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit


protocol ViewCv {
    func ViewCv(indexpath : Int)
}

class CvCell: UITableViewCell {
    
    @IBOutlet weak var jobTitleTF: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var ComynameLabel: UILabel!
    @IBOutlet weak var IMGView: UIImageView!
    
    @IBOutlet weak var FavouriteBtn: UIButton!
    
    @IBOutlet weak var ApplyBtn: UIButton!
    var delegate : isVavourite!
    var viewCVDelegate : ViewCv!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    
    @IBAction func FavouriteAction(_ sender: Any) {
        
        delegate.reFavourite(indexpath: FavouriteBtn.tag)
        
    }
    

    @IBAction func ApplyAction(_ sender: Any) {
        viewCVDelegate.ViewCv(indexpath: ApplyBtn.tag)
        
    }
}
