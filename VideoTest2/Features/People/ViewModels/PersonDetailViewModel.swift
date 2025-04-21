//
//  PersonDetailViewModel.swift
//  VideoTest2
//
//  Created by William Moraes on 18/04/25.
//

// MARK: - Person Detail View & ViewModel
import SwiftUI
import Combine

class PersonDetailViewModel: ObservableObject {
    let person: Person
    @Published var shows: [PersonShow] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let tvMazeService = TVMazeService()
    private var cancellables = Set<AnyCancellable>()
    
    init(person: Person) {
        self.person = person
        fetchShows()
    }
    
//    func fetchShows() {
//        isLoading = true
//        errorMessage = nil
//        
//        tvMazeService.fetchPersonCastCredits(id: person.id)
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] completion in
//                self?.isLoading = false
//                if case .failure(let error) = completion {
//                    self?.errorMessage = error.localizedDescription
//                }
//            } receiveValue: { [weak self] castCredits in
//                self?.shows = castCredits.map { $0.show }
//            }
//            .store(in: &cancellables)
//    }
    
    func fetchShows() {
        isLoading = true
        errorMessage = nil
        
        tvMazeService.fetchPersonCastCredits(id: person.id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] castCredits in
                // Map the embedded shows to PersonShow objects
                self?.shows = castCredits.map { credit in
                    let embeddedShow = credit.embedded.show
                    return PersonShow(
                        id: embeddedShow.id,
                        name: embeddedShow.name,
                        image: embeddedShow.image.map { imageLinks in
                            ImageLinks(
                                medium: imageLinks.medium,
                                original: imageLinks.original
                            )
                        }
                    )
                }
            }
            .store(in: &cancellables)
    }
}
