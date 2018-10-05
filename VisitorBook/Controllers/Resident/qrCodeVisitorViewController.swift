//
//  qrCodeVisitorViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 04/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class qrCodeVisitorViewController: ResidentAllPageViewController {
    @IBOutlet weak var societyImage: UIImageView!
    @IBOutlet weak var visitorNameMobileLabel: UILabel!
    @IBOutlet weak var purposeLabel: UILabel!
    @IBOutlet weak var validUptoLabel: UILabel!
    @IBOutlet weak var qrImageView: UIImageView!
    @IBOutlet weak var createdBylabel: UILabel!
    
    @IBOutlet weak var viewToImageView: UIView!
    var expectedVisitor : ExpectedVisitor? = nil
    var navigationBarView : NavigationBarShare?
    
    var residentDashboardDataNew = CommanFunction.instance.getUserDataResidentDashBoard()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        
        
        navigationBarView = NavigationBarShare.init(frame: (navigationController?.navigationBar.bounds)!)
        
        navigationBarView!.backButtonClick = {() in
            self.PopBack()
        }
        
        navigationBarView!.homeButtonClick = {() in
            self.PopToRoot()
        }
        
        navigationBarView!.shareButtonClick = {() in
            self.shareQRCode()
        }
        
        navigationBarView?.titleLable.text = (expectedVisitor?.name)! + " QRCode"
        
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.addSubview(navigationBarView!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationBarView?.removeFromSuperview()
    }
    
    func shareQRCode(){
        
        let imageShare = [UIImage(view: viewToImageView)]
        
        let activityViewController = UIActivityViewController(activityItems: imageShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func setData(){
        
        societyImage.set_sdWebImage(With: (expectedVisitor?.socityPhoto)!, placeHolderImage: "userIcon")
        visitorNameMobileLabel.text = (expectedVisitor?.name)! + " " + (expectedVisitor?.mobile)!
        purposeLabel.text = "Purpose : " + (expectedVisitor?.purpose)!
        validUptoLabel.text = "Valid upto " + (expectedVisitor?.validTo)!
        qrImageView.set_sdWebImage(With: (expectedVisitor?.qrCode)!, placeHolderImage: "userIcon")
        createdBylabel.text = (residentDashboardDataNew?.name)! + " (" + ")"
        
        
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

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
}
