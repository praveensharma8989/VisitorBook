//
//  EventPhotoHeaderView.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 29/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit



protocol EventPhotoHeaderViewDelegate: class {
    func headerView(_ headerView: EventPhotoHeaderView, didPressClearButton button: UIButton)
}

class EventPhotoHeaderView: UIView {
    weak var viewDelegate: EventPhotoHeaderViewDelegate?
    static let ButtonSize = CGFloat(50.0)
    static let TopMargin = CGFloat(15.0)
    var heading : String?
    
    
    
    lazy var clearButton: UIButton = {
        let image = UIImage(named: "clear")!
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(EventPhotoHeaderView.clearAction(button:)), for: .touchUpInside)
        
        return button
    }()
    
    
    lazy var headerLabel: UILabel = {
       let label = UILabel.init()
        label.text = heading
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.clearButton)
        self.addSubview(self.headerLabel)
    }
    
    init(headingLabel : String) {
        
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: EventPhotoHeaderView.ButtonSize))
        self.heading = headingLabel
        self.addSubview(self.clearButton)
        self.addSubview(self.headerLabel)
     
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.clearButton.frame = CGRect(x: 0, y: EventPhotoHeaderView.TopMargin, width: EventPhotoHeaderView.ButtonSize, height: EventPhotoHeaderView.ButtonSize)
        
        let width = UIScreen.main.bounds.size.width - (EventPhotoHeaderView.ButtonSize * 2)
        
        self.headerLabel.frame = CGRect(x: EventPhotoHeaderView.ButtonSize, y: EventPhotoHeaderView.TopMargin, width: width, height: EventPhotoHeaderView.ButtonSize)
        
    }
    
    @objc func clearAction(button: UIButton) {
        self.viewDelegate?.headerView(self, didPressClearButton: button)
    }
    
}

