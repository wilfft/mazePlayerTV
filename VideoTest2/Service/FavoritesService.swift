//
//  FavoritesService.swift
//  VideoTest2
//
//  Created by William Moraes on 18/04/25.
//


// MARK: - Favorites Service
import Foundation
import Combine

class FavoritesService {
    static let shared = FavoritesService()
    
    private let storageService = LocalStorageService()
    private let favoritesKey = "favorite_shows"
    
    @Published private(set) var favoriteShows: [Show] = []
    
    private init() {
        loadFavorites()
    }
    
    private func loadFavorites() {
        if let data = storageService.getData(forKey: favoritesKey),
           let shows = try? JSONDecoder().decode([Show].self, from: data) {
            favoriteShows = shows
        }
    }
    
    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favoriteShows) {
            storageService.setData(data, forKey: favoritesKey)
        }
    }
    
    func addFavorite(_ show: Show) {
        if !isFavorite(show) {
            favoriteShows.append(show)
            saveFavorites()
        }
    }
    
    func removeFavorite(_ show: Show) {
        favoriteShows.removeAll { $0.id == show.id }
        saveFavorites()
    }
    
    func isFavorite(_ show: Show) -> Bool {
        return favoriteShows.contains { $0.id == show.id }
    }
    
    func getAlphabeticalFavorites() -> [Show] {
        return favoriteShows.sorted { $0.name < $1.name }
    }
}
