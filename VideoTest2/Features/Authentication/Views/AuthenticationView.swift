//
//  AuthenticationView.swift
//  VideoTest2
//
//  Created by William Moraes on 17/04/25.
//

// MARK: - Authentication Views
import SwiftUI
import LocalAuthentication

struct AuthenticationView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @StateObject private var viewModel = BiometricAuthViewModel()
    @State private var pin = ""
    @State private var showPINSetup = false
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "tv.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            
            Text("TVMaze")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            if viewModel.isPINSetup {
                SecureField("Enter PIN", text: $pin)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button("Unlock") {
                    if viewModel.verifyPIN(pin) {
                        appCoordinator.isAuthenticated = true
                    } else {
                        pin = ""
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(pin.count < 4)
                
                if viewModel.biometricType != .none && viewModel.isBiometricsEnabled {
                    Button(action: {
                        viewModel.authenticateWithBiometrics()
                    }) {
                        HStack {
                            Image(systemName: viewModel.biometricType == .faceID ? "faceid" : "touchid")
                            Text("Use \(viewModel.biometricType == .faceID ? "Face ID" : "Touch ID")")
                        }
                    }
                    .padding()
                }
            } else {
                Button("Set up PIN") {
                    showPINSetup = true
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .sheet(isPresented: $showPINSetup) {
            PINSetupView(onComplete: { success in
                if success {
                    appCoordinator.isAuthenticated = true
                }
                showPINSetup = false
            })
        }
        .onAppear {
            if viewModel.biometricType != .none && viewModel.isBiometricsEnabled {
                viewModel.authenticateWithBiometrics()
            }
        }
        .onReceive(viewModel.$isAuthenticated) { isAuthenticated in
            appCoordinator.isAuthenticated = isAuthenticated
        }
    }
}
