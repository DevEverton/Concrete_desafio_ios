//
//  RepositoriesViewController.swift
//  Desafio-Concrete-iOS
//
//  Created by Everton Carneiro on 16/01/18.
//  Copyright © 2018 Everton. All rights reserved.
//

import UIKit
import AlamofireImage

private let cellIdentifier = "repositorieCell"

class RepositoriesViewController: UIViewController {

  
    @IBOutlet weak var tableView: UITableView!
    var repositories = [Repository]()
    var pullRequestsUrl = String()
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiCall = APIManager.shared.fetchRepositoriesOfPage(1)
        let _ = apiCall.then {
            repositories -> Void in
            self.repositories = repositories
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            }.catch { error -> Void in
                
            }
        addActivityIndicator(activityIndicator)
        activityIndicator.startAnimating()

        
    }

}

extension RepositoriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repositoryCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RepositoryCell
        
        repositoryCell.userName.text = repositories[indexPath.row].user?.name
        repositoryCell.fullName.text = repositories[indexPath.row].fullName
        repositoryCell.repositoryName.text = repositories[indexPath.row].name
        repositoryCell.repositoryDescription.text = repositories[indexPath.row].description
        repositoryCell.forks.text = String(describing: repositories[indexPath.row].forks!)
        repositoryCell.stars.text = String(describing: repositories[indexPath.row].stars!)
        let url = URL(string: (repositories[indexPath.row].user?.pictureUrl!)!)
        repositoryCell.userImage.af_setImage(withURL: url!) 

        return repositoryCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "PullRequestsVC") as! PullRequestsViewController

        destination.url = Api.URL.forPullrequests(creator: (repositories[indexPath.row].user?.name)!, repository: repositories[indexPath.row].name!)
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
}
