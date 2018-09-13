//
//  DotViewMenu.swift
//  VisitorBook
//
//  Created by Praveen on 13/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit


typealias DailySOS = () -> (Void)
typealias PasswordChange = () -> (Void)
typealias Logout = () -> (Void)
class DotViewMenu: UIView {

    var dailySOS : DailySOS? = nil
    var passwordChange : PasswordChange? = nil
    var logout : Logout? = nil
    @IBOutlet var contentView: UIView!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("DotViewMenu", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction func dailySOSButton_press(_ sender: Any) {
        if dailySOS != nil{
            dailySOS!()
        }
    }
    
    @IBAction func changePasswordButton_press(_ sender: Any) {
        if passwordChange != nil{
            passwordChange!()
        }
    }
    
    @IBAction func logoutButton_press(_ sender: Any) {
        if logout != nil{
            logout!()
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
