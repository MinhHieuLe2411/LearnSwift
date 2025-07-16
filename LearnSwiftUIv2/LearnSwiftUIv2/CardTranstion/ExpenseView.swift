//
//  ExpenseView.swift
//  LearnSwiftUIv2
//
//  Created by MinhHieu on 09/08/2024.
//

import SwiftUI

struct Expense: Identifiable {
    var id = UUID()
    var image: ImageResource
    var name: String
    var category: String
    var amount: String
    var date: String
}

struct ExpenseView: View {
    let expenses: [Expense] = [
        Expense(image: .charleyrivers, name: "Amazon", category: "Groceries", amount: "$128", date: "20/03/2024"),
        Expense(image: .chilkoottrail, name: "Youtube", category: "Streaming", amount: "$18", date: "20/03/2024"),
        Expense(image: .chincoteague, name: "Dribble", category: "Membership", amount: "$30", date: "20/03/2024"),
        Expense(image: .hiddenlake, name: "Apple", category: "Apple Pay", amount: "$50", date: "20/03/2024"),
        Expense(image: .icybay, name: "Patreon", category: "Membership", amount: "$9", date: "20/03/2024"),
        Expense(image: .interior, name: "Instagram", category: "Ad Publish", amount: "$$28", date: "20/03/2024"),
        Expense(image: .lakemcdonald, name: "Netflix", category: "Movies", amount: "$40", date: "20/03/2024"),
        Expense(image: .rainbowlake, name: "Photoshop", category: "Servive", amount: "$39", date: "20/03/2024")
    ]
    
    @Binding var show: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(expenses.indices, id: \.self) { index in
                    HStack(spacing: 16) {
                        Image(expenses[index].image)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .scaledToFill()
                            
                        
                        VStack(alignment: .leading) {
                            Text(expenses[index].name)
                                .font(.headline)
                            
                            Text(expenses[index].category)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text(expenses[index].amount)
                                .font(.headline)
                            
                            Text(expenses[index].date)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .foregroundStyle(.black)
                    .offset(y: show ? 0 : CGFloat(index * 100))
                    .opacity(show ? 1 : 0)
                    .animation(.spring(duration: Double(index) * 0.15), value: show)
                    .padding()
                }
            }
            .padding(10)
        }
        .scrollIndicators(.hidden)
        .background(.white, in: .rect(cornerRadius: 16))
        .frame(maxHeight: .infinity)
        .ignoresSafeArea()
        .padding(.horizontal, 20)
    }
}

//#Preview {
//    ExpenseView()
//}
