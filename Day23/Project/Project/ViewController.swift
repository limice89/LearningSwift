//
//  ViewController.swift
//  Project
//
//  Created by admin on 2019/8/14.
//  Copyright © 2019 limice. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var imageArr: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageArr += ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArr.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.imageView?.image = UIImage(named: imageArr[indexPath.row])
        cell.textLabel?.text = imageArr[indexPath.row].uppercased()
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.imageName = imageArr[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }

}

