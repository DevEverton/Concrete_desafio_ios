//
//  PullRequestsViewController.swift
//  Desafio-Concrete-iOS
//
//  Created by Everton Carneiro on 17/01/18.
//  Copyright © 2018 Everton. All rights reserved.
//

import UIKit

class PullRequestsViewController: UIViewController {
    
    var url = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        
        print("THE URL IS FUCK: ", url)
    }


}
