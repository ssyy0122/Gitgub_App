//
//  Repository.swift
//  GitHubRepository
//
//  Created by 진시윤 on 2021/12/14.
//

import Foundation

struct Repository: Decodable {
    let id: Int
    let name: String
    let description: String
    let stargezersCount: Int
    let language: String
    
    enum CodingKeys: String, CodingKey {
        case id,name,description,language
        case stargezersCount = "stargazers_count"
    }
}
