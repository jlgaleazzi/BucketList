//
//  Location.swift
//  BucketList
//
//  Created by Juan Galeazzi on 9/22/26.
//

import Foundation

struct Location: Codable,Equatable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
}
