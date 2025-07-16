//
//  ViewController.swift
//  DetectRectangle
//
//  Created by MinhHieu on 15/01/2025.
//

import UIKit
import Vision

class ViewController: UIViewController {
//    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var imageTest: UIImageView!

    var croppedImages: [UIImage] = [] // Mảng lưu các ảnh con

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//        setupCollectionView()

        // Ảnh gốc chứa nhiều hình
        guard let largeImage = UIImage(named: "image_test_1") else {
            print("Không thể tải ảnh gốc")
            return
        }

        // Phát hiện và crop ảnh
        detectAndCropImages(from: largeImage)
    }

//    func setupCollectionView() {
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//        collectionView.register(cellType: CellTextImage.self)
//    }

    func detectAndCropImages(from image: UIImage) {
        guard let ciImage = CIImage(image: image) else {
            print("Không thể chuyển UIImage thành CIImage")
            return
        }

        // Tạo request phát hiện hình chữ nhật
        let rectangleDetectionRequest = VNDetectRectanglesRequest { [weak self] request, error in
            if let error = error {
                print("Lỗi khi phát hiện hình chữ nhật: \(error)")
                return
            }

            guard let results = request.results as? [VNRectangleObservation] else {
                print("Không có kết quả phát hiện")
                return
            }

            print("Tìm thấy \(results.count) hình chữ nhật")
            
            // Áp dụng Non-Maximum Suppression để loại bỏ các bounding boxes trùng lặp
            let filterResults = self.nonMaximumSuppression(observations: results, iouThreshold: 0.3) ?? []
            
            // Lọc các bounding boxes dựa trên kích thước
            let finalobservations = self.filterBySize(observations: filterResults, minSize: 0.05, maxSize: 0.5)

            // Chuyển các boundingBox thành CGRect
            let rectangles = results.map { self?.convertBoundingBox($0.boundingBox, imageSize: image.size) ?? CGRect.zero }

            // Vẽ hình chữ nhật lên ảnh
            DispatchQueue.main.async {
                self?.drawRectangles(on: image, rectangles: finalobservations)
            }

            // Crop các hình chữ nhật và lưu vào mảng
            self?.croppedImages = results.compactMap { observation in
                self?.cropImage(from: image, with: observation.boundingBox)
            }

//            self?.collectionView.reloadData()

            print("Số lượng ảnh con: \(self?.croppedImages.count ?? 0)")
        }

        // Cấu hình request
        rectangleDetectionRequest.minimumSize = 0.1
        rectangleDetectionRequest.maximumObservations = 20
        rectangleDetectionRequest.minimumAspectRatio = 0.5
        rectangleDetectionRequest.maximumAspectRatio = 2.0

        // Thực hiện request
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        do {
            try handler.perform([rectangleDetectionRequest])
        } catch {
            print("Lỗi khi thực hiện request: \(error)")
        }
    }

    // Chuyển boundingBox từ Vision thành CGRect trên ảnh gốc
    func convertBoundingBox(_ boundingBox: CGRect, imageSize: CGSize) -> CGRect {
        let width = boundingBox.width * imageSize.width
        let height = boundingBox.height * imageSize.height
        let x = boundingBox.origin.x * imageSize.width
        let y = (1 - boundingBox.origin.y - boundingBox.height) * imageSize.height
        return CGRect(x: x, y: y, width: width, height: height)
    }

    // Hàm crop ảnh từ boundingBox
    func cropImage(from image: UIImage, with boundingBox: CGRect) -> UIImage? {
        let imageSize = image.size

        // Chuyển boundingBox từ Vision (tỷ lệ 0-1) sang CGRect thực tế
        let x = boundingBox.origin.x * imageSize.width
        let y = (1 - boundingBox.origin.y - boundingBox.height) * imageSize.height
        let width = boundingBox.width * imageSize.width
        let height = boundingBox.height * imageSize.height
        let rect = CGRect(x: x, y: y, width: width, height: height)

        // Crop ảnh
        guard let cgImage = image.cgImage?.cropping(to: rect) else {
            print("Không thể crop ảnh")
            return nil
        }

        return UIImage(cgImage: cgImage)
    }

    // MARK: - Draw Rectangles

    // Vẽ các hình chữ nhật lên ảnh
    func drawRectangles(on image: UIImage, rectangles: [CGRect]) {
        UIGraphicsBeginImageContext(image.size)
        let context = UIGraphicsGetCurrentContext()
        image.draw(at: .zero)

        context?.setStrokeColor(UIColor.red.cgColor)
        context?.setLineWidth(5.0)

        for rect in rectangles {
            context?.stroke(rect)
        }

        let updatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        // Hiển thị ảnh đã được thêm các hình chữ nhật
        imageTest.image = updatedImage
    }

    // MARK: - Non-Maximum Suppression (NMS)

    func nonMaximumSuppression(observations: [VNRectangleObservation], iouThreshold: CGFloat) -> [VNRectangleObservation] {
        var filteredObservations: [VNRectangleObservation] = []

        // Sắp xếp các bounding boxes theo độ tin cậy giảm dần
        let sortedObservations = observations.sorted { $0.confidence > $1.confidence }

        // Lặp qua các bounding boxes
        for observation in sortedObservations {
            var shouldKeep = true

            // Kiểm tra xem bounding box hiện tại có chồng chéo với các bounding boxes đã được giữ lại không
            for keptObservation in filteredObservations {
                if intersectionOverUnion(observation, keptObservation) > iouThreshold {
                    shouldKeep = false
                    break
                }
            }

            // Nếu không chồng chéo, giữ lại bounding box này
            if shouldKeep {
                filteredObservations.append(observation)
            }
        }

        return filteredObservations
    }

    // MARK: - Tính toán Intersection over Union (IoU)

    func intersectionOverUnion(_ a: VNRectangleObservation, _ b: VNRectangleObservation) -> CGFloat {
        let rectA = a.boundingBox
        let rectB = b.boundingBox

        // Tính toán diện tích chồng chéo
        let intersectionRect = rectA.intersection(rectB)
        let intersectionArea = intersectionRect.width * intersectionRect.height

        // Tính toán diện tích của từng bounding box
        let areaA = rectA.width * rectA.height
        let areaB = rectB.width * rectB.height

        // Tính toán IoU
        let unionArea = areaA + areaB - intersectionArea
        return intersectionArea / unionArea
    }

    // MARK: - Lọc bounding boxes dựa trên kích thước

    func filterBySize(observations: [VNRectangleObservation], minSize: CGFloat, maxSize: CGFloat) -> [VNRectangleObservation] {
        return observations.filter { observation in
            let area = observation.boundingBox.width * observation.boundingBox.height
            return area >= minSize && area <= maxSize
        }
    }
}
