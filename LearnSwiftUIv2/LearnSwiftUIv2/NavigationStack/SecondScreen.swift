//
//  SecondScreen.swift
//  LearnSwiftUIv2
//
//  Created by MinhHieu on 21/08/2024.
//

import SwiftUI

struct SecondScreen: View {
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
    SecondScreen(items: SampleData.firstScreenData, selectedItem: "")
}
