//
//  ResidentProfileViewController.swift
//  VisitorBook
//
//  Created by Praveen on 24/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import CircleProgressView

class ResidentProfileViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var flatLbl: UILabel!
    
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var genderDOBLbl: UILabel!
    @IBOutlet weak var vehicleLbl: UILabel!
    @IBOutlet weak var stickerLbl: UILabel!
    @IBOutlet weak var progressView: CircleProgressView!
    
    @IBOutlet weak var percentageLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SOSSettingButton_press(_ sender: Any) {
    }
    
    @IBAction func editButton_press(_ sender: Any) {
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
