//
//  DetailViewController.swift
//  Project
//
//  Created by admin on 2019/8/14.
//  Copyright © 2019 limice. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var imageName: String!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.layer.borderWidth = 1;
        self.imageView.layer.borderColor = UIColor.gray.cgColor
        self.imageView.image = UIImage(named: imageName)
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(barButtonTapped))
        // Do any additional setup after loading the view.
    }

    @objc func barButtonTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("没有图片")
            return
            
        }
        
        let active = UIActivityViewController(activityItems: [imageName!,image], applicationActivities: [])
        active.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(active, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
