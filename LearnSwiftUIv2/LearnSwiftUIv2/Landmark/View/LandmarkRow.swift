//
//  LandmarkRow.swift
//  LearnSwiftUIv2
//
//  Created by MinhHieu on 26/06/2024.
//

import SwiftUI

struct LandmarkRow: View {
    var landmark: Landmark
    
    var body: some View {
        HStack {
            landmark.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(landmark.name)

            Spacer()
            
            if landmark.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
            }
        }
        .buttonStyle(.plain)
        
    }
}

#Preview {
    LandmarkRow(landmark: landmarks[0])   
}
