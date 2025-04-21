//
//  BiometricService.swift
//  VideoTest2
//
//  Created by William Moraes on 18/04/25.
//

// MARK: - Biometric Service
import Foundation
import LocalAuthentication

class BiometricService {
    enum BiometricType {
        case none
        case faceID
        case touchID
    }
    
    func getBiometricType() -> BiometricType {
        let context = LAContext()
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return .none
        }
        
        switch context.biometryType {
        case .faceID:
            return .faceID
        case .touchID:
            return .touchID
        default:
            return .none
        }
    }
    
    func authenticate(completion: @escaping (Bool, Error?) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to access the TVMaze app"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                completion(success, error)
            }
        } else {
            completion(false, error)
        }
    }
}
