//
//  ViewController.swift
//  Project7
//
//  Created by admin on 2019/8/23.
//  Copyright © 2019 limice. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
//        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        
//        if let url = URL(string: urlString) {
//            if let data = try? Data(contentsOf: url) {
//                //可以解析
//                parse(json: data)
//            } else {
//                showError()
//            }
//        } else {
//            showError()
//        }
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url){
                parse(json: data)
                return
            }
        }
        showError()
        // Do any additional setup after loading the view.
    }
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
        
    }
    func showError() {
        let ac = UIAlertController(title: "加载错误", message: "加载错误,请查看网络连接后重试", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let petition = petitions[indexPath.row]
        let vc = DetailViewController()
        vc.detailItem = petition
        navigationController?.pushViewController(vc, animated: true)
        
    }

}

