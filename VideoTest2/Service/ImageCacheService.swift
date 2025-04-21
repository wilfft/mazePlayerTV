//
//  ImageCacheService.swift
//  VideoTest2
//
//  Created by William Moraes on 18/04/25.
//

// MARK: - Image Cache Service
import Foundation
import SwiftUI
import Combine

class ImageCacheService: ObservableObject {
    static let shared = ImageCacheService()
    
    private let cache = NSCache<NSString, UIImage>()
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        cache.countLimit = 100
    }
    
    func loadImage(from urlString: String?, retries: Int = 3, timeoutInterval: TimeInterval = 30.0) -> AnyPublisher<UIImage?, Never> {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return Just(nil).eraseToAnyPublisher()
        }
        
        let key = NSString(string: urlString)
        
        if let cachedImage = cache.object(forKey: key) {
            return Just(cachedImage).eraseToAnyPublisher()
        }
        
        // Create a URLRequest with a custom timeout interval
        var request = URLRequest(url: url)
        request.timeoutInterval = timeoutInterval
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { data, _ -> UIImage? in
                guard let image = UIImage(data: data) else { return nil }
                self.cache.setObject(image, forKey: key)
                return image
            }
            .retry(retries)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // A method that provides more granular error handling
    func loadImageWithErrorHandling(from urlString: String?, retries: Int = 3, timeoutInterval: TimeInterval = 30.0) -> AnyPublisher<Result<UIImage, Error>, Never> {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return Just(.failure(URLError(.badURL))).eraseToAnyPublisher()
        }
        
        let key = NSString(string: urlString)
        
        if let cachedImage = cache.object(forKey: key) {
            return Just(.success(cachedImage)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = timeoutInterval
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> UIImage in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                
                guard let image = UIImage(data: data) else {
                    throw NSError(domain: "ImageCacheService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid image data"])
                }
                
                self.cache.setObject(image, forKey: key)
                return image
            }
            .retry(retries)
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<UIImage, Error>, Never> in
                // Print error for debugging
                print("Image loading error: \(error.localizedDescription)")
                return Just(.failure(error)).eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}
