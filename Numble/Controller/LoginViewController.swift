import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet var player2TextField: UITextField!
    @IBOutlet var player1TextField: UITextField!
    @IBOutlet var playButton: UIButton!

    var selectedPlayer1: String?
    var selectedPlayer2: String?

    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!

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

        UIView.animate(withDuration: 1.3, delay: 0.3, options: [.curveEaseInOut]) {
            self.player1TextField.center = CGPoint(x: self.player1TextField.center.x - 50, y: self.player1TextField.center.y)
            self.player2TextField.center = CGPoint(x: self.player2TextField.center.x + 50, y: self.player2TextField.center.y)
            self.playButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(false)
    }

    @IBAction func playButtonClicked(_ sender: UIButton) {
        dismissKeyboard()
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior(items: [player1TextField, player2TextField, playButton])

        let collision = UICollisionBehavior(items: [player1TextField,player2TextField, playButton])
        collision.translatesReferenceBoundsIntoBoundary = true

        let boundaryPath = UIBezierPath(ovalIn: CGRect(x: view.frame.width/2, y: view.frame.height/2, width: 30, height: 30))
        collision.addBoundary(withIdentifier: "boundary" as NSCopying, for: boundaryPath)

        animator.addBehavior(collision)
        animator.addBehavior(gravity)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.performSegue(withIdentifier: "toMainVC", sender: self)
        }
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
