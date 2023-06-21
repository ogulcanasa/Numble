import UIKit
import CoreData

class DetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var player1Array = [String]()
    var player2Array = [String]()
    var numberOfGuess = [Int]()
    var players = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        getData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        getData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return player1Array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath) as! ScoreCell
        cell.playersLabel.text = "\(player1Array[indexPath.row]) - \(player2Array[indexPath.row])"
        if numberOfGuess[indexPath.row] % 2 == 0 {
            cell.player1Win.isHidden = true
            cell.player2Win.isHidden = false
        } else {
            cell.player1Win.isHidden = false
            cell.player2Win.isHidden = true
        }
        cell.scoreLabel.text = String(numberOfGuess[indexPath.row]) + " guess"
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext

            let fetchRequest: NSFetchRequest<Scores> = Scores.fetchRequest()

            let predicate = NSPredicate(format: "player1 == %@", player1Array[indexPath.row])
            fetchRequest.predicate = predicate

            do {
                let results = try context.fetch(fetchRequest)
                for object in results {
                    context.delete(object)
                }
                try context.save()
                player1Array.remove(at: indexPath.row)
                player2Array.remove(at: indexPath.row)
                numberOfGuess.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func getData() {
        player1Array.removeAll(keepingCapacity: false)
        player2Array.removeAll(keepingCapacity: false)
        numberOfGuess.removeAll(keepingCapacity: false)

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Scores")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let player1 = result.value(forKey: "player1") as? String {
                        self.player1Array.append(player1)
                    }
                    if let player2 = result.value(forKey: "player2") as? String {
                        self.player2Array.append(player2)
                    }
                    if let score = result.value(forKey: "score") as? Int32 {
                        self.numberOfGuess.append(Int(score))
                    }
                }
            }
        } catch {
            print("error")
        }
        tableView.reloadData()
    }
}
