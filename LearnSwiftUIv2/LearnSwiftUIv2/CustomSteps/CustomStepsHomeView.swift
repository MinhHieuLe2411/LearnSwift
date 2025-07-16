//
//  CustomStepsHomeView.swift
//  LearnSwiftUIv2
//
//  Created by MinhHieu on 29/08/2024.
//

import SwiftUI

struct CustomStepsHomeView: View {
    @State var stepsNum: Int = 6
    @State var currentStep: Int = 0
    
    var body: some View {
        VStack(spacing: 60, content: {
            StyleStepOne(StepsNum: 4, currentStep: $currentStep)
            
            StyleStepTwo(StepsNum: 3, currentStep: $currentStep)
            
            HStack {
                Button(action: {
                    withAnimation {
                        if currentStep > 0 {
                            currentStep -= 1
                        }
                    }
                }, label: {
                    Text("Back")
                })
                .padding(.horizontal)
                
                Button(action: {
                    withAnimation {
                        if currentStep < stepsNum {
                            currentStep += 1
                        }
                    }
                    
                }, label: {
                    Text("Next")
                })
                .padding(.horizontal)
            }
            .font(.largeTitle)
        })
        .padding()
    }
}

#Preview {
    CustomStepsHomeView()
}
