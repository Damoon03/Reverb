//
//  FeedView.swift
//  Reverb
//
//  Created by Damoon saber on 12/23/1404 AP.
//

import SwiftUI

struct FeedView: View {
    @State private var showPostComposer = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(0 ..< 10) { post in
                            FeedCell()
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
                Text("Post composer")
            } 
            .navigationTitle("Feed")
        }
    }
}

#Preview {
    FeedView()
}
