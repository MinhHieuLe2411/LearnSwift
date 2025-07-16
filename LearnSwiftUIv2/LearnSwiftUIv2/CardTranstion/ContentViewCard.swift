//
//  ContentViewCard.swift
//  LearnSwiftUIv2
//
//  Created by MinhHieu on 26/08/2024.
//

import SwiftUI

struct ContentViewCard: View {
    var cards: [CardMode] = [
        CardMode(TColor: .cyan, BColor: .cyan, name: "yourself", num: "*** *** *** 351"),
        CardMode(TColor: .red, BColor: .red, name: "Sucodee", num: "*** *** *** 352"),
        CardMode(TColor: .blue, BColor: .blue, name: "Massimo", num: "*** *** *** 353"),
    ]

    @State var show = false
    @Namespace var namespace
    @State var selectedCard: CardMode? = nil

    var body: some View {
        ScrollView {
            ZStack {
                if let selectedCard = selectedCard, show {
                    OpenCardView(close: $show, data: selectedCard, namespace: namespace)
                } else {
                    VStack {
                        ForEach(cards) { item in
                            
                            CardView(data: item, namespace: namespace)
                                .matchedGeometryEffect(id: item.id, in: namespace)
                                .onTapGesture {
                                    selectedCard = item
                                    withAnimation(.spring(duration: 0.2)) {
                                        show = true
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentViewCard()
}
