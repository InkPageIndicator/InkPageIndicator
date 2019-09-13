//
//  ScrollingImageCell.swift
//  Example
//
//  Created by tskim on 13/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

class ScrollingImageCell: UICollectionViewCell, SwiftNameIdentifier {
    var imageView: UIImageView!
    var scrollView: UIScrollView!
    var dTapGR: UITapGestureRecognizer!
    
    var imageSize: CGSize = .zero {
        didSet {
            updateLayout()
        }
    }
    
    var image: UIImage? {
        get { return imageView.image }
        set {
            imageView.image = newValue
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView = UIScrollView(frame: bounds)
        imageView = UIImageView(frame: bounds)
        imageView.contentMode = .scaleAspectFill
        scrollView.addSubview(imageView)
        scrollView.maximumZoomScale = 3
        scrollView.delegate = self
        scrollView.contentMode = .center
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        addSubview(scrollView)
        
        dTapGR = UITapGestureRecognizer(target: self, action: #selector(doubleTap(gr:)))
        dTapGR.numberOfTapsRequired = 2
        addGestureRecognizer(dTapGR)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        scrollView = UIScrollView(frame: bounds)
        imageView = UIImageView(frame: bounds)
        imageView.contentMode = .scaleAspectFill
        scrollView.addSubview(imageView)
        scrollView.maximumZoomScale = 3
        scrollView.delegate = self
        scrollView.contentMode = .center
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        addSubview(scrollView)
        
        dTapGR = UITapGestureRecognizer(target: self, action: #selector(doubleTap(gr:)))
        dTapGR.numberOfTapsRequired = 2
        addGestureRecognizer(dTapGR)
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width = imageView.frame.size.width / scale
        let newCenter = imageView.convert(center, from: scrollView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    @objc
    func doubleTap(gr: UITapGestureRecognizer) {
        if scrollView.zoomScale == 1 {
            scrollView.zoom(to: zoomRectForScale(scale: scrollView.maximumZoomScale, center: gr.location(in: gr.view)), animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayout()
    }
    
    private func updateLayout() {
        scrollView.frame = bounds
        let size: CGSize = calculateBoundary(parent: bounds.size, child: self.imageSize)
        scrollView.contentSize = size
        imageView.frame = CGRect(origin: .zero, size: size)
        centerIfNeeded()
    }
    
    private func calculateBoundary(parent: CGSize, child: CGSize) -> CGSize {
        let containerSize = CGSize(width: parent.width, height: parent.height)
        // iPhone6s 기준
        // (414 / 896) < (250 / 208)  이라면
        // 이미지 Width 비율이 단말 Width 비율 보다 크다면
        // 단말 Width 를 설정하고 그에 따른 Height 를 조정한다.
        if containerSize.width / containerSize.height < child.width / child.height {
            return CGSize(width: containerSize.width, height: containerSize.width * child.height / child.width)
        } else {
            // 단말 Height 를 설정하고 그에 따른 Width 를 조정한다.
            return CGSize(width: containerSize.height * child.width / child.height, height: containerSize.height)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        scrollView.setZoomScale(1, animated: false)
    }
    
    func centerIfNeeded() {
        /*
         ScrollView
         ------------
         |   Image  |
         |          |
         |----------|
         |          |
         |          |
         |          |
         |----------|
         
         To Centerize
         
         ------------
         |          |
         |----------|
         |          |
         |  Image   |
         |----------|
         |          |
         ------------
         */
        var inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        if scrollView.contentSize.height < scrollView.bounds.height {
            let insetV = (scrollView.bounds.height - scrollView.contentSize.height) / 2
            inset.top += insetV
            inset.bottom = insetV
        }
        if scrollView.contentSize.width < scrollView.bounds.width {
            let insetV = (scrollView.bounds.width - scrollView.contentSize.width) / 2
            inset.left = insetV
            inset.right = insetV
        }
        scrollView.contentInset = inset
    }
}

extension ScrollingImageCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerIfNeeded()
    }
}
