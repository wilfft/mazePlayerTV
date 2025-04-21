
// MARK: - App Entry Point
import SwiftUI
import LocalAuthentication

// MARK: - App Coordinator
import SwiftUI
import Combine

class AppCoordinator: ObservableObject {
    @Published var isAuthenticated = false
    @Published var selectedTab: TabSelection = .shows
    
    private let securityService = SecurityService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        checkAuthentication()
        
        securityService.$authenticationState
            .sink { [weak self] state in
                if case .authenticated = state {
                    self?.isAuthenticated = true
                } else {
                    self?.isAuthenticated = false
                }
            }
            .store(in: &cancellables)
    }
    
    private func checkAuthentication() {
        if securityService.isPINSetup {
            // PIN is setup but we need to authenticate
            isAuthenticated = false
        } else {
            // No PIN setup, so skip authentication
            isAuthenticated = true
        }
    }
    
    func signOut() {
        isAuthenticated = false
    }
    
    enum TabSelection {
        case shows
        case favorites
        case people
    }
}

