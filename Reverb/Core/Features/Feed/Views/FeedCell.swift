//
//  FeedCell.swift
//  Reverb
//
//  Created by Damoon saber on 12/23/1404 AP.
//

import SwiftUI

struct FeedCell: View {
    let posts: post
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                if let profileImageURL = posts.authorProfileImageURL {
                    AsyncImage(url: URL(string: profileImageURL)!) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 56, height: 56)
                            .clipShape(.circle)
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 56, height: 56)
                        .scaledToFill()
                        .clipShape(.circle)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(posts.authorUsername)
                            .font(.headline)
                        
                        Text("•" + posts.createdAt.formatted(.relative(presentation: .named)))
                    }
                    Text(posts.caption)
                    
                }
                Spacer()
            }
            .padding()
            .background(Color(.systemBackground ))
       
            Divider()
        }
    }
}
 
