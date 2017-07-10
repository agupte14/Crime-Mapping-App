//
//  CustomCell.swift
//  Crime Map
//
//  Created by Teddy on 7/4/16.
//  Copyright © 2016 Teddy. All rights reserved.
//

import Foundation
import UIKit
class CustomCell: UITableViewCell {
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
}