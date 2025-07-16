//
//  OpenCardView.swift
//  LearnSwiftUIv2
//
//  Created by MinhHieu on 26/08/2024.
//

import SwiftUI

struct OpenCardView: View {
    @Binding var close: Bool
    @State var show = false
    
    var data: CardMode
    var namespace: Namespace.ID
    @Namespace var namespace2
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).ignoresSafeArea()
            VStack {
                CardView(data: data, namespace: namespace)
                    .matchedGeometryEffect(id: data.id, in: namespace)
                    .onTapGesture {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                            withAnimation(.spring(duration: 0.2)) {
                                close = false
                            }
                        })
                        
                        withAnimation(.spring(duration: 0.2)) {
                            show = false
                        }
                    }
                ExpenseView(show: $show)
                    .offset(y: show ? 0 : 440)
            }
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                withAnimation(.spring(duration: 0.4)) {
                    show = true
                }
            })
        }
        .onDisappear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                withAnimation(.spring(duration: 0.2)) {
                    show = true
                }
            })
        }
        .onChange(of: close) { old, newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                if newValue {
                    withAnimation(.spring(duration: 0.2)) {
                        show = true
                    }
                }
            })
        }
    }
}

//#Preview {
//    OpenCardView()
//}

#Preview {
    ContentViewCard()
}
