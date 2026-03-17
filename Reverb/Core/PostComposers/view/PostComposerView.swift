//
//  PostComposerView.swift
//  Reverb
//
//  Created by Damoon saber on 12/23/1404 AP.
//

import SwiftUI

struct PostComposerView: View {
  
    @Environment(\.dismiss) private var dismiss
    @Environment(UserManager.self) private var  userManager
   
    @State private var caption = ""
    @State private var isUploading = false
    var body: some View {
        NavigationStack {
            VStack {
                HStack  {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 56, height: 56)
                        .clipShape(.circle)
                    
                    TextField("Whats on your mind?", text: $caption, axis: .vertical)
                }
                Spacer()
            }
            .padding()
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancle") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    if isUploading {
                        ProgressView()
                    } else {
                        
                        Button("Post") {
                            Task {
                                await uploadPost()
                            }
                        }
                        .disabled(caption.isEmpty)
                        .opacity(caption.isEmpty ? 0.5 : 1.0)
                        .font(.headline)
                    }
                }
            }
        }
    }
}

private extension PostComposerView {
    func uploadPost() async {
        guard let  currentUser = userManager.currentUser else { return }
        let service = CreatPostService()
        isUploading = true
        defer { isUploading = false }
       
        do {
            try await service.creatPost(
                caption: caption ,
                authorID: currentUser.id,
                authorUsername: currentUser.username,
                authorProfileImageURL: currentUser.profileImageURL
            )
            dismiss()
        } catch {
            print("DEBUG: failed to creat post with error: \(error)")
        }
    }
}
#Preview {
    PostComposerView()
        .environment(UserManager())
}
