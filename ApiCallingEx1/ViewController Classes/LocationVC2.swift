//
//  LocationVC2.swift
//  ApiCallingEx1
//
//  Created by Yudiz-subhranshu on 23/05/23.
//

import UIKit
import Kingfisher
import Alamofire

class LocationVC2: UIViewController {
    
    var myIndex = 0
    var myList = [LocationDetails]()
    var details = [LocationDetails2]()
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

extension LocationVC2 {
    
    func alamofireApiCalling() {
        for residents in myList[myIndex].residents {
            AF.request(residents).response(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    print(data!)
                    guard let jsonData = data else {
                        print("Invalid Data")
                        return
                    }
                    do {
                        let json = try JSONSerialization.jsonObject(with: jsonData) as! [String: Any]
                        let newChar = LocationDetails2(dict: json)
                        self.details.append(newChar)
                    } catch {
                        print("error: \(error.localizedDescription)")
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
    
//    func callAPI() {
//        let dispatchGroup = DispatchGroup() // Create a dispatch group
//        for residents in myList[myIndex].residents {
//            dispatchGroup.enter() // Enter the dispatch group before making each API call
//
//            guard let url = URL(string: residents) else {
//                dispatchGroup.leave() // Leave the dispatch group if URL is invalid
//                continue
//            }
//            var request = URLRequest(url: url)
//            request.httpMethod = "GET"
//
//            let session = URLSession.shared
//            let task = session.dataTask(with: request) { [weak self] data, response, error in
//                defer {
//                    dispatchGroup.leave() // Leave the dispatch group after API call is complete
//                }
//                guard let self = self, let jsonData = data else {
//                    return
//                }
//                do {
//                    let json = try JSONSerialization.jsonObject(with: jsonData) as! [String: Any]
//                    let newChar = LocationDetails2(dict: json)
//                    self.details.append(newChar)
//                } catch {
//                    print("error: \(error.localizedDescription)")
//                }
//                DispatchQueue.main.async {
//                    self.myTable.reloadData()
//                }
//            }
//            task.resume()
//        }
//    }
}

//MARK: - TableView Delegate Methods

extension LocationVC2 : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationCell2
        let resident = details[indexPath.row]
        cell.nameLbl.text = "Name :\(resident.name)"
        let url = URL(string: resident.image)
        cell.imgLbl.kf.setImage(with: url,placeholder: UIImage(named: "download"))
        cell.statusLbl.text = "Status :\(resident.status)"
        cell.species.text = "Species :\(resident.species)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
