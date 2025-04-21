//
//  ShowsListViewModel.swift
//  VideoTest2
//
//  Created by William Moraes on 18/04/25.
//

// MARK: - Shows List View & ViewModel
import SwiftUI
import Combine

class ShowsListViewModel: ObservableObject {
    @Published var shows: [Show] = []
    @Published var searchResults: [Show] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText = ""
    @Published var currentPage = 0
    @Published var hasMorePages = true
    @Published var isSearchActive = false
    
    private let tvMazeService = TVMazeService()
    private var cancellables = Set<AnyCancellable>()
    private var searchCancellable: AnyCancellable?
    
    init() {
        loadMoreShows()
        
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.performSearch(searchText)
            }
            .store(in: &cancellables)
    }
    
    func loadMoreShows() {
        guard !isLoading && hasMorePages else { return }
        
        isLoading = true
        errorMessage = nil
        
        tvMazeService.fetchShows(page: currentPage + 1)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] newShows in
                guard let self = self else { return }
                
                if newShows.isEmpty {
                    self.hasMorePages = false
                } else {
                    self.shows.append(contentsOf: newShows)
                    self.currentPage += 1
                }
            }
            .store(in: &cancellables)
    }
    
    private func performSearch(_ query: String) {
        // Cancel any previous search
        searchCancellable?.cancel()
        
        if query.isEmpty {
            isSearchActive = false
            searchResults = []
            return
        }
        
        isSearchActive = true
        isLoading = true
        errorMessage = nil
        
        searchCancellable = tvMazeService.searchShows(query: query)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] results in
                self?.searchResults = results.map { $0.show }
            }
    }
    
    func refreshData() {
        shows = []
        currentPage = 0
        hasMorePages = true
        loadMoreShows()
    }
}
