//
//  StarWarsPersonResponse.swift
//  Async Await Demo
//
//  Created by Trevor Whittingham on 10/6/22.
//

import Foundation

struct StarWarsPersonResponse: Decodable {
    let count: Int
    let nextURL: String?
    let previousURL: String?
    let results: [StarWarsPerson]
    
    enum CodingKeys: String, CodingKey {
        case count
        case nextURL = "next"
        case previousURL = "previous"
        case results
    }
}
