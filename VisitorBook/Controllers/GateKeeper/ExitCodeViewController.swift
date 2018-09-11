//
//  ExitCodeViewController.swift
//  VisitorBook
//
//  Created by Praveen on 11/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class ExitCodeViewController: UIViewController {

    @IBOutlet weak var exitCodeText: DesignableUITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func SubmitButton_press(_ sender: Any) {
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
