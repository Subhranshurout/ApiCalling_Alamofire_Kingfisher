//
//  EpisodesVC2.swift
//  ApiCallingEx1
//
//  Created by Yudiz-subhranshu on 25/05/23.
//

import UIKit
import Kingfisher
import Alamofire

class EpisodesVC2: UIViewController {
    
    var myIndex = 0
    var myList = [EpisodesDetails]()
    var details = [LocationDetails2]()
    @IBOutlet var myTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        callAPI()
        myTable.refreshControl?.beginRefreshing()
        alamofireApicCalling()
    }
}

//MARK: -  Alamofire API Calling Method

extension EpisodesVC2 {
    
    func alamofireApicCalling () {
        for residents in myList[myIndex].characters {
            AF.request(residents).response(completionHandler: { response in
                self.myTable.refreshControl?.endRefreshing()
                switch response.result {
                case.success(let data) :
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
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }
}

//MARK: - TableView delegate Methods

extension EpisodesVC2 : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EpisodesCell2
        let resident = details[indexPath.row]
        cell.nameLbl.text = "Name :\(resident.name)"
        let url = URL(string: resident.image)
        cell.imgLbl.kf.setImage(with: url,placeholder: UIImage(named: "download"))
        cell.statusLbl.text = "Status :\(resident.status)"
        cell.speciesLbl.text = "Species :\(resident.species)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
