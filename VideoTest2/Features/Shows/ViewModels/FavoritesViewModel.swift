//
//  FavoritesViewModel.swift
//  VideoTest2
//
//  Created by William Moraes on 19/04/25.
//

// MARK: - Favorites View & ViewModel
import SwiftUI
import Combine

class FavoritesViewModel: ObservableObject {
    @Published var favoriteShows: [Show] = []
    
    private let favoritesService = FavoritesService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        favoritesService.$favoriteShows
            .receive(on: DispatchQueue.main)
            .sink { [weak self] shows in
                self?.favoriteShows = shows.sorted { $0.name < $1.name }
            }
            .store(in: &cancellables)
    }
    
    func removeFavorite(_ show: Show) {
        favoritesService.removeFavorite(show)
    }
}
