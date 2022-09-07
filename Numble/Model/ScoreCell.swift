//
//  ScoreCell.swift
//  Numble
//
//  Created by Oğulcan Aşa on 7.09.2022.
//

import UIKit

class ScoreCell: UITableViewCell {

    
    @IBOutlet var player1Win: UILabel!
    @IBOutlet var player2Win: UILabel!
    @IBOutlet var playersLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
