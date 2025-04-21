//
//  Episode.swift
//  VideoTest2
//
//  Created by William Moraes on 18/04/25.
//

import Foundation

struct Episode: Identifiable, Codable {
    let id: Int
    let name: String
    let number: Int
    let season: Int
    let summary: String?
    let image: ImageLinks?
    
    var cleanSummary: String {
        summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression) ?? ""
    }
}

struct SearchResult: Codable, Identifiable {
    let show: Show
    
    var id: Int { show.id }
}

struct PeopleSearchResult: Codable, Identifiable {
    let person: Person
    
    var id: Int { person.id }
}
