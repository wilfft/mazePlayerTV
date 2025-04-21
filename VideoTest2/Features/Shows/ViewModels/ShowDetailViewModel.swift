//
//  ShowDetailViewModel.swift
//  VideoTest2
//
//  Created by William Moraes on 19/04/25.
//
 
// MARK: - Show Detail View & ViewModel
import SwiftUI
import Combine

class ShowDetailViewModel: ObservableObject {
    @Published var show: Show
    @Published var episodes: [Episode] = []
    @Published var seasons: [Season] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isFavorite = false
    
    private let tvMazeService = TVMazeService()
    private let favoritesService = FavoritesService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init(show: Show) {
        self.show = show
        self.isFavorite = favoritesService.isFavorite(show)
        fetchEpisodes()
    }
    
    func fetchEpisodes() {
        isLoading = true
        errorMessage = nil
        
        tvMazeService.fetchShowEpisodes(id: show.id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] episodes in
                self?.episodes = episodes
                self?.organizeBySeasons(episodes)
            }
            .store(in: &cancellables)
    }
    
    private func organizeBySeasons(_ episodes: [Episode]) {
        let groupedEpisodes = Dictionary(grouping: episodes) { $0.season }
        var tempSeasons: [Season] = []
        
        for (seasonNumber, episodes) in groupedEpisodes.sorted(by: { $0.key < $1.key }) {
            let sortedEpisodes = episodes.sorted { $0.number < $1.number }
            let season = Season(id: seasonNumber, number: seasonNumber, episodes: sortedEpisodes)
            tempSeasons.append(season)
        }
        
        seasons = tempSeasons
    }
    
    func toggleFavorite() {
        if isFavorite {
            favoritesService.removeFavorite(show)
        } else {
            favoritesService.addFavorite(show)
        }
        
        isFavorite = favoritesService.isFavorite(show)
    }
}
