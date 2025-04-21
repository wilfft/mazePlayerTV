//
//  PINSetupView.swift
//  VideoTest2
//
//  Created by William Moraes on 17/04/25.
//


// MARK: - Authentication ViewModels
import SwiftUI

struct PINSetupView: View {
    @StateObject private var viewModel = PINSetupViewModel()
    @State private var pin = ""
    @State private var confirmPin = ""
    @State private var showBiometricOption = false
    var onComplete: (Bool) -> Void
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                if !showBiometricOption {
                    Text("Create a 4-digit PIN")
                        .font(.headline)
                    
                    SecureField("PIN", text: $pin)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    SecureField("Confirm PIN", text: $confirmPin)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    Button("Set PIN") {
                        if viewModel.setPIN(pin, confirmPin: confirmPin) {
                            if viewModel.biometricType != .none {
                                showBiometricOption = true
                            } else {
                                onComplete(true)
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(pin.count < 4 || confirmPin.count < 4)
                } else {
                    Text("Would you like to use \(viewModel.biometricType == .faceID ? "Face ID" : "Touch ID") to unlock the app?")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    
                    HStack(spacing: 20) {
                        Button("No") {
                            viewModel.enableBiometrics(false)
                            onComplete(true)
                        }
                        .buttonStyle(.bordered)
                        
                        Button("Yes") {
                            viewModel.enableBiometrics(true)
                            onComplete(true)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .padding()
            .navigationTitle("Security Setup")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
