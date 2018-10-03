//
//  ViewerController+PS.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 29/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation
import Viewer

extension ViewerController{
    
    
    func changeHeaderView(headerViewNew : UIView){
        
        self.headerView?.removeFromSuperview()
        self.headerView = headerViewNew
        
        if let headerView = self.headerView{
            
            let bounds = UIScreen.main.bounds
            
            headerView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: CGFloat(64))
            headerView.autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin, .flexibleWidth]
            headerView.alpha = 1
            self.view.addSubview(headerView)
        }
        
    }
    
    func changeFooterView(footerViewNew : UIView){
        
        self.footerView?.removeFromSuperview()
        self.footerView = footerViewNew
        
        if let footerView = self.footerView{
            let bounds = UIScreen.main.bounds
            footerView.frame = CGRect(x: 0, y: bounds.size.height - CGFloat(50), width: bounds.width, height: CGFloat(50))
            footerView.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin, .flexibleWidth]
            footerView.alpha = 1
            self.view.addSubview(footerView)
        }
        
    }
    
}
