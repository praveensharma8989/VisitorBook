//
//  SideMenuSectionHeaderView.swift
//  VisitorBook
//
//  Created by Praveen on 21/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

typealias HeaderSelected = () -> (Void)

class SideMenuSectionHeaderView: UITableViewHeaderFooterView {

    var headerSelected : HeaderSelected? = nil
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func SectionSelectButton_press(_ sender: Any) {
        
        if headerSelected != nil{
            headerSelected!()
        }
    }
}
