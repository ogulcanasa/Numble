//
//  DetailsVC.swift
//  Numble
//
//  Created by Oğulcan Aşa on 30.08.2022.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
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
    
    func getData() {
        
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
        switch numberOfGuess[indexPath.row] {
        case 1:
            cell.scoreLabel.text = "5"
        case 2:
            cell.scoreLabel.text = "4"
        case 3...4:
            cell.scoreLabel.text = "3"
        case 5:
            cell.scoreLabel.text = "2"
        default:
            cell.scoreLabel.text = "1"
        }
        return cell
    }
    
    @IBAction func clearButtonClicked(_ sender: Any) {
        
        let alert = UIAlertController(title: "Warning!", message: "Do you want to clear the scoreboard?", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {_ in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Scores")
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        context.delete(result)
                        try context.save()
                    }
                    self.player1Array.removeAll()
                    self.player2Array.removeAll()
                    self.tableView.reloadData()
                }
            } catch {
                print("error")
            }
        })
        let cancelAction = UIAlertAction(title: "Back to the game!", style: UIAlertAction.Style.cancel)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}
