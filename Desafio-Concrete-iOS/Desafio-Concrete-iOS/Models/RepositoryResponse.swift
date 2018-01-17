//
//  RepositoryResponse.swift
//  Desafio-Concrete-iOS
//
//  Created by Everton Carneiro on 17/01/18.
//  Copyright © 2018 Everton. All rights reserved.
//

import Foundation
import ObjectMapper


class RepositoryResponse: Mappable {
    
    var repositories: [Repository]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        repositories <- map["items"]
    }

}

class Repository: Mappable {
    
    var name: String?
    var fullName: String?
    var description: String?
    var stars: Int?
    var forks: Int?
    var user: User?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name <- map["name"]
        fullName <- map["full_name"]
        description <- map["description"]
        stars <- map["stargazers_count"]
        forks <- map["forks_count"]
        user <- map["owner"]
    }
}

class User: Mappable {
    var name: String?
    var pictureUrl: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name <- map["login"]
        pictureUrl <- map["avatar_url"]
    }
}







