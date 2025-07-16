//
//  LearnText.swift
//  LearnSwiftUIv2
//
//  Created by MinhHieu on 25/06/2024.
//

import SwiftUI

struct LearnText: View {
    var body: some View {
        let attributedString = try! AttributedString(
            markdown: "**Hamlet** by William Shakespeare")
        let attributedString1 = try! AttributedString(
            markdown: "_Hamlet_ by William Shakespeare")

        VStack(alignment: .leading, spacing: 10) {
            Text("Turtle Rock")
                .font(.title)
            
            HStack {
                Text("Joshua Tree National Park")
                    .font(.subheadline)
                
                Spacer()
                
                Text("California")
                    .font(.subheadline)
            }
            
            Text("by William Shakespeare")
                .font(.system(size: 12, weight: .light, design: .serif))
                .italic()
            
            Text(attributedString)
                .font(.system(size: 12, weight: .light, design: .monospaced))
            
            Text(attributedString1)
                .font(.system(size: 12, weight: .light, design: .serif))
            
        }
        .padding()
    }
}

#Preview {
    LearnText()
}
