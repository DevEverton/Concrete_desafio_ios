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
    var url = "https://api.github.com/search/repositories?q=language:Java&sort=stars&page="
    
    private init() {}
    
    func forPage(page: Int) -> String {
        
        return url + String(page)
    }

}
