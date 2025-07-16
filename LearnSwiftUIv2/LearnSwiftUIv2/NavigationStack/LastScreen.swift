//
//  LastScreen.swift
//  LearnSwiftUIv2
//
//  Created by MinhHieu on 21/08/2024.
//

import SwiftUI

struct LastScreen: View {
    let items: [DataModel]
        let selectedItem: String
        
        var body: some View {
            List {
                ForEach(items) { item in
                    Text(item.text)
                }
            }
            .navigationTitle(selectedItem)
        }
}

#Preview {
    LastScreen(items: SampleData.firstScreenData, selectedItem: "")
}
