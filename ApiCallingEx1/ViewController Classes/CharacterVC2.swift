//
//  CharacterVC2.swift
//  ApiCallingEx1
//
//  Created by Yudiz-subhranshu on 22/05/23.
//

import UIKit
import Alamofire
class CharacterVC2: UIViewController {
    @IBOutlet var myTable: UITableView!
    var myIndex = 0
    var myList = [CharacterDetails]()
    var details = [CharacterDetails2]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTable.delegate = self
        myTable.dataSource = self
        //        callAPI()
        myTable.refreshControl?.beginRefreshing()
        alamofireApiCalling()
        
    }
}

//MARK: - Alamofire API Calling Method

extension CharacterVC2 {
    
    func alamofireApiCalling () {
        for episodes in myList[myIndex].episode {
            AF.request(episodes).response(completionHandler: { response in
                self.myTable.refreshControl?.endRefreshing()
                switch response.result {
                case .success(let data) :
                    guard let jsonData = data else {
                        print("incalid data")
                        return
                    }
                    do {
                        let json = try JSONSerialization.jsonObject(with: jsonData) as! [String: Any]
                        let newChar = CharacterDetails2(dict: json)
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
    //        for episodes in myList[myIndex].episode {
    //            dispatchGroup.enter() // Enter the dispatch group before making each API call
    //
    //            guard let url = URL(string: episodes) else {
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
    //                    let newChar = CharacterDetails2(dict: json)
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

//MARK: - TableVIew Delegate Methods

extension CharacterVC2 : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CharacterCell2
        let character = details[indexPath.row]
        cell.idLbl.text = "Episode Id :\(character.id)"
        cell.nameLbl.text = "Name :\(character.name)"
        cell.air_dateLbl.text = "Air_date :\(character.air_date)"
        cell.episodeLbl.text = "Episode :\(character.episode)"
        cell.createdLbl.text = "Created :\(character.created)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
