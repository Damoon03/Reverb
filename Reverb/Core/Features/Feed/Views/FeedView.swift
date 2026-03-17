//
//  FeedView.swift
//  Reverb
//
//  Created by Damoon saber on 12/23/1404 AP.
//

import SwiftUI

struct FeedView: View {
    @State private var showPostComposer = false
    @State private var posts = [post]()
    private let service = FeedService()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(posts) { post in
                            FeedCell(posts : post)
                        }
                    }
                }
                Button { showPostComposer.toggle()  } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.accentColor)
                        .clipShape(.circle)
                        .shadow(radius: 4)
                }
                .padding()
            }
            .fullScreenCover(isPresented: $showPostComposer) {
                PostComposerView()
            } 
            .navigationTitle("Feed")
        }
        .task { await fetchPost() }
        .refreshable { await fetchPost() }
    }
}
private extension FeedView {
    func fetchPost() async {
        do {
            self.posts = try await service.fetchPost()
        } catch {
            print("DEBUG: failed to fetch posts with error:\(error)")
        }
    }
}
#Preview {
    FeedView()
}
