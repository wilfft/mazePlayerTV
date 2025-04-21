//
//  File.swift
//  VideoTest2
//
//  Created by William Moraes on 17/04/25.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]?
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.tvmaze.com"
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
    
    init(path: String, queryItems: [URLQueryItem]? = nil) {
        self.path = path
        self.queryItems = queryItems
    }
}
