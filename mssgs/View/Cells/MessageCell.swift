//
//  MessageCell.swift
//  mssgs
//
//  Created by Aura Antilochus on 5/20/22.
//  Copyright © 2022 Roman CHAIKIN. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    
    @IBOutlet weak var messageText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       // backgroundColor = .clear
        // Configure the view for the selected state
    }
    
}
