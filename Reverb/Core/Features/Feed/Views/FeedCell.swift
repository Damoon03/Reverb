//
//  FeedCell.swift
//  Reverb
//
//  Created by Damoon saber on 12/23/1404 AP.
//

import SwiftUI

struct FeedCell: View {
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 56, height: 56)
                    .clipShape(.circle)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Damoon")
                            .font(.headline)
                        
                        Text("•" + "1 day ago")
                    }
                    Text("This is a test post for now...")
                    
                }
                Spacer()
            }
            .padding()
            .background(Color(.systemBackground ))
       
            Divider()
        }
    }
}

#Preview {
    FeedCell()
}
