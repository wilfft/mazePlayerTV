//
//  File.swift
//  VideoTest2
//
//  Created by William Moraes on 19/04/25.
//

// MARK: - Main Tab View
import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    var body: some View {
        TabView(selection: $appCoordinator.selectedTab) {
            NavigationView {
                ShowsListView(viewModel: ShowsListViewModel())
            }
            .tabItem {
                Label("Shows", systemImage: "tv")
            }
            .tag(AppCoordinator.TabSelection.shows)
            
            NavigationView {
                FavoritesView(viewModel: FavoritesViewModel())
            }
            .tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }
            .tag(AppCoordinator.TabSelection.favorites)
            
            NavigationView {
                PeopleSearchView(viewModel: PeopleSearchViewModel())
            }
            .tabItem {
                Label("People", systemImage: "person.2")
            }
            .tag(AppCoordinator.TabSelection.people)
        }
    }
}
