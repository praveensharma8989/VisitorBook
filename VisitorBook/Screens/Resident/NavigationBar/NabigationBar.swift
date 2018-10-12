//
//  NavigationBarView.swift
//  VisitorBook
//
//  Created by Praveen on 21/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

typealias LeftMenuClick = () -> (Void)
typealias SOSMenuClick = () -> (Void)

class NavigationBarView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var SOSButton: UIButton!
    @IBOutlet var contentView: UIView!
    var leftMenuClick : LeftMenuClick? = nil
    var sosMenuClick : SOSMenuClick? = nil
    var timer : Timer? = nil
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
        
        if timer != nil{
            timer!.invalidate()
            timer = nil
        }
        
        timer  = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { (timerNew) in
                self.SOSImageChange()
        })
        
    }
    
    func SOSImageChange(){
        
        if SOSButton.isSelected{
            SOSButton.isSelected = false
        }else{
            SOSButton.isSelected = true
        }
        
    }
    

    @IBAction func LeftMenuButton_press(_ sender: Any) {
        if leftMenuClick != nil{
            leftMenuClick!()
        }
    }
    @IBAction func SOSButton_press(_ sender: Any) {
        if sosMenuClick != nil{
            sosMenuClick!()
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
