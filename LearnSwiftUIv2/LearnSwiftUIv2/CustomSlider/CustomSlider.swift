//
//  CustomSlider.swift
//  LearnSwiftUIv2
//
//  Created by MinhHieu on 30/08/2024.
//

import SwiftUI

struct CustomSlider: View {
    let width: CGFloat
    let height: CGFloat
    let axis: Axis = .vertical
    @State var dragging: CGFloat = 0
    @State var theValue: Double = 0
    @State var startDragging: CGFloat = 0
    var body: some View {
        ZStack {
            Capsule()
                .frame(width: width, height: height)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: axis == .horizontal ? .leading : .bottom)
                .foregroundStyle(.thinMaterial)
            
            Capsule()
                .frame(width: axis == .horizontal ? max(0, dragging + height) : width, height: axis == .vertical ? max(0, -dragging + width) : height )
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: axis == .horizontal ? .leading : .bottom)
                .foregroundStyle(LinearGradient(gradient: Gradient(
                    colors: gradientColor()),
                    startPoint: axis == .horizontal ? .leading : .bottom,
                    endPoint: axis == .horizontal ? .trailing : . top))
            
        }
        .frame(width: width, height: height)
        .overlay(alignment: axis == .horizontal ? .leading : .bottom) {
            Circle()
                .frame(width: axis == .horizontal ? height : width, height: axis == .vertical ? width : height)
                .foregroundStyle(.white)
                .offset(x: axis == .horizontal ? dragging : 0, y: axis == .vertical ? dragging : 0)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            updateDragging(gesture: gesture)
                            theValue = axis == .horizontal ? Double(dragging / maxDragDistance()) : Double(-dragging / maxDragDistance())
                        }
                        .onEnded {_ in 
                            startDragging = dragging
                        }
                )
        }
    }
    
    func updateDragging(gesture: DragGesture.Value) {
        if axis == .horizontal {
            let newValue = startDragging + gesture.translation.width
            dragging = newValue <= 0 ? 0 : min(newValue, maxDragDistance())
        } else {
            let newValue = startDragging + gesture.translation.height
            dragging = newValue >= 0 ? 0 : max(newValue, -maxDragDistance())
        }
    }
    
    func maxDragDistance() -> CGFloat {
        return axis == .horizontal ? width - height : height - width
    }
    
    func gradientColor() -> [Color] {
        let progress = axis == .horizontal ? min(max(dragging / maxDragDistance() , 0) , 1) : min(max(-dragging / maxDragDistance() , 0) , 1)
        let topColor = Color(red: progress, green: 1.0, blue: 1.0 - progress)
        let bottomColor = Color(red: progress, green: progress * 0.4, blue: 1.0 - progress)
        return [.red, .blue]
    }
}

#Preview {
    CustomSlider(width: 50, height: 300)
}
