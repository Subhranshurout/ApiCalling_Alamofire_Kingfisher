//
//  ViewController.swift
//  ApiCallingEx1
//
//  Created by Yudiz-subhranshu on 22/05/23.
//

import UIKit
import Kingfisher
import Alamofire

class ViewController: UIViewController {
    
    var details = [CharacterDetails]()
    var selectedIndex = 0
    @IBOutlet var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.delegate = self
        myTable.dataSource = self
        alamofireCallApi()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! CharacterVC2
        destinationVC.myIndex = selectedIndex
        destinationVC.myList = details
        
    }
}
// MARK: - Alamofire API Calling

extension ViewController {
    func alamofireCallApi () {
        let url = "https://rickandmortyapi.com/api/character"
        AF.request(url).response(completionHandler: { response in
            switch response.result {
            case .success(let data) :
                guard let jsonData = data else {
                    print("Invalid Data")
                    return
                }
                do {
                    self.details = [CharacterDetails]()
                    let json = try JSONSerialization.jsonObject(with: jsonData) as! [String : Any]
                    let arrData = json["results"] as! [[String : Any]]
                    for obj in arrData {
                        let newChar = CharacterDetails(dict: obj)
                        self.details.append(newChar)
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.myTable.reloadData()
                }
                
            case .failure(let error) :
                print(error.localizedDescription)
            }
        })
    }
}
// MARK: - TableView Delegate Methods

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let character = details[indexPath.row]
        cell.idlbl.text = "Character Id :\(character.id)"
        cell.nameLbl.text = "Name :\(character.name)"
        cell.statusLbl.text = "Status :\(character.status)"
        cell.speciesLbl.text = "Species :\(character.species)"
        if(character.type == ""){
            cell.typeLbl.text = "Type :Unknown"
        }else {
            cell.typeLbl.text = "Type :\(character.type)"
        }
        cell.genderLbl.text = "Gender :\(character.gender)"
        cell.createdLbl.text = "Created :\(character.created)"
        let url = URL(string: character.image)
        cell.imgLbl.kf.setImage(with: url,placeholder: UIImage(named: "download"))
        cell.originLbl.text = "Origin :\(character.origin["name"] ?? "")"
        cell.locationLbl.text = "Location :\(character.location["name"] ?? "")"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Selected Character is : \(details[indexPath.row].name)")
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "CharacterVC2", sender: nil)
        
    }
}

