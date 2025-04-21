//
//  PINSetupViewModel.swift
//  VideoTest2
//
//  Created by William Moraes on 17/04/25.
//

import Foundation

class PINSetupViewModel: ObservableObject {
    @Published var errorMessage = ""
    
    private let securityService = SecurityService()
    private let biometricService = BiometricService()
    
    var biometricType: BiometricService.BiometricType {
        biometricService.getBiometricType()
    }
    
    func setPIN(_ pin: String, confirmPin: String) -> Bool {
        guard pin.count >= 4 else {
            errorMessage = "PIN must be at least 4 digits"
            return false
        }
        
        guard pin == confirmPin else {
            errorMessage = "PINs do not match"
            return false
        }
        
        let success = securityService.setupPIN(pin)
        if !success {
            errorMessage = "Failed to save PIN"
        } else {
            errorMessage = ""
        }
        
        return success
    }
    
    func enableBiometrics(_ enable: Bool) {
        securityService.enableBiometrics(enable)
    }
}
