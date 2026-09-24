//
//  Results.swift
//  BucketList
//
//  Created by Juan Galeazzi on 9/23/26.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}
