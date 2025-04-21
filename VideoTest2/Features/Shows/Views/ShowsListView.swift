//
//  Untitled.swift
//  VideoTest2
//
//  Created by William Moraes on 18/04/25.
//

import SwiftUI

struct ShowsListView: View {
    @StateObject var viewModel: ShowsListViewModel
    @State private var selectedShow: Show?
    
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchText)
                .padding(.horizontal)
            
            ZStack {
                if viewModel.isLoading && viewModel.shows.isEmpty && !viewModel.isSearchActive {
                    Progress
                } else if let errorMessage = viewModel.errorMessage, viewModel.shows.isEmpty && !viewModel.isSearchActive {
                    ErrorView(message: errorMessage) {
                        viewModel.refreshData()
                    }
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 16) {
                            ForEach(viewModel.isSearchActive ? viewModel.searchResults : viewModel.shows) { show in
                                ShowCardView(show: show)
                                    .onTapGesture {
                                        selectedShow = show
                                    }
                            }
                        }
                        .padding()
                        
                        if !viewModel.isSearchActive && viewModel.hasMorePages {
                            ProgressView()
                                .padding()
                                .onAppear {
                                    viewModel.loadMoreShows()
                                }
                        }
                    }
                    .refreshable {
                        viewModel.refreshData()
                    }
                }
            }
        }
        .navigationTitle("TV Shows")
        .background(
            NavigationLink(
                destination: showDetailDestination,
                isActive: Binding(
                    get: { selectedShow != nil },
                    set: { if !$0 { selectedShow = nil } }
                ),
                label: { EmptyView() }
            )
        )
    }
    
    @ViewBuilder
    private var showDetailDestination: some View {
        if let show = selectedShow {
            ShowDetailView(viewModel: ShowDetailViewModel(show: show))
        } else {
            EmptyView()
        }
    }
    
    private var Progress: some View {
        VStack {
            ProgressView()
            Text("Loading shows...")
                .padding(.top)
        }
    }
}
