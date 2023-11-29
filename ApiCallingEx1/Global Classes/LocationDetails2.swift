//
//  LocationDetails2.swift
//  ApiCallingEx1
//
//  Created by Yudiz-subhranshu on 24/05/23.
//

import UIKit

class LocationDetails2: NSObject {
    var name : String
    var status : String
    var species : String
    var image : String
    
    init (dict:[String : Any]){
        name = dict["name"] as! String
        status = dict["status"] as! String
        species = dict["species"] as! String
        image = dict["image"] as! String
    }
}
