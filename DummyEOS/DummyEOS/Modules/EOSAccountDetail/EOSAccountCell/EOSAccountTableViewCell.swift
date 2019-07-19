//
//  EOSAccountTableViewCell.swift
//  DummyEOS
//
//  Created by Hamza Khan on 18/07/2019.
//  Copyright © 2019 Hamza Khan. All rights reserved.
//

import UIKit

class EOSAccountTableViewCell: UITableViewCell {

    @IBOutlet weak var lblStaked: UILabel!
    @IBOutlet weak var lblTotalResourceUsage: UILabel!
    @IBOutlet weak var lblResourcePercentage: UILabel!
    @IBOutlet weak var lblResourceName: UILabel!
    @IBOutlet weak var sliderVal : UIProgressView!
    @IBOutlet weak var imgEOSLogo: UIImageView!
    var resourceTableModel : resourceTableModel!{
        didSet{
            self.lblStaked.text = resourceTableModel.strResourceStaked
            self.lblTotalResourceUsage.text = String(resourceTableModel.strResourceUsed) + "/" + String(resourceTableModel.strResourceAvailable)
            self.lblResourcePercentage.text = resourceTableModel.strResourcePercent
            self.lblResourceName.text = resourceTableModel.strResourceName
            self.sliderVal.progress = resourceTableModel.sliderVal
            self.imgEOSLogo.isHidden = resourceTableModel.hideEOSImage
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    

}
