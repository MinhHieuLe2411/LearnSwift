//
//  ContentButtonView.swift
//  LearnSwiftUIv2
//
//  Created by MinhHieu on 30/08/2024.
//

import SwiftUI

struct ContentButtonView: View {
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            Button(action: {}, label: {
                Text("Click Me")
            }).buttonStyle(WhiteButtonStyle())
        }
    }
}

#Preview {
    ContentButtonView()
}

struct WhiteButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(
                    .gray
                        .shadow(
                            .inner(color: .black.opacity(configuration.isPressed ? 0.15 : 0), radius: 10, x: 4, y: 4)
                        )
                        .shadow(
                            .inner(color: .white.opacity(configuration.isPressed ? 1 : 0), radius: 10, x: -10, y: -10)
                        )
                )
            
            configuration.label.font(.title)
                .foregroundColor(.black)
                .opacity(configuration.isPressed ? 0.5 : 1)
        }
        .frame(width: 200, height:  60)
        .background(
            .gray
                .shadow(
                    .drop(color: .white.opacity(configuration.isPressed ? 0 : 1), radius: 10, x: 0, y: -10)
                )
            
                .shadow(
                    .drop(color: .white.opacity(configuration.isPressed ? 0 : 0.15), radius: 10, x: 15, y: 5)
                )
            ,in: .rect(cornerRadius: 12)
        )
        .animation(.none, value: configuration.isPressed)
    }
}
