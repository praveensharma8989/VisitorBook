//
//  AllPageViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 05/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

public class AllPageViewController: UIViewController, UINavigationControllerDelegate {

    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBackBarButton() {
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        btn.addTarget(self, action: #selector(BackButtonClicked), for: .touchUpInside)
       
        btn.setImage(#imageLiteral(resourceName: "backButton"), for: .normal)
        
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: btn), animated: true)
    }
    
    @objc func BackButtonClicked() {
        PopBack()
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
