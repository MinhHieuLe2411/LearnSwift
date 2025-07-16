//
//  FirstScreen.swift
//  LearnSwiftUIv2
//
//  Created by MinhHieu on 21/08/2024.
//

import SwiftUI

struct DataModel: Identifiable, Hashable {
    let id = UUID()
    let text: String
}

class SampleData {
    static let firstScreenData = [
        DataModel(text: "🚂 Trains"),
        DataModel(text: "✈️ Planes"),
        DataModel(text: "🚗 Automobiles"),
    ]
    
    static let secondScreenData = [
        DataModel(text: "Slow"),
        DataModel(text: "Regular"),
        DataModel(text: "Fast"),
    ]
    
    static let lastScreenData = [
        DataModel(text: "Wrong"),
        DataModel(text: "So-so"),
        DataModel(text: "Right"),
    ]
}

struct FirstScreen: View {
    let items: [DataModel]
    let selectedItem: String
    
    var body: some View {
        List {
            ForEach(items) { item in
                NavigationLink(item.text, value: item)
            }
        }
        .navigationTitle(selectedItem)
    }
}

#Preview {
    FirstScreen(items: SampleData.firstScreenData, selectedItem: "")
}
