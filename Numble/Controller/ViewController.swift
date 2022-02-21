//
//  ViewController.swift
//  Numble
//
//  Created by Oğulcan Aşa on 21.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var buttonLabel: UIButton!
    
    var number = ""
    var numberInt : Int!
    var userNumberArray = [Int]()
    var randomArray = [Int]()
    var notes = ""
    var set = Set<Int>()
    var common = 0
    var plus = 0
    var minus = 0
    private var numberOfClicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func guessButtonClicked(_ sender: Any) {
        
        (sender as AnyObject).setTitle("Continue to guess...", for: .normal)
        number = numberTextField.text!
        numberInt = Int(number)
        userNumberArray = [Int(numberInt/1000), Int((numberInt%1000)/100) , Int((numberInt%100)/10) , Int(numberInt%10)]

        if (buttonLabel.titleLabel?.text == "Make a guess!") {
            numberOfClicked += 1
            while set.count < userNumberArray.count {
                set.insert(Int.random(in: 0...9))
                }
            randomArray = Array(set)
            for i in 0...3 {
                if randomArray[i] == userNumberArray[i] {
                    plus += 1 }
                for j in 0...3 {
                    if randomArray[i] == userNumberArray[j] {
                        common += 1
                    }
                }
            }
            minus = common - plus
            notes = "\(numberTextField.text!) ( \(plus) / \(-minus))"
            notesLabel.text = notes
            numberTextField.text = ""
            print(randomArray)
        } else {
            numberOfClicked += 1
            common = 0
            minus = 0
            plus = 0
            for i in 0...3 {
                if randomArray[i] == userNumberArray[i] {
                    plus += 1 }
                for j in 0...3 {
                    if randomArray[i] == userNumberArray[j] {
                        common += 1
                    }
                }
            }
            minus = common - plus
            var newNote = "\(numberTextField.text!) ( \(plus) / \(-minus))"
            notes = notes + "\n \(newNote)"
            notesLabel.text = notes
            numberTextField.text = ""
        }
        
        if plus == 4 {
            notesLabel.text = "CONGRATULATIONS!! \n TRIAL: \(numberOfClicked)"
            numberTextField.isHidden = true
            buttonLabel.isHidden = true
            view.backgroundColor = UIColor.green
            numberTextField.backgroundColor = UIColor.green
        }
    }
    
    @IBAction func restartButtonClicked(_ sender: Any) {
        buttonLabel.titleLabel?.text = "Make a guess!"
        set = []
        while set.count < userNumberArray.count {
            set.insert(Int.random(in: 0...9))
            }
        randomArray = Array(set)
        print(set)
        notes = ""
        numberTextField.text = ""
        notesLabel.text = "Notes"
        common = 0
        minus = 0
        plus = 0
        numberOfClicked = 0
        view.backgroundColor = UIColor.white
        numberTextField.backgroundColor = UIColor.white
        numberTextField.isHidden = false
        buttonLabel.isHidden = false
    }
}

