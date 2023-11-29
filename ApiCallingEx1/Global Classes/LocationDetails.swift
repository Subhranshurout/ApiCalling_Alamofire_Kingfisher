//
//  LocationDetails.swift
//  ApiCallingEx1
//
//  Created by Yudiz-subhranshu on 22/05/23.
//

import UIKit

class LocationDetails: NSObject {
    var id : Int
    var name : String
    var type : String
    var dimension : String
    var created : String
    var residents : [String]
    
    init(dict : [String : Any]){
        id = dict["id"] as! Int
        name = dict["name"] as! String
        type = dict["type"] as! String
        dimension = dict["dimension"] as! String
        created = dict["created"] as! String
        residents = dict["residents"] as! [String]
    }
}
