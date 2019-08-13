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
    var countNum = 0       //做题次数
    
    
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
        title = "\(countries[correctAnswer].uppercased())--分数:\(score)"
    }
    func restart(action: UIAlertAction! = nil) {
        score = 0
        countNum = 0
        askQuestion()
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        countNum += 1
        if sender.tag == correctAnswer {
            score += 1
        } else {
            score -= 1
            countNum == 10 ? nil : showWrongAlert(index: sender.tag)
        }
        
        if countNum == 10 {
            title = "\(countries[correctAnswer].uppercased())--分数:\(score)"
            let alert = UIAlertController(title: "游戏结束", message: "你的最终得分是\(score)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "重新开始", style: .default, handler: restart))
            present(alert,animated: true)
        }else{
            askQuestion();
        }
        
        
    }
    func showWrongAlert(index: Int) {
        let alert = UIAlertController(title: "错误", message: "这是\(countries[index])的国旗", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "关闭", style: .destructive, handler: nil))
        present(alert,animated: true)
    }
}

