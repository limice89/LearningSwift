//
//  ViewController.swift
//  Project5
//
//  Created by admin on 2019/8/19.
//  Copyright © 2019 limice. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        startGame()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        // Do any additional setup after loading the view.
    }
    
    @objc func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "输入答案", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "提交", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        let errorTitle: String
        let errorMessage: String
        
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(lowerAnswer, at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    return
                }else {
                    errorTitle = "单词错误"
                    errorMessage = "拼写的单词不能少于三个字母且不能为原始单词"
                }
            }else {
                errorTitle = "单词已存在"
                errorMessage = "当前答案中已存在该单词"
            }
        }else {
            guard let title = title?.lowercased() else { return }
            errorTitle = "单词无效"
            errorMessage = "拼写的单词字母没有从\(title)中获取"
        }
        showErrorMessage(title: errorTitle, message: errorMessage)
        
    }
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else {
            return false
        }
        for letter in word {
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            }else {
                return false
            }
        }
        return true
    }
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    func isReal(word: String) -> Bool {
        guard let tempWord = title?.lowercased() else {
            return false
        }
        if word.utf16.count <= 3 || word == tempWord  {
            return false
        }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
        
    }
    func showErrorMessage(title: String,message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
        
    }


}

