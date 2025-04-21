//
//  VideoTest2App.swift
//  VideoTest2
//
//  Created by William Moraes on 17/04/25.
//

import SwiftUI

@main
struct VideoPlayerApp: App {
    @StateObject private var appCoordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            if appCoordinator.isAuthenticated {
                MainTabView()
                    .environmentObject(appCoordinator)
            } else {
                AuthenticationView()
                    .environmentObject(appCoordinator)
            }
        }
    }
}
