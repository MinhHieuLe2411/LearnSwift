//
//  LearnImage.swift
//  LearnSwiftUIv2
//
//  Created by MinhHieu on 25/06/2024.
//

import SwiftUI

struct LearnImage: View {
    var body: some View {
        Image("interior")
            .clipShape(.circle)
            .overlay {
                Circle().stroke(.red, lineWidth: 3)
            }
            .shadow(radius: 3)
            .frame(width: 200, height: 200)
    }
}

#Preview {
    LearnImage()
}
