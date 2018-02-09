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
        addActivityIndicator(activityIndicator)
        activityIndicator.startAnimating()
        
        let _ = apiCall.then {
            pullRequests -> Void in
            self.pullRequests = pullRequests
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            if self.pullRequests.isEmpty {
                self.createAlertWithDismiss(withTitle: "Lista vazia", message: "Não existem pull requests em aberto para este repositório.", actionTitle: "Ok")
            }
            }.catch { error -> Void in
                self.activityIndicator.stopAnimating()
                self.createAlert(withTitle: "Erro de conexão", message: "Ocorreu um erro ao carregar os dados. Tente novamente mais tarde", actionTitle: "Ok")
            }
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
        if let pullUrl = URL(string: pullRequests[indexPath.row].html_url!) {
            let safariVC = SFSafariViewController(url: pullUrl)
            
            if #available(iOS 10.0, *) {
                safariVC.preferredControlTintColor = UIColor(red:0.20, green:0.20, blue:0.22, alpha:1.0)
            } else {
                safariVC.view.tintColor = UIColor(red:0.20, green:0.20, blue:0.22, alpha:1.0)
            }
            safariVC.delegate = self
            self.present(safariVC, animated: true, completion: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    

    func formatDate(of dateString: String) -> String {
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        isoFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = isoFormatter.date(from: dateString) {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE, MMM d, yyyy hh:mm a"
            formatter.locale = Locale(identifier: "pt_BR")
            formatter.timeZone = TimeZone(identifier: "UTC")
            let result = formatter.string(from:date)
            
            return result
        }
        return dateString

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}





