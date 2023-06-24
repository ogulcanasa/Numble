import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet var guessButton: UIButton!
    @IBOutlet var turnLabel: UILabel!
    @IBOutlet weak var changeButtonLabel: UIButton!
    @IBOutlet weak var selectedZeroTF,selectedOneTF,selectedTwoTF,selectedThreeTF,selectedFourTF,selectedFiveTF,selectedSixTF,selectedSevenTF,selectedEightTF,selectedNineTF: UIButton!
    
    var selectedbTFButton: [UIButton] {
        return [selectedZeroTF,selectedOneTF,selectedTwoTF,selectedThreeTF,selectedFourTF,selectedFiveTF,selectedSixTF,selectedSevenTF,selectedEightTF,selectedNineTF]
    }
    var number = 0
    var userNumberArray = [Int]()
    var randomArray = [Int]()
    var notes = ""
    var set = Set<Int>()
    var common = 0
    var plus = 0
    var minus = 0
    var numberOfClicked : Int = 0 {
        didSet{
            if numberOfClicked % 2 == 0 {
                turnLabel.text = chosenPlayer1
            } else {
                turnLabel.text = chosenPlayer2
            }
        }
    }
    var selectedNumber = ""
    var nameArray = [String]()
    var scoreArray = [Int32]()
    var chosenPlayer1: String?
    var chosenPlayer2: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for item in selectedbTFButton {
            item.backgroundColor = .black
            item.tintColor = .white
            item.layer.cornerRadius = item.frame.size.width/2
            item.clipsToBounds = true
        }

        turnLabel.text = chosenPlayer1
        guessButton.isEnabled = false
        guessButton.backgroundColor = UIColor.lightGray
        guessButton.layer.cornerRadius = guessButton.frame.size.height / 2
        guessButton.clipsToBounds = true

        tabBarController?.tabBar.tintColor = .black
        numberTextField.isEnabled = false

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        while set.count < 4 {
            set.insert(Int.random(in: 0...9))
        }
        randomArray = Array(set)
        print(randomArray)
    }
    
    @IBAction func selectedNumberButtonClicked(_ sender: UIButton) {
        selectedNumber += sender.titleLabel!.text!
        numberTextField.text = selectedNumber
        if (numberTextField.text!.count) < 4 {
        sender.isEnabled = false
        } else if selectedNumber.count == 4 {
            disableOfSelectedNumbers()
            guessButton.isEnabled = true
        }

        UIView.animate(withDuration: 0.3, animations: {
                sender.transform = CGAffineTransform(scaleX: 2, y: 2)
                sender.alpha = 0
            }) { (_) in
                UIView.animate(withDuration: 0.3) {
                    sender.transform = CGAffineTransform.identity
                    sender.backgroundColor = .white
                    sender.titleLabel?.textColor = .white
                    sender.alpha = 1
                }
            }
    }
    
    @IBAction func guessButtonClicked(_ sender: Any) {
        if selectedNumber.count == 4 {
            guessButton.isEnabled = false
        } else {
            guessButton.isEnabled = true
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
        notes = notes + "\n" + "\(numberTextField.text!) ( +\(plus) / \(-minus))"
        notesLabel.text = notes
        
        if plus == 4 {
            notesLabel.text = "CONGRATULATIONS!! \n TRIAL: \(numberOfClicked)"
            numberTextField.isHidden = true
            guessButton.isHidden = true
            view.backgroundColor = UIColor.green
            numberTextField.backgroundColor = UIColor.green
            changeTFColor(color: .green)
            notesLabel.backgroundColor = .green
            changeButtonLabel.tintColor = UIColor.green
            let alertController = UIAlertController(title: "Congratulations!", message: "You guessed the number!", preferredStyle: .alert)
            let restart = UIAlertAction(title: "Play continue with same players!", style: .default) { [self] (action) in
                saveScore()
                restartGame()
            }
            let ok = UIAlertAction(title: "Change players", style: .default) { [self] (action) in
                saveScore()
                restartGame()
                performSegue(withIdentifier: "toLoginVC", sender: nil)
            }
            alertController.addAction(restart)
            alertController.addAction(ok)
            self.present(alertController, animated: true, completion: nil)
        }
        
        if numberOfClicked > 14 {
            notesLabel.text = "Let's Focus!! \n TRIAL: \(numberOfClicked)"
            numberTextField.isHidden = true
            guessButton.isHidden = true
            view.backgroundColor = UIColor.red
            numberTextField.backgroundColor = UIColor.red
            notesLabel.backgroundColor = .red
            changeTFColor(color: .red)
            changeButtonLabel.tintColor = UIColor.red
        }
        numberTextField.text = ""
        minus = 0
        common = 0
        plus = 0
        selectedNumber = ""
    }

    func saveScore() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let players = NSEntityDescription.insertNewObject(forEntityName: "Scores", into: context)

        players.setValue(chosenPlayer1, forKey: "player1")
        players.setValue(chosenPlayer2, forKey: "player2")
        players.setValue(numberOfClicked, forKey: "score")
        print(numberOfClicked)

        do {
            try context.save()
            print("success")
        } catch {
            print("error")
        }
    }
    
    @IBAction func changeTheNumberButtonClicked(_ sender: UIButton) {
        for button in selectedbTFButton {
            button.titleLabel?.textColor = .white
            button.backgroundColor = .black
            button.isEnabled = true
        }
        numberTextField.text = ""
        selectedNumber = ""
    }
    
    @IBAction func restartButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Warning!", message: "Do you want to restart the game", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { [self] _ in restartGame()
        })
        let cancelAction = UIAlertAction(title: "Back to the game!", style: UIAlertAction.Style.cancel)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

    func restartGame() {
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
        view.backgroundColor = UIColor.white
        notesLabel.backgroundColor = UIColor.white
        numberTextField.text = ""
        numberTextField.backgroundColor = UIColor.white
        numberTextField.isHidden = false
        guessButton.isHidden = false
        changeTFColor(color: .white)
        selectedNumber = ""
        enableOfSelectedNumbers()
        changeButtonLabel.tintColor = UIColor.black
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(false)
    }

    func changeTFColor(color: UIColor) {
        for button in selectedbTFButton {
            button.tintColor = color
        }
    }

    func enableOfSelectedNumbers() {
        for button in selectedbTFButton {
            button.titleLabel?.textColor = .black
            button.backgroundColor = .black
            button.isEnabled = true
        }
    }
    
    func disableOfSelectedNumbers() {
        for button in selectedbTFButton {
            button.isEnabled = false
        }
    }
}
