//
//  CircleImage.swift
//  LearnSwiftUIv2
//
//  Created by MinhHieu on 26/06/2024.
//

import SwiftUI

struct CircleImage: View {
    var image: Image

    var body: some View {
        image
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

#Preview {
    CircleImage(image: Image("turtlerock"))
}
