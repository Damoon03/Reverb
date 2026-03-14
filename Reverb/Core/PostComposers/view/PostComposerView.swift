//
//  PostComposerView.swift
//  Reverb
//
//  Created by Damoon saber on 12/23/1404 AP.
//

import SwiftUI

struct PostComposerView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var caption = ""
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
                    Button("Post") {
                        // upload post
                        dismiss()
                    }
                    .disabled(caption.isEmpty)
                    .opacity(caption.isEmpty ? 0.5 : 1.0)
                    .font(.headline)
                }
            }
        }
    }
}

#Preview {
    PostComposerView()
}
