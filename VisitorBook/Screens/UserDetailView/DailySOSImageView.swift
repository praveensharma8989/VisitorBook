//
//  DailySOSImageView.swift
//  VisitorBook
//
//  Created by Praveen on 14/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

typealias DailySOSCancel = () -> (Void)
class DailySOSImageView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var dailySOSCancel : DailySOSCancel? = nil
    
    @IBAction func CancelButton_press(_ sender: Any) {
        if dailySOSCancel != nil{
            dailySOSCancel!()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commanInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commanInit()
    }
    
    func reloadData() {
        
        
        
    }
    
    private func commanInit(){
        Bundle.main.loadNibNamed("DailySOSImageView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
