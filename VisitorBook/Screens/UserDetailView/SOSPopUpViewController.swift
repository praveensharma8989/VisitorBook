//
//  SOSPopUpViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 12/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import MIBlurPopup

typealias SOSPopUpClose =  () -> (Void)

class SOSPopUpViewController: UIViewController, MIBlurPopupDelegate {
    
    @IBOutlet var contentView: UIView!
    
    var sOSPopUpClose : SOSPopUpClose? = nil
    
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
        
        Bundle.main.loadNibNamed("SOSPopUpViewController", owner: self, options: nil)
        self.view.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        modalPresentationCapturesStatusBarAppearance = true
        reloadData()
        // Do any additional setup after loading the view.
    }
    
    func reloadData(){
        
    }
    
    
    
    
    @IBAction func okButton_press(_ sender: Any) {
        
        if sOSPopUpClose != nil{
            
            sOSPopUpClose!()
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
