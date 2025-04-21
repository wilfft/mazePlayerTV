//
//  SecurityService 2.swift
//  VideoTest2
//
//  Created by William Moraes on 17/04/25.
//


// MARK: - Security Service
import Foundation
import LocalAuthentication
import Combine

class SecurityService: ObservableObject {
    @Published var authenticationState: AuthenticationState = .notAuthenticated
    
    private let biometricService = BiometricService()
    private let storage = LocalStorageService()
    private let pinKey = "user_pin"
    private let biometricEnabledKey = "biometric_enabled"
    
    var isPINSetup: Bool {
        storage.getValue(forKey: pinKey) != nil
    }
    
    var isBiometricsEnabled: Bool {
        storage.getBool(forKey: biometricEnabledKey) ?? false
    }
    
    func setupPIN(_ pin: String) -> Bool {
        return storage.setValue(pin, forKey: pinKey)
    }
    
    func verifyPIN(_ pin: String) -> Bool {
        guard let storedPIN = storage.getValue(forKey: pinKey) as? String else {
            return false
        }
        
        let isVerified = storedPIN == pin
        if isVerified {
            authenticationState = .authenticated
        }
        
        return isVerified
    }
    
    func enableBiometrics(_ enabled: Bool) {
        storage.setBool(enabled, forKey: biometricEnabledKey)
    }
    
    func authenticateWithBiometrics() {
        biometricService.authenticate { [weak self] success, error in
            DispatchQueue.main.async {
                if success {
                    self?.authenticationState = .authenticated
                } else {
                    if let error = error {
                        print("Biometric authentication failed: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func signOut() {
        authenticationState = .notAuthenticated
    }
}
