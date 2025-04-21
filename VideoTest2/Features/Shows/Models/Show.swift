//
//  Show.swift
//  VideoTest2
//
//  Created by William Moraes on 18/04/25.
//


// MARK: - Models - Shows
import Foundation

struct Show: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let genres: [String]
    let schedule: Schedule
    let summary: String?
    let image: ImageLinks?
    
    static func == (lhs: Show, rhs: Show) -> Bool {
        lhs.id == rhs.id
    }
    
    var formattedGenres: String {
        genres.joined(separator: ", ")
    }
    
    var scheduleText: String {
        let days = schedule.days.joined(separator: ", ")
        return "\(days) at \(schedule.time)"
    }
    
    var cleanSummary: String {
        summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression) ?? ""
    }
}

struct ImageLinks: Codable {
    let medium: String?
    let original: String?
}

struct Schedule: Codable {
    let time: String
    let days: [String]
}
