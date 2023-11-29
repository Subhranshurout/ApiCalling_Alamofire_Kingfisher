//
//  LocationCell2.swift
//  ApiCallingEx1
//
//  Created by Yudiz-subhranshu on 23/05/23.
//

import UIKit

class LocationCell2: UITableViewCell {

    @IBOutlet var imgLbl: UIImageView!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var statusLbl: UILabel!
    @IBOutlet var species: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
