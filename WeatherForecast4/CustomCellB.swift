//
//  CustomCell.swift
//  WeatherForecast
//
//  Created by JiWon Ju on 04/02/2019.
//  Copyright © 2019 JiWon Ju. All rights reserved.
//

import UIKit

class CustomCellB: UITableViewCell {
    
    @IBOutlet var time: UILabel!
    @IBOutlet var wf: UILabel!
    @IBOutlet var reliability: UILabel!
    @IBOutlet var tmn: UILabel!
    @IBOutlet var tmx: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
