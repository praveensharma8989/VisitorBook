//
//  UIViewController+PS.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 05/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    public func Push(controller : UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    public func pushWithoutAnimation(controller : UIViewController) {
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
}
