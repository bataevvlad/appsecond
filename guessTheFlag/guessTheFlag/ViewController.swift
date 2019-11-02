//
//  ViewController.swift
//  guessTheFlag
//
//  Created by Vlad Bataev on 10/28/19.
//  Copyright © 2019 Vlad Bataev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var buttonUpdate: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var answersCount = 0
    var wrongAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        countries.shuffle()
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil ) {
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        var title: String
        
        answersCount += 1

        if sender.tag == correctAnswer {
            title = "Correct this is flag of \(countries[sender.tag])"
            score += 1
        } else {
            title = "Wrong, this is flag of \(countries[sender.tag])"
            score -= 1
        }
         
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
        
        if answersCount == 10 {
            let ac = UIAlertController(title: "Game end", message: "You clicked 10 times", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok!", style: .default, handler: askQuestion))
            present(ac, animated: true)
            answersCount = 0
            score = 0
        }
        self.navigationItem.title = "Your score is \(score)"

    }
    
    @IBAction func updateCountries(_ sender: UIButton) {
        countries.shuffle()
        let ac = UIAlertController(title: "Update", message: "Updating countries!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok!", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
}

