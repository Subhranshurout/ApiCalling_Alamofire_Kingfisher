//
//  CharacterDetails.swift
//  ApiCallingEx1
//
//  Created by Yudiz-subhranshu on 22/05/23.
//

import UIKit

class CharacterDetails: NSObject , Codable{
    var id : Int
    var name : String
    var status : String
    var species : String
    var type : String
    var gender : String
    var created : String
    var image : String
    var origin : [String : String]
    var location : [String : String]
    var episode : [String]
    
    init(dict : [String : Any]){
        id = dict["id"] as! Int
        name = dict["name"] as! String
        status = dict["status"] as! String
        species = dict["species"] as! String
        type = dict["type"] as! String
        gender = dict["gender"] as! String
        created = dict["created"] as! String
        image = dict["image"] as! String
        origin = dict["origin"] as! [String : String]
        location = dict["location"] as! [String : String]
        episode = dict["episode"] as! [String]
    }
}
