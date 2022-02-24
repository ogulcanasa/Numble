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
    
    @IBOutlet weak var selectedZeroTF: UIButton!
    @IBOutlet weak var selectedOneTF: UIButton!
    @IBOutlet weak var selectedTwoTF: UIButton!
    @IBOutlet weak var selectedThreeTF: UIButton!
    @IBOutlet weak var selectedFourTF: UIButton!
    @IBOutlet weak var selectedFiveTF: UIButton!
    @IBOutlet weak var selectedSixTF: UIButton!
    @IBOutlet weak var selectedSevenTF: UIButton!
    @IBOutlet weak var selectedEightTF: UIButton!
    @IBOutlet weak var selectedNineTF: UIButton!
    
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
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    
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
    var selectedNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberTextField.isEnabled = false
    }
    
    @IBAction func selectedNumberButtonClicked(_ sender: UIButton) {
        selectedNumber = selectedNumber + (sender.titleLabel!.text!)
        numberTextField.text = selectedNumber
        if (numberTextField.text!.count) < 4 {
        sender.isEnabled = false
        } else if selectedNumber.count == 4 {
            disableOfSelectedNumbers()
        }
    }
    
    @IBAction func guessButtonClicked(_ sender: Any) {
        (sender as AnyObject).setTitle("Continue to guess...", for: .normal)
        number = numberTextField.text ?? "0000"
        numberInt = Int(number) ?? 0000
        
        if numberTextField.text == "" {
            userNumberArray = [0,0,0,0]
            common = 0
            minus = 0
            plus = 0
            numberTextField.text = "0000"
        } else if numberTextField.text!.count < 4{
            userNumberArray = [0,0,0,0]
            numberTextField.text = "0000"
        } else {
            userNumberArray = [Int(numberInt/1000), Int((numberInt%1000)/100) , Int((numberInt%100)/10) , Int(numberInt%10)] }

        if (buttonLabel.titleLabel?.text == "Make a guess!") {
            enableOfSelectedNumbers()
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
            enableOfSelectedNumbers()
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
            textField1.isEnabled = false
            textField2.isEnabled = false
            textField3.isEnabled = false
            textField4.isEnabled = false
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
            selectedZeroTF.tintColor = UIColor.green
            selectedOneTF.tintColor = UIColor.green
            selectedTwoTF.tintColor = UIColor.green
            selectedThreeTF.tintColor = UIColor.green
            selectedFourTF.tintColor = UIColor.green
            selectedFiveTF.tintColor = UIColor.green
            selectedSixTF.tintColor = UIColor.green
            selectedSevenTF.tintColor = UIColor.green
            selectedEightTF.tintColor = UIColor.green
            selectedNineTF.tintColor = UIColor.green
            textField1.backgroundColor = UIColor.green
            textField2.backgroundColor = UIColor.green
            textField3.backgroundColor = UIColor.green
            textField4.backgroundColor = UIColor.green
            textField1.text = String(userNumberArray[0])
            textField2.text = String(userNumberArray[1])
            textField3.text = String(userNumberArray[2])
            textField4.text = String(userNumberArray[3])
        }
        
        if numberOfClicked > 19 {
            notesLabel.text = "Let's Focus!! \n TRIAL: \(numberOfClicked)"
            numberTextField.isHidden = true
            buttonLabel.isHidden = true
            view.backgroundColor = UIColor.red
            numberTextField.backgroundColor = UIColor.red
            zeroTF.tintColor = UIColor.red
            oneTF.tintColor = UIColor.red
            twoTF.tintColor = UIColor.red
            threeTF.tintColor = UIColor.red
            fourTF.tintColor = UIColor.red
            fiveTF.tintColor = UIColor.red
            sixTF.tintColor = UIColor.red
            sevenTF.tintColor = UIColor.red
            eightTF.tintColor = UIColor.red
            nineTF.tintColor = UIColor.red
            selectedZeroTF.tintColor = UIColor.red
            selectedOneTF.tintColor = UIColor.red
            selectedTwoTF.tintColor = UIColor.red
            selectedThreeTF.tintColor = UIColor.red
            selectedFourTF.tintColor = UIColor.red
            selectedFiveTF.tintColor = UIColor.red
            selectedSixTF.tintColor = UIColor.red
            selectedSevenTF.tintColor = UIColor.red
            selectedEightTF.tintColor = UIColor.red
            selectedNineTF.tintColor = UIColor.red
            textField1.backgroundColor = UIColor.red
            textField2.backgroundColor = UIColor.red
            textField3.backgroundColor = UIColor.red
            textField4.backgroundColor = UIColor.red
            textField1.backgroundColor = UIColor.red
            textField2.backgroundColor = UIColor.red
            textField3.backgroundColor = UIColor.red
            textField4.backgroundColor = UIColor.red
            textField1.text = ""
            textField2.text = ""
            textField3.text = ""
            textField4.text = ""
            textField1.isEnabled = false
            textField2.isEnabled = false
            textField3.isEnabled = false
            textField4.isEnabled = false
        }
        selectedNumber = ""
    }
    
    @IBAction func numberButtonClicked(_ sender: UIButton) {
        sender.tintColor = UIColor.systemTeal
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
        view.backgroundColor = UIColor.systemTeal
        numberTextField.backgroundColor = UIColor.systemTeal
        numberTextField.isHidden = false
        buttonLabel.isHidden = false
        changeColorOfTintColorToBlack()
        selectedZeroTF.tintColor = UIColor.black
        selectedOneTF.tintColor = UIColor.black
        selectedTwoTF.tintColor = UIColor.black
        selectedThreeTF.tintColor = UIColor.black
        selectedFourTF.tintColor = UIColor.black
        selectedFiveTF.tintColor = UIColor.black
        selectedSixTF.tintColor = UIColor.black
        selectedSevenTF.tintColor = UIColor.black
        selectedEightTF.tintColor = UIColor.black
        selectedNineTF.tintColor = UIColor.black
        textField1.backgroundColor = UIColor.systemTeal
        textField2.backgroundColor = UIColor.systemTeal
        textField3.backgroundColor = UIColor.systemTeal
        textField4.backgroundColor = UIColor.systemTeal
        textField1.text = ""
        textField2.text = ""
        textField3.text = ""
        textField4.text = ""
        textField1.isEnabled = true
        textField2.isEnabled = true
        textField3.isEnabled = true
        textField4.isEnabled = true
        selectedNumber = ""
        enableOfSelectedNumbers()
    }
    
    func enableOfSelectedNumbers() {
        selectedZeroTF.isEnabled = true
        selectedOneTF.isEnabled = true
        selectedTwoTF.isEnabled = true
        selectedThreeTF.isEnabled = true
        selectedFourTF.isEnabled = true
        selectedFiveTF.isEnabled = true
        selectedSixTF.isEnabled = true
        selectedSevenTF.isEnabled = true
        selectedEightTF.isEnabled = true
        selectedNineTF.isEnabled = true
    }
    
    func disableOfSelectedNumbers() {
        selectedZeroTF.isEnabled = false
        selectedOneTF.isEnabled = false
        selectedTwoTF.isEnabled = false
        selectedThreeTF.isEnabled = false
        selectedFourTF.isEnabled = false
        selectedFiveTF.isEnabled = false
        selectedSixTF.isEnabled = false
        selectedSevenTF.isEnabled = false
        selectedEightTF.isEnabled = false
        selectedNineTF.isEnabled = false
    }
    
    func changeColorOfTintColorToBlack() {
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
        zeroTF.tintColor = UIColor.black
        
    }
}
