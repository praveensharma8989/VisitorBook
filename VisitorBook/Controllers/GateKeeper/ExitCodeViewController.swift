//
//  ExitCodeViewController.swift
//  VisitorBook
//
//  Created by Praveen on 11/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class ExitCodeViewController: GatekeeperAllPageViewController {

    @IBOutlet weak var exitCodeText: DesignableUITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setBarButtonItem(withButtonImage: #imageLiteral(resourceName: "ThreeDotIcon"), withPosition: .RightDot, needAdjustMent: true)
    }

    @IBAction func SubmitButton_press(_ sender: Any) {
        
        
        
    }
    
    func ExitCodeApi(){
        showLoader()
        
        let param : [String : Any] = [
        "exit_code" : exitCodeText.text!
        ]
        
        PSServiceManager.CallVisitExit(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            
            if status{
                self.showAlertMessage(titleStr: "Success", messageStr: response!["msg"] as! String)
                self.exitCodeText.text = ""
                self.tabBarController?.selectedIndex = 0
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
            
        }
        
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
