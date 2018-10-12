//
//  AboutUsViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 05/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class AboutUsViewController: ResidentAllPageViewController {
    @IBOutlet weak var aboutUsLabel: UILabel!
    var aboutUs : AboutUsData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        navigationController?.navigationBar.items![1].setHidesBackButton(true, animated: false)
        setBackBarButton(buttonType: .Defauld)
        setNavigationTitle(With: "Edit Profile", type: .white)
        CallAboutUs()
        
    }

    func setData(){
        
        aboutUsLabel.text = (aboutUs?.aboutus)!
        
    }
    
    func CallAboutUs(){
        
        showLoader()
        
        let param : [String : Any] = [
            "id" : (residentData?.id)!
        ]
        
        PSServiceManager.CallAboutUs(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if status{
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.aboutUs = try? jsonDecoder.decode(AboutUsData.self, from: jsonData!)
                self.setData()
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
