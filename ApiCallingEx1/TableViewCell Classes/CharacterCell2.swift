//
//  CharacterCell2.swift
//  ApiCallingEx1
//
//  Created by Yudiz-subhranshu on 22/05/23.
//

import UIKit

class CharacterCell2: UITableViewCell {
    @IBOutlet var idLbl: UILabel!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var air_dateLbl: UILabel!
    @IBOutlet var episodeLbl: UILabel!
    @IBOutlet var createdLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
