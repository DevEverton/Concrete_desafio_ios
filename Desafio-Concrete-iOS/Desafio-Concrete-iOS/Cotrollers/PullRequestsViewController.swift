//
//  PullRequestsViewController.swift
//  Desafio-Concrete-iOS
//
//  Created by Everton Carneiro on 17/01/18.
//  Copyright © 2018 Everton. All rights reserved.
//

import UIKit
import AlamofireImage
import SafariServices

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


extension PullRequestsViewController: UITableViewDataSource, UITableViewDelegate, SFSafariViewControllerDelegate {
    
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
        pullCell.date.text = formatDate(of: pullRequests[indexPath.row].date!)
        pullCell.pullTitle.text = pullRequests[indexPath.row].title
        pullCell.pullBody.text = pullRequests[indexPath.row].body

        return pullCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("PULLURL HERE: ", pullRequests[indexPath.row].html_url ?? "nil")
        let pullUrl = URL(string: pullRequests[indexPath.row].html_url!)
        let safariVC = SFSafariViewController(url: pullUrl!)
        safariVC.view.tintColor = UIColor(red:0.19, green:0.50, blue:0.80, alpha:1.0)
        safariVC.delegate = self
        self.present(safariVC, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    //TODO: Format date for older versions of ios
    
    func formatDate(of dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm"
        if #available(iOS 10.0, *) {
            let dateFormatter = ISO8601DateFormatter()
            let date = dateFormatter.date(from: dateString)
            return formatter.string(from: date!)
        }
        return dateString
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}





