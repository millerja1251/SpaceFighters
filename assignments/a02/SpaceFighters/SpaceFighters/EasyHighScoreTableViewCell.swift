//
//  HighScoreTableViewCell.swift
//  SpaceFighters
//
//  Created by Katie Stevenson on 4/16/22.
//
//  Jackson Miller jm122@iu.edu
//  Elliot Helwig ehelwig@iu.edu
//  Hyungsuk Kang kang18@iu.edu

import UIKit

class EasyHighScoreTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var playerScore: UILabel!
    @IBOutlet weak var playerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
