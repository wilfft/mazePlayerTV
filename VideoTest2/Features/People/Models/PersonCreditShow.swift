//
//  File.swift
//  VideoTest2
//
//  Created by William Moraes on 18/04/25.
//

import Foundation
struct PersonCredit: Decodable {
    
    let voice: Bool
    let isSelf: Bool  // Renamed from 'self' to avoid keyword conflict
    let links: Links
    let embedded: Embedded
    
    enum CodingKeys: String, CodingKey {
        case voice
        case isSelf = "self"  // Map "self" from JSON to "isSelf" in Swift
        case links = "_links"
        case embedded = "_embedded"
    }
    
    struct Links: Decodable {
        let character: CharacterInfo
        let show: ShowInfo
        
        struct CharacterInfo: Decodable {
            let name: String
            let href: String
        }
        
        struct ShowInfo: Decodable {
            let name: String
            let href: String
        }
    }
    
    struct Embedded: Decodable {
        let show: Show
        
        struct Show: Decodable {
            let id: Int
            let name: String
            let summary: String?
            let image: ImageLinks?
            // Add more properties as needed
            
            struct ImageLinks: Decodable {
                let medium: String?
                let original: String?
            }
        }
    }
}
