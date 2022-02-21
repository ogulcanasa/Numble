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
    
    @IBOutlet weak var zeroTF: UIButton!
    @IBOutlet weak var oneTF: UIButton!
    @IBOutlet weak var twoTF: UIButton!
    @IBOutlet weak var threeTF: UIButton!
    @IBOutlet weak var fourTF: UIButton!
    @IBOutlet weak var fiveTF: UIButton!
    @IBOutlet weak var sixTF: UIButton!
    @IBOutlet weak var sevenTF: UIButton!
    @IBOutlet weak var eightTF: UIButton!
    @IBOutlet weak var nineTF: UIButton!
    
    
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
         view.addGestureRecognizer(tap)
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
            let newNote = "\(numberTextField.text!) ( \(plus) / \(-minus))"
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
            zeroTF.tintColor = UIColor.green
            oneTF.tintColor = UIColor.green
            twoTF.tintColor = UIColor.green
            threeTF.tintColor = UIColor.green
            fourTF.tintColor = UIColor.green
            fiveTF.tintColor = UIColor.green
            sixTF.tintColor = UIColor.green
            sevenTF.tintColor = UIColor.green
            eightTF.tintColor = UIColor.green
            nineTF.tintColor = UIColor.green
        }
    }
    
    @IBAction func numberButtonClicked(_ sender: UIButton) {
        sender.tintColor = UIColor.white
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
        zeroTF.tintColor = UIColor.black
        oneTF.tintColor = UIColor.black
        twoTF.tintColor = UIColor.black
        threeTF.tintColor = UIColor.black
        fourTF.tintColor = UIColor.black
        fiveTF.tintColor = UIColor.black
        sixTF.tintColor = UIColor.black
        sevenTF.tintColor = UIColor.black
        eightTF.tintColor = UIColor.black
        nineTF.tintColor = UIColor.black
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

