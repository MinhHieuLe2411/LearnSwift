//
//  ContentView.swift
//  LearnSwiftUIv2
//
//  Created by MinhHieu on 25/06/2024.
//

import SwiftUI

struct ContentView: View {
    
    var cards: [CardMode] = [
        CardMode(TColor: .cyan, BColor: .cyan, name: "yourself", num: "*** *** *** 351"),
        CardMode(TColor: .red, BColor: .red, name: "Sucodee", num: "*** *** *** 352"),
        CardMode(TColor: .blue, BColor: .blue, name: "Massimo", num: "*** *** *** 353")]
    
    @State var show = false
    @Namespace var namespace
    @State var selectedCard: CardMode? = nil
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(cards) { item in
                    CardView(data: item, namespace: namespace)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
