//
//  PullRequestsResponse.swift
//  Desafio-Concrete-iOS
//
//  Created by Everton Carneiro on 19/01/18.
//  Copyright © 2018 Everton. All rights reserved.
//

import Foundation
import ObjectMapper

class PullRequestResponse: Mappable {
    
    var pulls: [Pull]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        pulls <- map
    }
}

class Pull: Mappable{
    
    var creator: Creator?
    var title: String?
    var body: String?
    var date: Date?
    
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        creator <- map["user"]
        title <- map["title"]
        body <- map["body"]
        date <- map["created_at"]
    }
}


class Creator: Mappable {
    
    var name: String?
    var pictureUrl: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name <- map["login"]
        pictureUrl <- map["avatar_url"]
    }
}






