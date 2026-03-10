//
//  RegistrationView.swift
//  Reverb
//
//  Created by Damoon saber on 12/13/1404 AP.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AuthManager.self) private var authManager
    
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var confirmPassword = ""
    @State private var passwordsMatch = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(.reverb)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding()
            
            VStack(spacing: 8) {
                TextField("Enter your email", text: $email)
                    .autocapitalization(.none)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .padding(.horizontal, 24)
                
                TextField("Enter your username", text: $username)
                    .autocapitalization(.none)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .padding(.horizontal, 24)
                
                 ZStack(alignment: .trailing) {
                    SecureField("Enter your password", text: $password)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        Image(systemName: passwordsMatch ? "chechmark.circle.fill" : "xmark.cicle.fill")
                            .foregroundStyle(passwordsMatch ? .green : .red)
                            .padding(.horizontal)
                    }
                }
                .padding(.horizontal, 24)
                
                ZStack(alignment: .trailing) {
                    SecureField("Confirm your passsword", text: $confirmPassword)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        Image(systemName: passwordsMatch ? "chechmark.circle.fill" : "xmark.cicle.fill")
                            .foregroundStyle(passwordsMatch ? .green : .red)
                            .padding(.horizontal)
                    }
                }
                .padding(.horizontal, 24)
                .onChange(of: confirmPassword) { oldValue, newValue in
                    passwordsMatch = newValue == password
                    
                }
            }
            Button { signUp() } label: {
                Text("sign Up")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 352, height: 44)
                    .background(Color(.systemBlue))
                    .cornerRadius(8)
            }
            disabled(!formIsValid)
                .opacity(formIsValid ?1.0 : 0.5)
                .padding(.vertical)
            
            Spacer()

            Divider()
            
            Button { dismiss() } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .font(.subheadline)
            }
            .padding(.vertical, 16)
        }
    }
}

private extension RegistrationView {
    func signUp() {
        Task { await authManager.signUp(email: email, password: password, username: username)}
    }
    var formIsValid: Bool {
        return email.isValidEmail() && passwordsMatch
    }
}
#Preview {
    RegistrationView()
}
