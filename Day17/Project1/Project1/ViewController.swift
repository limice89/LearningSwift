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
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //加载detail viewController DetailViewController类的实例
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            //点击的哪一个图片的名字
            vc.imageName = pictures[indexPath.row]
            //push到DetailViewController 在detailViewController 中显示图片
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

