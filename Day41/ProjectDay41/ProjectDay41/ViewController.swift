//
//  ViewController.swift
//  ProjectDay41
//
//  Created by admin on 2019/9/6.
//  Copyright © 2019 limice. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var allWords = [String]()
    var word: String = ""
    var usedLetters = [String]()
    var wrongAnswers: Int = 0
    

    @IBOutlet weak var inputField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        loadData()
        // Do any additional setup after loading the view.
    }
    func configUI() {
        self.inputField.layer.borderWidth = 1
        self.inputField.layer.borderColor = UIColor.gray.cgColor
        self.inputField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    func loadData() {
        DispatchQueue.global().async { [weak self] in
            if let wordsPath = Bundle.main.path(forResource: "start", ofType: "txt"){
                if let startWords = try? String(contentsOfFile: wordsPath){
                    self?.allWords = startWords.components(separatedBy: "\n").shuffled()
                    DispatchQueue.main.async { [weak self] in
                        guard let word = self?.allWords[0]  else {
                            return
                        }
                        self?.word = word
                        self?.title = word
                    }
                }
            }
        }
    }
    @IBAction func submitButtonTapped(_ sender: Any) {
    }
    @objc func textFieldChanged(textField: UITextField) {
        if let str = textField.text {
            if (str.count > 1) {
                textField.text = String(str.prefix(1))
            }
        }
        
    }
}

