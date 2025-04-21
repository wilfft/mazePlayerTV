//
//  File.swift
//  VideoTest2
//
//  Created by William Moraes on 17/04/25.
//

import Foundation
import Combine

class APIClient {
    static let shared = APIClient()
    
    private let session: URLSession
    
    private init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    func fetch<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, APIError> {
        guard let url = endpoint.url else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .tryMap { data, response in
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                
                guard 200...299 ~= httpResponse.statusCode else {
                    throw APIError.httpError(httpResponse.statusCode)
                }
                
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let apiError = error as? APIError {
                    return apiError
                } else if let decodingError = error as? DecodingError {
                    print("🔴 Erro de decodificação: \(decodingError)")
                    return APIError.decodingError(decodingError)
                } else {
                    return APIError.unknown(error)
                }
            }
            .eraseToAnyPublisher()
    }
}

extension Data {
    func printJSON() {
        if let json = try? JSONSerialization.jsonObject(with: self, options: []),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print("=== JSON Response ===")
            print(jsonString)
            print("=====================")
        } else {
            print("Failed to parse JSON from data")
        }
    }
}
