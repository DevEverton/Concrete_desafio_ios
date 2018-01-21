//
//  ApiUrl.swift
//  Desafio-Concrete-iOS
//
//  Created by Everton Carneiro on 17/01/18.
//  Copyright © 2018 Everton. All rights reserved.
//

import Foundation

class Api {
    
    static var URL = Api()
    
    private init() {}
    
    func forPage(_ page: Int) -> String {
        let repoUrl = "https://api.github.com/search/repositories?q=language:Java&sort=stars&page="
        return repoUrl + String(page)
    }
    
    func forPullrequests(creator: String, repository: String) -> String{
        let pullRequestsUrl = "https://api.github.com/repos/\(creator)/\(repository)/pulls"
        return pullRequestsUrl
    }

}
