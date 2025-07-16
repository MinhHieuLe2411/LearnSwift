//
//  LandmarkList.swift
//  LearnSwiftUIv2
//
//  Created by MinhHieu on 26/06/2024.
//

import SwiftUI

struct LandmarkList: View {
    @State private var showFavoritesOnly = false

    var filteredLandmarks: [Landmark] {
        landmarks.filter { landmark in
            !showFavoritesOnly || landmark.isFavorite
        }
    }

    var body: some View {
        NavigationSplitView {
            List(filteredLandmarks) { landmark in
                NavigationLink {
                    LandmarkDetail(landmark: landmark)
                } label: {
                    LandmarkRow(landmark: landmark)
                }
            }
            .navigationTitle("Landmarks")
        } detail: {
            Text("Select a Landmark")
        }
    }
}

#Preview {
    LandmarkList()
}
