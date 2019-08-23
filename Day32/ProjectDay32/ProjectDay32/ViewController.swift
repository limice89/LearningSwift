//
//  ViewController.swift
//  ProjectDay32
//
//  Created by admin on 2019/8/23.
//  Copyright © 2019 limice. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "创建购物清单"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "重置", style: .plain, target: self, action: #selector(clearData))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(inputGoodsAlert))
        let shareItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareInfo))
        toolbarItems = [shareItem]
        navigationController?.isToolbarHidden = false
        // Do any additional setup after loading the view.
    }
    @objc func inputGoodsAlert() {
        let ac = UIAlertController(title: "输入商品", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "确认", style: .default, handler: { (action: UIAlertAction) in
            if let textfield = ac.textFields?[0] {
                if let str = textfield.text {
                    self.shoppingList.insert(str, at: 0)
                    self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                }
            }
        }))
        present(ac, animated: true)
    }
    @objc func clearData () {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    @objc func shareInfo() {
        if shoppingList.isEmpty {
            print("没有购物清单")
            return;
        }
        let shareInfo = shoppingList.joined(separator: "\n")
        let active = UIActivityViewController(activityItems: [shareInfo], applicationActivities: [])
        active.popoverPresentationController?.barButtonItem = navigationController?.toolbar.items?[0]
        present(active, animated: true)
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Shopping", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
}

