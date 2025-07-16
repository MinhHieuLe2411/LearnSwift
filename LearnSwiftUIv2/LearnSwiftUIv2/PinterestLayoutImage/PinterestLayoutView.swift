//
//  PinterestLayoutView.swift
//  LearnSwiftUIv2
//
//  Created by MinhHieu on 28/08/2024.
//

import SwiftUI

struct PinterestLayoutView: View {
    var manager: DataImageManager = .init()
    @State var dragOffset: CGSize = .zero
    @State var isDragging = false
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                let frame = geo.frame(in: .global)
                let columnWidth = (geo.size.width - (3.0 * manager.spacing / 2.0)) / manager.columns
                
                ScrollView {
                    HStack(alignment: .top) {
                        LazyVStack(spacing: manager.spacing) {
                            ForEach(manager.leftColumn) { image in
                                pinterestCell(for: image, width: columnWidth, frame: frame)
                            }
                        }
                        
                        LazyVStack(spacing: manager.spacing) {
                            ForEach(manager.rightColumn) { image in
                                pinterestCell(for: image, width: columnWidth, frame: frame)
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .onAppear() {
                    manager.distributeImages()
                }
                .blur(radius: manager.selectedImage == nil ? 0 : max(10 - abs(dragOffset.height) / 60, 0), opaque: false )
            }
            .safeAreaPadding(.horizontal, 9)
            
            if let selectedImage = manager.selectedImage {
                ImageView(imageName: selectedImage.imageName, dragOffset: $dragOffset, isDragging: $isDragging) {
                    manager.selectedImage = nil
                    dragOffset = .zero
                }
            }
        }
    }
    
    @ViewBuilder
    func pinterestCell(for item: ImageItem, width: CGFloat, frame: CGRect) -> some View {
        Image(item.imageName).resizable().scaledToFill()
            .frame(width: width, height: manager.imageHeight(for: item))
            .clipShape(.rect(cornerRadius: 12))
        
            .onAppear() {
                manager.updateImageHeight(for: item, width: width)
            }
            .onTapGesture {
                withAnimation {
                    if manager.selectedImage == nil {
                        manager.selectedImage = item
                    }
                }
            }
            .frame(height: manager.imageHeight(for: item))
        
    }
}

#Preview {
    PinterestLayoutView()
}
