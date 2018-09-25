//
//  NotificationPopUpViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 26/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import MIBlurPopup

class NotificationPopUpViewController: UIViewController, MIBlurPopupDelegate {
    
    @IBOutlet var containerView: UIView!
    
    var popupView: UIView {
        return containerView ?? UIView()
    }
    
    var blurEffectStyle: UIBlurEffectStyle{
        return .dark
    }
    
    var initialScaleAmmount: CGFloat = 0.0
    
    var animationDuration: TimeInterval = 0.5
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Bundle.main.loadNibNamed("NotificationPopUpViewController", owner: self, options: nil)
        
        self.view.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        modalPresentationCapturesStatusBarAppearance = true
        // Do any additional setup after loading the view.
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
