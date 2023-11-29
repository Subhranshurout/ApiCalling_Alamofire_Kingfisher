//
//  LocationVC.swift
//  ApiCallingEx1
//
//  Created by Yudiz-subhranshu on 22/05/23.
//

import UIKit
import Alamofire

class LocationVC: UIViewController {
    var selectedIndex = 0
    var details = [LocationDetails]()
    @IBOutlet var myTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.delegate = self
        myTable.dataSource = self
//        callAPI()
        alamofireApiCalling()
    }
}

//MARK: -  Alamofire API Calling Method

extension LocationVC {
    
    func alamofireApiCalling () {
        let url = "https://rickandmortyapi.com/api/location"
        AF.request(url).response(completionHandler: { response in
            switch response.result {
            case .success(let data) :
                guard let jsonData = data else {
                    print("Invalid Data")
                    return
                }
                do{
                    self.details = [LocationDetails]()
                    let json = try JSONSerialization.jsonObject(with: jsonData) as! [String : Any]
                    let arrData = json["results"] as! [[String : Any]]
                    for obj in arrData {
                        let newChar = LocationDetails(dict: obj)
                        self.details.append(newChar)
                    }
                } catch {
                    print("error : \(error.localizedDescription)")
                }
                DispatchQueue.main.async {
                    self.myTable.reloadData()
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        })
    }
    
//    func callAPI() {
//        guard let url = URL(string: "https://rickandmortyapi.com/api/location") else {
//            return
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        let session = URLSession.shared
//        let task = session.dataTask(with: request, completionHandler: {data , response , error -> Void in
//            // Ensure there is data
//            guard let jsonData = data else {
//                print("No data received")
//                return
//            }
//            do{
//                self.details = [LocationDetails]()
//                let json = try JSONSerialization.jsonObject(with: jsonData) as! [String : Any]
//                let arrData = json["results"] as! [[String : Any]]
//                for obj in arrData {
//                    let newChar = LocationDetails(dict: obj)
//                    self.details.append(newChar)
//                }
//            } catch {
//                print("error : \(error.localizedDescription)")
//            }
//            DispatchQueue.main.async {
//                self.myTable.reloadData()
//            }
//        })
//        task.resume()
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! LocationVC2
        destinationVC.myIndex = selectedIndex
        destinationVC.myList = details
    }
}

//MARK: - TableView delegate Methods
extension LocationVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationCell
        let character = details[indexPath.row]
        cell.idLbl.text = "Location id :\(character.id)"
        cell.nameLbl.text = "Name :\(character.name)"
        cell.typeLbl.text = "Type :\(character.type)"
        cell.dimensionLbl.text = "Dimension :\(character.dimension)"
        cell.createdLbl.text = "Created :\(character.created)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "LocationVC2", sender: self)
    }
    
}
