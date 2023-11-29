//
//  EpisodesVC.swift
//  ApiCallingEx1
//
//  Created by Yudiz-subhranshu on 22/05/23.
//

import UIKit
import Alamofire
class EpisodesVC: UIViewController {
    var details = [EpisodesDetails]()
    var selectedIndex = 0
    @IBOutlet var myTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.delegate = self
        myTable.dataSource = self
//        callAPI()
        alamofireApiCalling()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! EpisodesVC2
        destinationVC.myList = details
        destinationVC.myIndex = selectedIndex
    }
}

//MARK: - Alamofire API Calling Method

extension EpisodesVC {
    func alamofireApiCalling() {
        let url = "https://rickandmortyapi.com/api/episode"
        AF.request(url).response(completionHandler: { response in
            switch response.result {
            case .success(let data) :
                guard let jsonData = data else {
                    print("Invalid Data")
                    return
                }
                do{
                    self.details = [EpisodesDetails]()
                    let json = try JSONSerialization.jsonObject(with: jsonData) as! [String : Any]
                    let arrData = json["results"] as! [[String : Any]]
                    for obj in arrData {
                        let newChar = EpisodesDetails(dict: obj)
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
//        guard let url = URL(string: "https://rickandmortyapi.com/api/episode") else {
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
//                self.details = [EpisodesDetails]()
//                let json = try JSONSerialization.jsonObject(with: jsonData) as! [String : Any]
//                let arrData = json["results"] as! [[String : Any]]
//                for obj in arrData {
//                    let newChar = EpisodesDetails(dict: obj)
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
}

//MARK: - TableView Delegate Methods

extension EpisodesVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EpisodesCell
        let character = details[indexPath.row]
        cell.idLbl.text = "Episode Id :\(character.id)"
        cell.nameLbl.text = "Name :\(character.name)"
        cell.air_dateLbl.text = "Air_date :\(character.air_date)"
        cell.episodesLbl.text = "Episode :\(character.episode)"
        cell.createdLbl.text = "Created :\(character.created)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "EpisodesVC2", sender: self)
    }
}
