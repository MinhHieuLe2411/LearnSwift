//
//  DataImageManage.swift
//  LearnSwiftUIv2
//
//  Created by MinhHieu on 28/08/2024.
//

import Foundation
import SwiftUI

struct ImageItem: Identifiable {
    var id = UUID()
    var imageName: String
}

@Observable
class DataImageManager {
    let items: [ImageItem] = [
        ImageItem(imageName: "room_demo1"),
        ImageItem(imageName: "room_demo2"),
        ImageItem(imageName: "room_demo3"),
        ImageItem(imageName: "room_demo4"),
        ImageItem(imageName: "room_demo5"),
        ImageItem(imageName: "room_demo6"),
        ImageItem(imageName: "room_demo7"),
        ImageItem(imageName: "room_demo8"),
        ImageItem(imageName: "room_demo9"),
        ImageItem(imageName: "room_demo10"),
        ImageItem(imageName: "room_demo11"),
        ImageItem(imageName: "room_demo12"),
        ImageItem(imageName: "room_demo13"),
        ImageItem(imageName: "room_demo14"),
        ImageItem(imageName: "room_demo15"),
        ImageItem(imageName: "room_demo16"),
        ImageItem(imageName: "room_demo17"),
        ImageItem(imageName: "room_demo18")
    ]
    
    var selectedImage: ImageItem?
    var leftColumn: [ImageItem] = []
    var rightColumn: [ImageItem] = []
    var imageHeights: [UUID: CGFloat] = [:]
    let spacing: CGFloat = 10
    let columns = 2.0
    
    func imageHeight(for item: ImageItem) -> CGFloat {
        return imageHeights[item.id] ?? 200
    }
    
    func caculateImageHeight(for item: ImageItem, width: CGFloat) -> CGFloat {
        guard let uiimage = UIImage(named: item.imageName) else { return width * 1.5 }
        let height = width * uiimage.size.height / uiimage.size.width
        return height
    }
    
    func updateImageHeight(for item: ImageItem, width: CGFloat) {
        DispatchQueue.global().async { [weak self] in
            guard let strongSelf = self else { return }
            let height = strongSelf.caculateImageHeight(for: item, width: width)
            DispatchQueue.main.async {
                strongSelf.imageHeights[item.id] = height
            }
        }
    }
    
    func distributeImages() {
        var leftHeight: CGFloat = 0
        var rightHeight: CGFloat = 0
        if leftColumn.isEmpty && rightColumn.isEmpty {
            for image in items {
                let imageHeight = caculateImageHeight(for: image, width: 200)
                if leftHeight <= rightHeight {
                    leftColumn.append(image)
                    leftHeight += imageHeight
                } else {
                    rightColumn.append(image)
                    rightHeight += imageHeight
                }
            }
        }
    }
}
