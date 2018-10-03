//
//  EventPhotoFooterView.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 29/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit


protocol EventPhotoFooterViewDelegate: class {
    func footerView(_ footerView: EventPhotoFooterView, didPressShareButton button: UIButton)
//    func footerView(_ footerView: EventPhotoFooterView, didPressDownloadButton button: UIButton)
}

class EventPhotoFooterView: UIView {
    weak var viewDelegate: EventPhotoFooterViewDelegate?
    static let ButtonSize = CGFloat(50.0)
    
    lazy var shareButton: UIButton = {
        let image = #imageLiteral(resourceName: "shareIcon")
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        
        return button
    }()
    
//    lazy var downloadButton: UIButton = {
//        let image = #imageLiteral(resourceName: "downloadIcon")
//        let button = UIButton(type: .custom)
//        button.setImage(image, for: .normal)
//
//        return button
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.shareButton)
//        self.addSubview(self.downloadButton)
        
        self.shareButton.addTarget(self, action: #selector(EventPhotoFooterView.shareAction(button:)), for: .touchUpInside)
//        self.downloadButton.addTarget(self, action: #selector(EventPhotoFooterView.downloadAction(button:)), for: .touchUpInside)
    }
    
    init(headingLabel : String) {
        
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: EventPhotoFooterView.ButtonSize))
        
        self.addSubview(self.shareButton)
//        self.addSubview(self.downloadButton)
        
        self.shareButton.addTarget(self, action: #selector(EventPhotoFooterView.shareAction(button:)), for: .touchUpInside)
//        self.downloadButton.addTarget(self, action: #selector(EventPhotoFooterView.downloadAction(button:)), for: .touchUpInside)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let shareSizes = self.widthForElementAtIndex(index: 0, totalElements: 2)
        self.shareButton.frame = CGRect(x: shareSizes.x, y: 0, width: shareSizes.width, height: EventPhotoFooterView.ButtonSize)
        
//        let downloadSizes = self.widthForElementAtIndex(index: 1, totalElements: 2)
//        self.downloadButton.frame = CGRect(x: downloadSizes.x, y: 0, width: downloadSizes.width, height: EventPhotoFooterView.ButtonSize)
    }
    
    func widthForElementAtIndex(index: Int, totalElements: Int) -> (x: CGFloat, width: CGFloat) {
        let bounds = UIScreen.main.bounds
        let singleFrame = bounds.width / CGFloat(totalElements)
        
        return (singleFrame * CGFloat(index), singleFrame)
    }
    
    @objc func shareAction(button: UIButton) {
        self.viewDelegate?.footerView(self, didPressShareButton: button)
    }
    
//    @objc func downloadAction(button: UIButton) {
//        self.viewDelegate?.footerView(self, didPressDownloadButton: button)
//    }
}
