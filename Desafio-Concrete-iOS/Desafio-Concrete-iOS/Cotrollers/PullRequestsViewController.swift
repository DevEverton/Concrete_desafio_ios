//
//  PullRequestsViewController.swift
//  Desafio-Concrete-iOS
//
//  Created by Everton Carneiro on 17/01/18.
//  Copyright © 2018 Everton. All rights reserved.
//

import UIKit
import AlamofireImage

private let pullCellIdentifier = "PRCell"

class PullRequestsViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var repoCreator = String()
    var repoName = String()
    var pullRequests = [Pull]()
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = "Pull Requests"
        
                
        let apiCall = APIManager.shared.fetchPullRequestsOf(repoName, by: repoCreator)
        
        let _ = apiCall.then {
            pullRequests -> Void in
            self.pullRequests = pullRequests
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            }.catch { error -> Void in
                
            }
        addActivityIndicator(activityIndicator)
        activityIndicator.startAnimating()
    }

}


extension PullRequestsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pullRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pullCell = tableView.dequeueReusableCell(withIdentifier: pullCellIdentifier) as! PullCell
        
        pullCell.userName.text = pullRequests[indexPath.row].creator?.name
        let url = URL(string: (pullRequests[indexPath.row].creator?.pictureUrl!)!)
        pullCell.userPicture.af_setImage(withURL: url!)
        pullCell.date.text = pullRequests[indexPath.row].date
        pullCell.pullTitle.text = pullRequests[indexPath.row].title
        pullCell.pullBody.text = pullRequests[indexPath.row].body

        return pullCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}








