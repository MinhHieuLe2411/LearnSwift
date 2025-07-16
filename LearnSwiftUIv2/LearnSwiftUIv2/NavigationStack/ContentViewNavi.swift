//
//  ContentViewNavi.swift
//  LearnSwiftUIv2
//
//  Created by MinhHieu on 21/08/2024.
//

import SwiftUI

struct ContentViewNavi: View {
    var swiftInfluencers = ["Paul Hudson", "Sean Allen", "Chris Ching", "Vincent Pradeilles", "Dave Verwer", "Antoine van der Lee", "John Sundell", "and many more"]

    @State private var path = [DataModel]()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                FirstScreen(items: SampleData.firstScreenData, selectedItem: "First Screen")

                HStack {
                    Button("Back to root") {
                        popToRoot()
                    }
                    Spacer()
                    Button("Jump to Fastest") {
                        jumpToSpecificPoint()
                    }
                }.padding()

//                List {
//                    ForEach(swiftInfluencers, id: \.self) { influencer in
//                        NavigationLink(value: influencer) {
//                            Text(influencer)
//                        }
//                    }
//                }
            }
            .navigationDestination(for: DataModel.self) { item in
                LastScreen(items: SampleData.lastScreenData, selectedItem: item.text)
            }

//            .navigationDestination(for: String.self) { item in
//                Text(item)
//            }
        }
    }

    func jumpToSpecificPoint() {
        path = [
            SampleData.firstScreenData[1],
            SampleData.secondScreenData.last!,
            SampleData.lastScreenData.last!
        ]
    }

    func popToRoot() {
        path.removeAll()
    }
}

#Preview {
    ContentViewNavi()
}
