//
//  ImgeViewController.swift
//  VisitorBook
//
//  Created by Praveen on 26/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import MIBlurPopup

class ImgeViewController: UIViewController, MIBlurPopupDelegate {

    @IBOutlet var contentView: UIView!
    
    var popupView: UIView {
        return contentView ?? UIView()
    }
    
    var blurEffectStyle: UIBlurEffectStyle{
        return .dark
    }
    
    var initialScaleAmmount: CGFloat = 0.0
    
    var animationDuration: TimeInterval = 0.5
    
    
    
    
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    var sosData : SosData?
    var visitorInfo : VisitorData?
    var flatUser : FlatUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Bundle.main.loadNibNamed("DailySOSImageView", owner: self, options: nil)
        self.view.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        modalPresentationCapturesStatusBarAppearance = true
        reloadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func CancelButton_press(_ sender: Any) {
        dismiss(animated: true) 
    }
    
    func reloadData() {
        
        if sosData != nil{
            
            nameLable.text = sosData?.name
            userImageView.set_sdWebImage(With: (sosData?.photo)!, placeHolderImage: "CameraImage")
            
        }
        
        if visitorInfo != nil{
            nameLable.text = visitorInfo?.name
            userImageView.set_sdWebImage(With: (visitorInfo?.photo)!, placeHolderImage: "CameraImage")
        }
        
        if flatUser != nil{
            nameLable.text = flatUser?.name
            userImageView.set_sdWebImage(With: (flatUser?.photo)!, placeHolderImage: "CameraImage")
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
