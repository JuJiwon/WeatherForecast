//
//  CustomCell.swift
//  WeatherForecast
//
//  Created by JiWon Ju on 04/02/2019.
//  Copyright © 2019 JiWon Ju. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet var city: UILabel!
    @IBOutlet var time00: UILabel!
    @IBOutlet var time12: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
