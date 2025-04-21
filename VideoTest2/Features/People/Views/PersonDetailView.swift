//
//  PersonDetailView.swift
//  VideoTest2
//
//  Created by William Moraes on 19/04/25.
//

import SwiftUI

struct PersonDetailView: View {
    @ObservedObject var viewModel: PersonDetailViewModel
    @State private var selectedShow: Show?
    @ObservedObject var viewModel2: PersonDetailViewModel = PersonDetailViewModel(person: .init(id: 0, name: "", image: .none))
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                personHeaderSection
                Divider()
                showsSection
            }
            .padding()
        }
        .navigationTitle(viewModel.person.name)
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
    private var personHeaderSection: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: viewModel.person.image?.original)
                .frame(width: 150, height: 200)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.person.name)
                    .font(.title2)
                    .fontWeight(.bold)
            }
        }
    }
    
    @ViewBuilder
    private var showsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Shows")
                .font(.headline)
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
            } else if let errorMessage = viewModel.errorMessage {
                ErrorView(message: errorMessage) {
                    viewModel.fetchShows()
                }
            } else if viewModel.shows.isEmpty {
                Text("No shows available")
                    .italic()
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                ForEach(viewModel.shows) { show in
                    PersonShowRowView(show: show)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            // Converter PersonShow para Show para navegação
                            let fullShow = Show(
                                id: show.id,
                                name: show.name,
                                genres: [],
                                schedule: Schedule(time: "", days: []),
                                summary: nil,
                                image: show.image
                            )
                            selectedShow = fullShow
                        }
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
