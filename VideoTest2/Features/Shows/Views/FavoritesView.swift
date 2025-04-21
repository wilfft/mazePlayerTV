//
//  File.swift
//  VideoTest2
//
//  Created by William Moraes on 18/04/25.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: FavoritesViewModel
    @State private var selectedShow: Show?
    
    var body: some View {
        Group {
            if viewModel.favoriteShows.isEmpty {
                emptyStateView
                } else {
                favoritesList
            }
        }
        .navigationTitle("Favorites")
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
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart.slash")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.gray)
            
            Text("No Favorites Yet")
                .font(.headline)
            
            Text("Your favorite shows will appear here")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var favoritesList: some View {
        List {
            ForEach(viewModel.favoriteShows) { show in
                HStack {
                    AsyncImage(url: show.image?.medium)
                        .frame(width: 60, height: 80)
                        .cornerRadius(6)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(show.name)
                            .font(.headline)
                        
                        if !show.genres.isEmpty {
                            Text(show.genres.prefix(2).joined(separator: ", "))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.leading, 8)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedShow = show
                }
            }
            .onDelete { indexSet in
                for index in indexSet {
                    viewModel.removeFavorite(viewModel.favoriteShows[index])
                }
            }
        }
    }
    
    @ViewBuilder
    private var showDetailDestination: some View {
        if let show = selectedShow {
            ShowDetailView(viewModel: ShowDetailViewModel(show: show))
        } else {
            EmptyView()
        }
    }
}
