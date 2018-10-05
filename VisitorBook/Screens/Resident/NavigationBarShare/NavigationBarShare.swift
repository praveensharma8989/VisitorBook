//
//  NavigationBarShare.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 04/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

typealias BackButtonClick = () -> (Void)
typealias ShareButtonClick = () -> (Void)
typealias HomeButtonClick = () -> (Void)

class NavigationBarShare: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLable: UILabel!
    
    var backButtonClick : BackButtonClick? = nil
    var shareButtonClick : ShareButtonClick? = nil
    var homeButtonClick : HomeButtonClick? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commanInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commanInit()
    }
    
    private func commanInit(){
        Bundle.main.loadNibNamed("NavigationBarShare", owner: self, options: nil)
        
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
    
    
    @IBAction func backButton_Press(_ sender: Any) {
        if backButtonClick != nil{
            backButtonClick!()
        }
    }
    @IBAction func homeButton_press(_ sender: Any) {
        if homeButtonClick != nil{
            homeButtonClick!()
        }
    }
    @IBAction func shareButton_press(_ sender: Any) {
        if shareButtonClick != nil{
            shareButtonClick!()
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
