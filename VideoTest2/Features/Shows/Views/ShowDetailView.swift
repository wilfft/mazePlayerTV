//
//  ShowDetailView.swift
//  VideoTest2
//
//  Created by William Moraes on 18/04/25.
//

import SwiftUI

struct ShowDetailView: View {
    @ObservedObject var viewModel: ShowDetailViewModel
    @State private var selectedEpisode: Episode?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Show poster and info
                headerSection
                
                Divider()
                
                // Show summary
                summarySection
                
                Divider()
                
                // Episodes by season
                episodesSection
            }
            .padding()
        }
        .navigationTitle(viewModel.show.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.toggleFavorite()
                }) {
                    Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(viewModel.isFavorite ? .red : nil)
                }
            }
        }
        .background(
            NavigationLink(
                destination: episodeDetailDestination,
                isActive: Binding(
                    get: { selectedEpisode != nil },
                    set: { if !$0 { selectedEpisode = nil } }
                ),
                label: { EmptyView() }
            )
        )
    }
    
    @ViewBuilder
    private var headerSection: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: viewModel.show.image?.original)
                .scaledToFit()
                .frame(width: 120)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8) {
                if !viewModel.show.genres.isEmpty {
                    GenreTagsView(genres: viewModel.show.genres)
                }
                
                if !viewModel.show.schedule.days.isEmpty && !viewModel.show.schedule.time.isEmpty {
                    Label(viewModel.show.scheduleText, systemImage: "calendar")
                        .font(.caption)
                }
            }
        }
    }
    
    @ViewBuilder
    private var summarySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Summary")
                .font(.headline)
            
            Text(viewModel.show.cleanSummary)
                .font(.body)
        }
    }
    
    @ViewBuilder
    private var episodesSection: some View {
        if viewModel.isLoading {
            ProgressView()
                .frame(maxWidth: .infinity, alignment: .center)
        } else if let errorMessage = viewModel.errorMessage {
            ErrorView(message: errorMessage) {
                viewModel.fetchEpisodes()
            }
        } else if viewModel.seasons.isEmpty {
            Text("No episodes available")
                .italic()
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
        } else {
            VStack(alignment: .leading, spacing: 16) {
                Text("Episodes")
                    .font(.headline)
                
                ForEach(viewModel.seasons) { season in
                    SeasonSectionView(season: season) { episode in
                        selectedEpisode = episode
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var episodeDetailDestination: some View {
        if let episode = selectedEpisode {
            EpisodeDetailView(viewModel: EpisodeDetailViewModel(episode: episode, showName: viewModel.show.name))
        } else {
            EmptyView()
        }
    }
}
