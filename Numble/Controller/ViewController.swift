//
//  ViewController.swift
//  Numble
//
//  Created by Oğulcan Aşa on 21.02.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
    
    @IBOutlet var player1TextField: UITextField!
    @IBOutlet var player2TextField: UITextField!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var buttonLabel: UIButton!
    @IBOutlet weak var changeButtonLabel: UIButton!
    @IBOutlet weak var selectedZeroTF,selectedOneTF,selectedTwoTF,selectedThreeTF,selectedFourTF,selectedFiveTF,selectedSixTF,selectedSevenTF,selectedEightTF,selectedNineTF: UIButton!
    @IBOutlet weak var zeroTF,oneTF,twoTF,threeTF,fourTF,fiveTF,sixTF,sevenTF,eightTF,nineTF: UIButton!
    
    var selectedbTFButton: [UIButton] {
        return [selectedZeroTF,selectedOneTF,selectedTwoTF,selectedThreeTF,selectedFourTF,selectedFiveTF,selectedSixTF,selectedSevenTF,selectedEightTF,selectedNineTF]
    }
    var textFieldButton: [UIButton] {
        return [zeroTF,oneTF,twoTF,threeTF,fourTF,fiveTF,sixTF,sevenTF,eightTF,nineTF]
    }
    var number = 0
    var userNumberArray = [Int]()
    var randomArray = [Int]()
    var notes = ""
    var newNote = ""
    var set = Set<Int>()
    var common = 0
    var plus = 0
    var minus = 0
    var numberOfClicked : Int = 0
    var selectedNumber = ""
    var nameArray = [String]()
    var scoreArray = [Int32]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberTextField.isEnabled = false
        buttonLabel.isEnabled = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        while set.count < 4 {
            set.insert(Int.random(in: 0...9))
        }
        randomArray = Array(set)
    }
    
    @IBAction func selectedNumberButtonClicked(_ sender: UIButton) {
        selectedNumber += sender.titleLabel!.text!
        numberTextField.text = selectedNumber
        if (numberTextField.text!.count) < 4 {
        sender.isEnabled = false
        } else if selectedNumber.count == 4 {
            disableOfSelectedNumbers()
            buttonLabel.isEnabled = true
        }
    }
    
    @IBAction func guessButtonClicked(_ sender: Any) {
        if selectedNumber.count == 4 {
            buttonLabel.isEnabled = false
        } else {
            buttonLabel.isEnabled = true
        }
        numberOfClicked += 1
        number = Int(numberTextField.text ?? "0000") ?? 0000

        userNumberArray = [Int(number/1000),Int((number%1000)/100),Int((number%100)/10),Int(number%10)]

        enableOfSelectedNumbers()
        
        for i in 0...3 {
            if randomArray[i] == userNumberArray[i] {
                plus += 1 }
            for j in 0...3 {
                if randomArray[i] == userNumberArray[j] {
                    common += 1
        }}}

        minus = common - plus
        newNote = "\(numberTextField.text!) ( +\(plus) / \(-minus))"
        notes = notes + "\n \(newNote)"
        notesLabel.text = notes
        
        if plus == 4 {
            notesLabel.text = "CONGRATULATIONS!! \n TRIAL: \(numberOfClicked)"
            numberTextField.isHidden = true
            buttonLabel.isHidden = true
            view.backgroundColor = UIColor.green
            numberTextField.backgroundColor = UIColor.green
            makeSelectedTFGreen()
            makeTFGreen()
            changeButtonLabel.tintColor = UIColor.green
        }
        
        if numberOfClicked > 19 {
            notesLabel.text = "Let's Focus!! \n TRIAL: \(numberOfClicked)"
            numberTextField.isHidden = true
            buttonLabel.isHidden = true
            view.backgroundColor = UIColor.red
            numberTextField.backgroundColor = UIColor.red
            makeSelectedTFRed()
            makeTFRed()
            changeButtonLabel.tintColor = UIColor.red
        }
        numberTextField.text = ""
        minus = 0
        common = 0
        plus = 0
        selectedNumber = ""
    }

    @IBAction func saveButtonClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let players = NSEntityDescription.insertNewObject(forEntityName: "Scores", into: context)
        
        //Attributes
        
        players.setValue(player1TextField.text!, forKey: "player1")
        players.setValue(player2TextField.text!, forKey: "player2")
        players.setValue(numberOfClicked, forKey: "score")
        
        do {
            try context.save()
            print("success")
        } catch {
            print("error")
        }
        
        player1TextField.text = ""
        player2TextField.text = ""
    }
        
    
    @IBAction func scoreButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }

    @IBAction func numberButtonClicked(_ sender: UIButton) {
        sender.tintColor = UIColor.systemTeal
    }
    
    @IBAction func changeTheNumberButtonClicked(_ sender: UIButton) {
        enableOfSelectedNumbers()
        numberTextField.text = ""
        selectedNumber = ""
    }
    
    @IBAction func restartButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Warning!", message: "Do you want to restart the game", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { [self] action in
            set.removeAll()
            while set.count < 4 {
                set.insert(Int.random(in: 0...9))
            }
            randomArray = Array(set)
            notes = ""
            notesLabel.text = "Notes"
            common = 0
            minus = 0
            plus = 0
            numberOfClicked = 0
            view.backgroundColor = UIColor.systemTeal
            numberTextField.text = ""
            numberTextField.backgroundColor = UIColor.systemTeal
            numberTextField.isHidden = false
            buttonLabel.isHidden = false
            changeColorOfTintColorToBlack()
            makeSelectedTFBlack()
            selectedNumber = ""
            enableOfSelectedNumbers()
            changeButtonLabel.tintColor = UIColor.black
        })
        let cancelAction = UIAlertAction(title: "Back to the game!", style: UIAlertAction.Style.cancel)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(false)
    }
    
    func makeSelectedTFBlack() {
        for textField in selectedbTFButton {
            textField.tintColor = UIColor.black
        }
    }
    
    func makeSelectedTFRed() {
        for textField in selectedbTFButton {
            textField.tintColor = UIColor.red
    }}
    
    func makeSelectedTFGreen() {
        for textField in selectedbTFButton {
            textField.tintColor = UIColor.green
    }}
    
    func enableOfSelectedNumbers() {
        for textField in selectedbTFButton {
            textField.isEnabled = true
    }}
    
    func disableOfSelectedNumbers() {
        for textField in selectedbTFButton {
            textField.isEnabled = false
    }}
    
    func makeTFRed() {
        for textField in textFieldButton {
            textField.tintColor = UIColor.red
    }}
    
    func makeTFGreen() {
        for textField in textFieldButton {
            textField.tintColor = UIColor.green
    }}
    
    func changeColorOfTintColorToBlack() {
        for textField in textFieldButton {
            textField.tintColor = UIColor.black
    }}
    
    @IBAction func quickGuessButtonClicked(_ sender: Any) {
        Timer.scheduledTimer(timeInterval: 20.0, target:self, selector: #selector(quickGuess), userInfo:nil, repeats: false)
    }
    
    @objc func quickGuess() {
        let alert = UIAlertController(title: "Time's up", message: "Let's see your guess", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
