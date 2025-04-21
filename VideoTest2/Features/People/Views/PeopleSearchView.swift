//
//  PeopleSearchView.swift
//  VideoTest2
//
//  Created by William Moraes on 19/04/25.
//

import SwiftUI

struct PeopleSearchView: View {
    @ObservedObject var viewModel: PeopleSearchViewModel
    @State private var selectedPerson: Person?
    
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchText)
                .padding(.horizontal)
            
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Searching...")
                } else if let errorMessage = viewModel.errorMessage {
                    ErrorView(message: errorMessage) {
                        viewModel.searchText = viewModel.searchText
                    }
                } else if viewModel.searchText.isEmpty {
                    emptyStateView
                } else if viewModel.searchResults.isEmpty {
                    Text("No results found")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
                            ForEach(viewModel.searchResults) { person in
                                PersonCardView(person: person)
                                    .onTapGesture {
                                        selectedPerson = person
                                    }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .navigationTitle("People Search")
        .background(
            NavigationLink(
                destination: personDetailDestination,
                isActive: Binding(
                    get: { selectedPerson != nil },
                    set: { if !$0 { selectedPerson = nil } }
                ),
                label: { EmptyView() }
            )
        )
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.gray)
            
            Text("Search for people")
                .font(.headline)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    private var personDetailDestination: some View {
        if let person = selectedPerson {
            PersonDetailView(viewModel: PersonDetailViewModel(person: person))
        } else {
            EmptyView()
        }
    }
}
