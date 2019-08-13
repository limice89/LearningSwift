//
//  ViewController.swift
//  Project2
//
//  Created by admin on 2019/8/12.
//  Copyright © 2019 limice. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        askQuestion()
        // Do any additional setup after loading the view.
    }
    func askQuestion(action: UIAlertAction! = nil){
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String!
        if sender.tag == correctAnswer {
            title = "正确"
            score += 1
        } else {
          title = "错误"
            score -= 1
        }
        
        let alert = UIAlertController(title: title, message: "你的得分是\(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "继续", style: .default, handler: askQuestion))
        present(alert,animated: true)
        
    }
}

