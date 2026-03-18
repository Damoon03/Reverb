//
//  UserProfileVIew.swift
//  Reverb
//
//  Created by Damoon saber on 12/15/1404 AP.
//

import SwiftUI
import PhotosUI

struct UserProfileVIew: View {
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var profileImage: Image?
    @State private var showPhotosPicker = false
    
    var body: some View {
        NavigationStack {
            List {
                // header
                HStack(spacing: 16) {
                    Section {
                        Group {
                            if let profileImage {
                                profileImage
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(.circle)
                            } else if let profileImageURL = userManager.currentUser?.profileImageURL {
                                AsyncImage(url: URL(string: profileImageURL)!) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(.circle)
                                } placeholder: {
                                    ProgressView()
                                }
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .foregroundStyle(.tertiary)
                                
                            }
                        }
                        .frame(width: 72, height: 72)
                        .onTapGesture {
                            showPhotosPicker.toggle()
                        }
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(userManager.currentUser?.username ?? "leading")
                            
                            Text(userManager.currentUser?.email ?? "")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                Section("Posts") {
                    HStack {
                        Text("Posts")
                        
                        Spacer()
                        
                        Text("\(userManager.currentUser?.postCount ?? 0)")
                    }
                }
                // sign out
                Section {
                    Button("Sign out") {
                        Task { await authManager.signOut() }
                    }
                    .foregroundStyle(.red)
                }
            }
            .navigationTitle("profile")
            .photosPicker(isPresented: $showPhotosPicker, selection: $selectedItem)
        }
        .task(id: selectedItem) {
            await onImageSelected()
        }
    }
}

private extension UserProfileVIew {
    func onImageSelected() async {
        guard let selectedItem, let user = userManager.currentUser else { return }
        
        do {
            guard let data = try await selectedItem.loadTransferable(type: Data.self) else { return }
            guard let uiImage = UIImage(data: data) else { return }
            profileImage = Image(uiImage: uiImage)
            
            let userProfileImageURL = try await SuperbaseStorageManager().uploadProfilePhoto(for: user, imageData: data)
            
            await userManager.updateProfileImageURL(userProfileImageURL)
        } catch {
            print("DEBUG: Image selection failed error: \(error.localizedDescription)")
            
        }
    }
}

#Preview {
    UserProfileVIew()
        .environment(AuthManager())
        .environment(UserManager())
}
