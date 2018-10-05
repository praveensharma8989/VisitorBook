//
//  OfferDetailViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 05/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class OfferDetailViewController: ResidentAllPageViewController {
    @IBOutlet weak var offerTitlabel: UILabel!
    @IBOutlet weak var offerDescriptionLabel: UILabel!
    
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var urlButton: UIButton!
    @IBOutlet weak var validityLabel: UILabel!
    
    var offerDetail : OfferDetail? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        setBackBarButton(buttonType: .Defauld)
        setData()
        
    }
    
    func setData(){
        
        offerTitlabel.text = (offerDetail?.offerName)!
        offerDescriptionLabel.text = (offerDetail?.discription)!
        urlLabel.text = offerDetail?.url != nil && offerDetail?.url != "" ? (offerDetail?.url)! : ""
        urlButton.isHidden = offerDetail?.url != nil && offerDetail?.url != "" ? false : true
        validityLabel.text = (offerDetail?.validity)!
        
    }

    @IBAction func claimNowButton_press(_ sender: Any) {
        CallClaimApi()
    }
    
    @IBAction func urlButton_press(_ sender: Any) {
        
        guard let url = URL(string: (offerDetail?.url)!) else { return }
        UIApplication.shared.open(url)
        
    }
    
    func CallClaimApi(){
        
        showLoader()
        
        let param : [String : Any] = [
            "uid" : (residentData?.id)!,
            "offer_id" : (offerDetail?.id)!
        ]
        
        PSServiceManager.CallClaimForOffer(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if status{
                self.showAlertMessage(titleStr: "Success", messageStr: response!["msg"] as! String)
                self.PopBack()
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
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
