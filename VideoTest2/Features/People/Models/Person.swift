//
//  Person.swift
//  VideoTest2
//
//  Created by William Moraes on 18/04/25.
//


// MARK: - Models - People
import Foundation

struct Person: Identifiable, Codable {
    let id: Int
    let name: String
    let image: ImageLinks?
}

struct PersonShow: Identifiable, Codable {
    let id: Int
    let name: String
    let image: ImageLinks?
}

