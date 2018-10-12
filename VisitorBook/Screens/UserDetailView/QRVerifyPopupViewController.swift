//
//  QRVerifyPopupViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 05/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import MIBlurPopup

typealias VisitorPopupClick =  () -> (Void)

class QRVerifyPopupViewController: UIViewController, MIBlurPopupDelegate {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var visitorStatusLabel: UILabel!
    @IBOutlet weak var visitorMessageLabel: UILabel!
    @IBOutlet weak var visitorNameLabel: UILabel!
    var visitorPopupClick : VisitorPopupClick? = nil
    var isEntered : Bool = false
    
    var qRLoginData : QRLoginData? = nil
    
    
    var popupView: UIView {
        return contentView ?? UIView()
    }
    
    var blurEffectStyle: UIBlurEffectStyle{
        return .dark
    }
    
    var initialScaleAmmount: CGFloat = 0.0
    
    var animationDuration: TimeInterval = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Bundle.main.loadNibNamed("QRVerifyPopupViewController", owner: self, options: nil)
        self.view.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        modalPresentationCapturesStatusBarAppearance = true
        reloadData()
        // Do any additional setup after loading the view.
    }
    
    func reloadData(){
        
        if qRLoginData != nil {
            
            statusImageView.image = #imageLiteral(resourceName: "yesIcon")
            visitorStatusLabel.text = isEntered == true ? "Visitor Allowed" : "Exit Now"
            visitorMessageLabel.text = (qRLoginData?.msg)!
            visitorNameLabel.text = (qRLoginData?.responseData)!
            
        }else{
            statusImageView.image = #imageLiteral(resourceName: "noIcon")
            visitorStatusLabel.text = isEntered == true ? "Visitor not Allowed" : "Time has been expired"
            visitorMessageLabel.text = (qRLoginData?.msg)!
            visitorNameLabel.text = ""
        }
        
    }

    @IBAction func yesButton_press(_ sender: Any) {
        
        if visitorPopupClick != nil{
            
            visitorPopupClick!()
            dismiss(animated: true)
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
