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
    var filterPetitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showSource))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filterData))
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
            filterPetitions = petitions
            tableView.reloadData()
        }
        
    }
    func showError() {
        let ac = UIAlertController(title: "加载错误", message: "加载错误,请查看网络连接后重试", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
    }
    @objc func showSource () {
        let ac = UIAlertController(title: "数据来源", message: "来自网络", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    @objc func filterData () {
        let ac = UIAlertController(title: "搜索", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default){[weak self, weak ac] action in
            guard let filter = ac?.textFields?[0].text else { return }
            self?.searchData(filter: filter)
        })
        present(ac, animated: true)
    }
    func searchData(filter: String) {
        filterPetitions.removeAll()
        for pepition in petitions {
            if pepition.title.lowercased().contains(filter.lowercased()) {
                filterPetitions.append(pepition)
            }
           
        }
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterPetitions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filterPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let petition = filterPetitions[indexPath.row]
        let vc = DetailViewController()
        vc.detailItem = petition
        navigationController?.pushViewController(vc, animated: true)
        
    }

}

