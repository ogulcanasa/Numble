//
//  ViewController.swift
//  Numble
//
//  Created by Oğulcan Aşa on 21.02.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var buttonLabel: UIButton!
    @IBOutlet weak var changeButtonLabel: UIButton!
    @IBOutlet weak var selectedZeroTF,selectedOneTF,selectedTwoTF,selectedThreeTF,selectedFourTF,selectedFiveTF,selectedSixTF,selectedSevenTF,selectedEightTF,selectedNineTF: UIButton!
    @IBOutlet weak var zeroTF,oneTF,twoTF,threeTF,fourTF,fiveTF,sixTF,sevenTF,eightTF,nineTF: UIButton!

    var number = ""
    var numberInt : Int!
    var userNumberArray = [Int]()
    var randomArray = [Int]()
    var notes = ""
    var newNote = ""
    var set = Set<Int>()
    var common = 0
    var plus = 0
    var minus = 0
    private var numberOfClicked = 0
    var selectedNumber = ""
    var player: AVAudioPlayer!
    private var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberTextField.isEnabled = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
           view.addGestureRecognizer(tap)
    }
    
    @IBAction func selectedNumberButtonClicked(_ sender: UIButton) {
        if player != nil {
            player.stop()
        }
        timer.invalidate()
        selectedNumber = selectedNumber + (sender.titleLabel!.text!)
        numberTextField.text = selectedNumber
        if (numberTextField.text!.count) < 4 {
        sender.isEnabled = false
        } else if selectedNumber.count == 4 {
            disableOfSelectedNumbers()
        }
    }
    
    @IBAction func guessButtonClicked(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(timeIsUp), userInfo: nil, repeats: false)
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
            userNumberArray = [Int(numberInt/1000), Int((numberInt%1000)/100) , Int((numberInt%100)/10) , Int(numberInt%10)]
        }

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
            if set.count == 0 {
                notes = "\(numberTextField.text!) ( 0 / 0 )"
                notesLabel.text = notes
                numberTextField.text = ""
            } else {
            minus = common - plus
            if plus == 0 {
            newNote = "\(numberTextField.text!) ( \(plus) / \(-minus))"
            } else {
            newNote = "\(numberTextField.text!) ( +\(plus) / \(-minus))"
            }
            notes = notes + "\n \(newNote)"
            notesLabel.text = notes
            numberTextField.text = ""
            print(randomArray)
            }
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
            if plus == 0 {
            newNote = "\(numberTextField.text!) ( \(plus) / \(-minus))"
            } else {
            newNote = "\(numberTextField.text!) ( +\(plus) / \(-minus))"
            }
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
            makeTFRed()
            makeSelectedTFRed()
        }
        selectedNumber = ""
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
            buttonLabel.titleLabel?.text = "Make a guess!"
            set = []
            while set.count < userNumberArray.count {
                set.insert(Int.random(in: 0...9))
                }
            randomArray = Array(set)
            print(set)
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
        if player != nil {
            player.stop()
            player = nil
        } else {
            timeIsUp()
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func timeIsUp() {
        let url = Bundle.main.url(forResource: "timeIsUp", withExtension: "mp3")
           player = try! AVAudioPlayer(contentsOf: url!)
           player.play()
    }
    
    func makeSelectedTFBlack() {
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
    }
    
    func makeSelectedTFRed() {
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
        changeButtonLabel.tintColor = UIColor.red
    }
    
    func makeSelectedTFGreen() {
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
    
    func makeTFRed() {
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
    }
    
    func makeTFGreen() {
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
