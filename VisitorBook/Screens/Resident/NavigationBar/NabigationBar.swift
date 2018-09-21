//
//  NavigationBarView.swift
//  VisitorBook
//
//  Created by Praveen on 21/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

typealias LeftMenuClick = () -> (Void)

class NavigationBarView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet var contentView: UIView!
    var leftMenuClick : LeftMenuClick? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commanInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commanInit()
    }
    
    private func commanInit(){
        Bundle.main.loadNibNamed("NavigationBarView", owner: self, options: nil)
       
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         addSubview(contentView)
    }

    @IBAction func LeftMenuButton_press(_ sender: Any) {
        if leftMenuClick != nil{
            leftMenuClick!()
        }
    }
}

//extension UIView {
//    /** Loads instance from nib with the same name. */
//    func loadNib() -> UIView {
//        let bundle = Bundle(for: type(of: self))
//        let nibName = type(of: self).description().components(separatedBy: ".").last!
//        let nib = UINib(nibName: nibName, bundle: bundle)
//        return nib.instantiate(withOwner: self, options: nil).first as! UIView
//    }
//}
