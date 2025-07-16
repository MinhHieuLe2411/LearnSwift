//
//  StyleStepTwo.swift
//  LearnSwiftUIv2
//
//  Created by MinhHieu on 29/08/2024.
//

import SwiftUI

struct StyleStepTwo: View {
    
    var StepsNum: Int
    @Binding var currentStep: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0 ..< StepsNum , id: \.self) { item in
                Circle().stroke(lineWidth: 3)
                    .frame(width: 40, height: 40)
                    .foregroundStyle(item <= currentStep ? .red : .blue)
                    .overlay {
                        Text("Step \(item + 1)")
                            .fixedSize()
                            .offset(x: 3, y: 45)
                            .foregroundStyle(item <= currentStep ? .red : .blue)
                    }
                    .overlay {
                        if item <= currentStep {
                            Image(systemName: "checkmark.circle.fill").resizable()
                                .frame(width: 43, height: 43)
                                .foregroundStyle(.primary)
                                .transition(.scale)
                        }
                    }
                if item < StepsNum - 1 {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 3)
                            .foregroundStyle(.gray)
                        Rectangle()
                            .frame(height: 3)
                            .frame(maxWidth: item >= currentStep ? 0 : .infinity , alignment: .leading)
                            .foregroundStyle(.primary)
                    }
                }
            }
        }
    }
}

//#Preview {
//    StyleStepTwo()
//}

#Preview {
    CustomStepsHomeView()
}
