//
//  PeopleSearchViewModel.swift
//  VideoTest2
//
//  Created by William Moraes on 18/04/25.
//

// MARK: - People Search View & ViewModel
import SwiftUI
import Combine

class PeopleSearchViewModel: ObservableObject {
    @Published var searchResults: [Person] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText = ""
    
    private let tvMazeService = TVMazeService()
    private var cancellables = Set<AnyCancellable>()
    private var searchCancellable: AnyCancellable?
    
    init() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.performSearch(searchText)
            }
            .store(in: &cancellables)
    }
    
    private func performSearch(_ query: String) {
        // Cancel any previous search
        searchCancellable?.cancel()
        
        if query.isEmpty {
            searchResults = []
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        searchCancellable = tvMazeService.searchPeople(query: query)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] results in
                self?.searchResults = results.map { $0.person }
            }
    }
}
