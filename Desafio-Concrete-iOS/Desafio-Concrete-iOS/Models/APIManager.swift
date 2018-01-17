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
                    print(responseString)
                    if let repositoryResponse = RepositoryResponse(JSONString: String(responseString)){
                        fullfil(repositoryResponse.repositories!)
                    }
                case .failure(let error):
                    print(error)
                    reject(error)
                }
            }
 
        }
        
    }
}
