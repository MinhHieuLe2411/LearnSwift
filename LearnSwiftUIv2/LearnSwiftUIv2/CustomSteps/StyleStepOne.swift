//
//  StyleStepOne.swift
//  LearnSwiftUIv2
//
//  Created by MinhHieu on 29/08/2024.
//

import SwiftUI

struct StyleStepOne: View {
    
    var StepsNum: Int
    @Binding var currentStep: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0 ..< StepsNum , id: \.self) { item in
                Circle().stroke(lineWidth: item <= currentStep ? 25 : 3)
                    .frame(width: 40, height: item <= currentStep ? 15 : 40)
                    .foregroundStyle(item <= currentStep ? .green : .gray)
                    .overlay {
                        if item <= currentStep {
                            Image(systemName: "checkmark").font(.title2)
                                .foregroundStyle(.white)
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
                            .foregroundStyle(.green)
                    }
                }
            }
        }
    }
}

//#Preview {
//    StyleStepOne(StepsNum: 5, currentStep: <#T##Binding<Int>#>)
//}

#Preview {
    CustomStepsHomeView()
}
