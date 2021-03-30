//
//  customCell.swift
//  MyWeatherTodayProj
//
//  Created by Ha Neul Iee on 2021/03/21.
//

import UIKit

class customCell: UITableViewCell {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperaturesLabel: UILabel!
    @IBOutlet weak var rainProbabilityLabel: UILabel!
    var wetherState: String!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
