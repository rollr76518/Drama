//
//  BriefTableViewCell.swift
//  Drama
//
//  Created by Ryan on 2018/11/4.
//  Copyright © 2018年 Hanyu. All rights reserved.
//

import UIKit

class BriefTableViewCell: UITableViewCell {

	@IBOutlet var leftImageView: UIImageView!
	@IBOutlet var primaryLabel: UILabel!
	@IBOutlet var secondaryLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
