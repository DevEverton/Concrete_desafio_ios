//
//  PullCell.swift
//  Desafio-Concrete-iOS
//
//  Created by Everton Carneiro on 24/01/2018.
//  Copyright © 2018 Everton. All rights reserved.
//

import UIKit

class PullCell: UITableViewCell {
    
    @IBOutlet weak var userPicture: RoundedView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var pullTitle: UILabel!
    @IBOutlet weak var pullBody: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
