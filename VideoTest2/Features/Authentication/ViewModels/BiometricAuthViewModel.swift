//
//  BiometricAuthViewModel.swift
//  VideoTest2
//
//  Created by William Moraes on 17/04/25.
//

// MARK: - Authentication ViewModels
import Foundation
import Combine

class BiometricAuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var errorMessage = ""
    
    private let securityService = SecurityService()
    private let biometricService = BiometricService()
    private var cancellables = Set<AnyCancellable>()
    
    var isPINSetup: Bool {
        securityService.isPINSetup
    }
    
    var isBiometricsEnabled: Bool {
        securityService.isBiometricsEnabled
    }
    
    var biometricType: BiometricService.BiometricType {
        biometricService.getBiometricType()
    }
    
    init() {
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
    
    func verifyPIN(_ pin: String) -> Bool {
        let isVerified = securityService.verifyPIN(pin)
        if !isVerified {
            errorMessage = "Incorrect PIN"
        } else {
            errorMessage = ""
        }
        return isVerified
    }
    
    func authenticateWithBiometrics() {
        securityService.authenticateWithBiometrics()
    }
}
