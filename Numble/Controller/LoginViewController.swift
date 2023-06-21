import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet var player2TextField: UITextField!
    @IBOutlet var player1TextField: UITextField!
    var selectedPlayer1: String?
    var selectedPlayer2: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

        player1TextField.layer.masksToBounds = true
        player1TextField.borderStyle = .line
        player1TextField.layer.cornerRadius = 7
        player2TextField.layer.masksToBounds = true
        player2TextField.borderStyle = .line
        player2TextField.layer.cornerRadius = 7

    }
    
    @objc func dismissKeyboard() {
        view.endEditing(false)
    }

    @IBAction func playButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "toMainVC", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tabBarController = segue.destination as? UITabBarController {
            if let vc = tabBarController.viewControllers?.first as? ViewController {
                vc.chosenPlayer1 = player1TextField.text
                vc.chosenPlayer2 = player2TextField.text
            }
        }
    }

}
