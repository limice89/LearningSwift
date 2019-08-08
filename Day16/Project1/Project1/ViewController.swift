//
//  ViewController.swift
//  Project1
//
//  Created by admin on 2019/8/8.
//  Copyright © 2019 limice. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl"){
                //这里加载一个图片
                pictures.append(item)
            }
        }
        print(pictures)
    }
    //tableView 有多少条数据
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    //给tableView中cell赋值
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
}

