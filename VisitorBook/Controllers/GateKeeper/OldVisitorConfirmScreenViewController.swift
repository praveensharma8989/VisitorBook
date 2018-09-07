//
//  OldVisitorConfirmScreenViewController.swift
//  VisitorBook
//
//  Created by Praveen on 07/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import SDWebImage

class OldVisitorConfirmScreenViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var towerLabel: UILabel!
    @IBOutlet weak var floorLabel: UILabel!
    @IBOutlet weak var flateLabel: UILabel!
    @IBOutlet weak var visitDateLabel: UILabel!
    @IBOutlet weak var pusposeLabel: UILabel!
    
    var oldVisitorData : NewVisitorData?
    var gateKeeperData : VisitorUsers?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilize()
        // Do any additional setup after loading the view.
    }

    func initilize(){
        
        userImage.set_sdWebImage(With: (oldVisitorData?.photo)!, placeHolderImage: "CameraImage")
        namelabel.text = oldVisitorData?.name
        towerLabel.text = oldVisitorData?.tower
        floorLabel.text = oldVisitorData?.floor
        flateLabel.text = oldVisitorData?.flats
        visitDateLabel.text = oldVisitorData?.visitDate
        pusposeLabel.text = oldVisitorData?.purpose
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func yesButton_press(_ sender: Any) {
        
        callOldVisitorSubmit()
        
    }
    
    
    func callOldVisitorSubmit(){
        
        view.endEditing(true)
        showLoader()
        
        let param : [String : Any] = [
            "id": (oldVisitorData?.id)!,
            "empid": (gateKeeperData?.cid)!
        ]
        
        
        
        PSServiceManager.OldVisitor(param: param) { (response, status, error) -> (Void) in
            
            self.dismissLoader()
            
            if(status){
                
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                
                
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
            
        }
        
        
    }
    
    
    @IBAction func noButton_press(_ sender: Any) {
        
        self.view.endEditing(true)
        
        let VisitorDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "VisitorDetailsViewController") as! VisitorDetailsViewController
        VisitorDetailVC.oldVisitorData = oldVisitorData
        VisitorDetailVC.gateKeeperData = gateKeeperData
        Push(controller: VisitorDetailVC)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
