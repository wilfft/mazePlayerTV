//
//  TVMazeService.swift
//  VideoTest2
//
//  Created by William Moraes on 18/04/25.
//

// MARK: - TVMaze Service
import Foundation
import Combine

class TVMazeService {
    private let apiClient = APIClient.shared
    
    // MARK: - Shows
    func fetchShows(page: Int) -> AnyPublisher<[Show], APIError> {
        let endpoint = Endpoint(path: "/shows", queryItems: [URLQueryItem(name: "page", value: String(page))])
        return apiClient.fetch(endpoint: endpoint)
    }
    
    func searchShows(query: String) -> AnyPublisher<[SearchResult], APIError> {
        let endpoint = Endpoint(path: "/search/shows", queryItems: [URLQueryItem(name: "q", value: query)])
        return apiClient.fetch(endpoint: endpoint)
    }
    
    func fetchShowDetails(id: Int) -> AnyPublisher<Show, APIError> {
        let endpoint = Endpoint(path: "/shows/\(id)")
        return apiClient.fetch(endpoint: endpoint)
    }
    
    func fetchShowEpisodes(id: Int) -> AnyPublisher<[Episode], APIError> {
        let endpoint = Endpoint(path: "/shows/\(id)/episodes")
        return apiClient.fetch(endpoint: endpoint)
    }
    
    // MARK: - People
    func searchPeople(query: String) -> AnyPublisher<[PeopleSearchResult], APIError> {
        let endpoint = Endpoint(path: "/search/people", queryItems: [URLQueryItem(name: "q", value: query)])
        return apiClient.fetch(endpoint: endpoint)
    }
    
    func fetchPersonDetails(id: Int) -> AnyPublisher<Person, APIError> {
        let endpoint = Endpoint(path: "/people/\(id)")
        return apiClient.fetch(endpoint: endpoint)
    }
    
    func fetchPersonCastCredits(id: Int) -> AnyPublisher<[PersonCredit], APIError> {
        let endpoint = Endpoint(path: "/people/\(id)/castcredits", queryItems: [URLQueryItem(name: "embed", value: "show")])
        return apiClient.fetch(endpoint: endpoint)
    }
}
