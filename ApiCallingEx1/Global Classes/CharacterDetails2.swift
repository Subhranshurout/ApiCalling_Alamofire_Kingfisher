//
//  CharacterDetails2.swift
//  ApiCallingEx1
//
//  Created by Yudiz-subhranshu on 22/05/23.
//

import UIKit

class CharacterDetails2: NSObject {
    var id : Int
    var name : String
    var air_date : String
    var episode : String
    var created : String
    
    init(dict : [String : Any]){
        id = dict["id"] as! Int
        name = dict["name"] as! String
        air_date = dict["air_date"] as! String
        episode = dict["episode"] as! String
        created = dict["created"] as! String
    }
}
