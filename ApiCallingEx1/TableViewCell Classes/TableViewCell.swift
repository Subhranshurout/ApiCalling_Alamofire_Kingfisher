//
//  TableViewCell.swift
//  ApiCallingEx1
//
//  Created by Yudiz-subhranshu on 22/05/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var idlbl: UILabel!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var statusLbl: UILabel!
    @IBOutlet var speciesLbl: UILabel!
    @IBOutlet var typeLbl: UILabel!
    @IBOutlet var genderLbl: UILabel!
    @IBOutlet var createdLbl: UILabel!
    @IBOutlet var imgLbl: UIImageView!
    @IBOutlet var originLbl: UILabel!
    @IBOutlet var locationLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
