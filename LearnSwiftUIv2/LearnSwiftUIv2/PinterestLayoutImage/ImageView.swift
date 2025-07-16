//
//  ImageView.swift
//  LearnSwiftUIv2
//
//  Created by MinhHieu on 29/08/2024.
//

import SwiftUI

struct ImageView: View {
    let imageName: String
    @Binding var dragOffset: CGSize
    @Binding var isDragging: Bool
    let onDismiss: () -> Void
    
    var body: some View {
        GeometryReader { geo in
            Image(imageName).resizable().scaledToFit()
                .frame(width: geo.size.width, height: geo.size.height)
                .scaleEffect(max(1 - hypot(dragOffset.width, dragOffset.height) / 1000 , 0.3))
                .offset(x: dragOffset.width, y: dragOffset.height)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation {
                                isDragging = true
                                dragOffset = value.translation
                            }
                        })
                        .onEnded({ value in
                            if abs(dragOffset.height) > 150 || abs(dragOffset.width) > 150 {
                                onDismiss()
                            } else {
                                withAnimation {
                                    dragOffset = .zero
                                    isDragging = false
                                }
                            }
                        })
                )
            
        }
    }
}

//#Preview {
//    ImageView(imageName: "room_demo1", onDismiss: {})
//}
