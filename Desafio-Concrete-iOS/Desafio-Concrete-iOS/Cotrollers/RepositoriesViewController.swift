//
//  RepositoriesViewController.swift
//  Desafio-Concrete-iOS
//
//  Created by Everton Carneiro on 16/01/18.
//  Copyright © 2018 Everton. All rights reserved.
//

import UIKit

private let cellIdentifier = "repositorieCell"

class RepositoriesViewController: UIViewController {

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Api.URL.forPage(page: 33))

    }


}

extension RepositoriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repositoryCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RepositorieCell
        
        repositoryCell.backgroundColor = .white
        repositoryCell.userImage.image = #imageLiteral(resourceName: "user-Big").circle
        
        return repositoryCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoPR", sender: nil)
    }
    
}
