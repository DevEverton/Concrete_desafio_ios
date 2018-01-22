//
//  APIManager.swift
//  Desafio-Concrete-iOS
//
//  Created by Everton Carneiro on 17/01/18.
//  Copyright © 2018 Everton. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import ObjectMapper

class APIManager {
    
    static let shared = APIManager()
    
    private init(){}
    
    func fetchRepositoriesOfPage(_ page: Int) -> Promise<[Repository]> {
        
        return Promise<[Repository]> {
            fullfil, reject -> Void in
            return Alamofire.request(Api.URL.forPage(page)).responseString {
                response in
                switch(response.result) {
                case .success(let responseString):
                    if let repositoryResponse = RepositoryResponse(JSONString: String(responseString)){
                        fullfil(repositoryResponse.repositories!)
                    }
                case .failure(let error):
                    reject(error)
                }
            }
 
        }
        
    }
    
    func fetchPullRequestsOf(_ repository: String, by creator: String ) -> Promise<[Pull]> {
        
        return Promise<[Pull]> {
            fullfil, reject -> Void in
            return Alamofire.request(Api.URL.forPullrequests(creator: creator, repository: repository)).responseString {
                response in
                switch(response.result) {
                case .success(let responseString):
                    print("The response is: ", responseString)

                    if let pullRequestResponse = PullRequestResponse(JSONString: String(responseString)){
                        fullfil(pullRequestResponse.pulls!)

                    }
                case .failure(let error):
                    print(error)
                    reject(error)
                }
            }
        }
 
    }

    
    
}








