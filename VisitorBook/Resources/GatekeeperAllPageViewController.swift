//
//  GatekeeperAllPageViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 03/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class GatekeeperAllPageViewController: AllPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func createDotView(){
        viewDot = DotViewMenu.init(frame: CGRect(x: (self.view.frame.width - 170), y: 50, width: 150, height: 150))
        
        viewDot?.dailySOS = {() in
            self.sosButtonPress()
        }
        viewDot?.passwordChange = {() in
            self.changePasswordButtonPress()
        }
        viewDot?.logout = {() in
            self.logoutButtonPress()
        }
        
    }
    
    @objc func sosButtonPress() {
        viewDot?.isHidden = true
        let dailySOSVC = self.storyboard?.instantiateViewController(withIdentifier: "DailySOSViewController") as! DailySOSViewController
        
        Push(controller: dailySOSVC)
    }
    
    @objc func changePasswordButtonPress() {
        viewDot?.isHidden = true
        let changePassword = self.storyboard?.instantiateViewController(withIdentifier: "PasswordChangeViewController") as! PasswordChangeViewController
        
        Push(controller: changePassword)
    }
    
    @objc func logoutButtonPress() {
        
        viewDot?.isHidden = true
        logoutGateKeeper()
    }
    
    func logoutGateKeeper(){
        
        showLoader()
        
        let param : [String : Any] = [
            "id" : (gateKeeperData?.id)!
        ]
        
        PSServiceManager.CallGuardLogout(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if(status){
                
                CommanFunction.instance.clearGateKeeperData()
                self.showAlertMessage(titleStr: "Success", messageStr: response!["msg"] as! String)
                AppIntializer.shared.moveToLoginScreen()
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
            
        }
    }
    
    
    
    @objc func BackToSelectedIndex() {
        
        
        if AppDelegate.sharedInstance.gateKeeperSelectedIndex == 1{
            let item : UITabBarItem = tabBarController!.tabBar.items![2]
            item.image = #imageLiteral(resourceName: "CenterRedIcon")
        }
        self.tabBarController?.selectedIndex = AppDelegate.sharedInstance.gateKeeperSelectedIndex
        
    }
    
    // MARK:- Set BarButton Item Button With Image
    func setBarButtonItem(withButtonImage: UIImage, withPosition: BarButtonType, needAdjustMent: Bool)
    {
        let btn1 = UIButton(type: .custom)
        
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        switch withPosition {
        case .RightDot:
            
            var imageView = UIImageView.init(frame: CGRect.init(x: 8, y: 0, width: 25, height: 30))
            
            if #available(iOS 11.0, *) {
                imageView = UIImageView.init(frame: CGRect.init(x: 8, y: -1, width: 25, height: 30))
            }
            
            imageView.image = withButtonImage
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 36))
            
            let btn1 = UIButton(type: .custom)
            btn1.frame = view.frame
            
            view.addSubview(imageView)
            view.addSubview(btn1)
            createDotView()
            UIApplication.shared.keyWindow?.addSubview(viewDot!)
            
            viewDot?.isHidden = true
            
            self.navigationItem.rightBarButtonItem = nil
            btn1.addTarget(self, action: #selector(rightNavigationButton), for: .touchUpInside)
            let barItem = UIBarButtonItem(customView: view)
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem = barItem
            break
            
        case .TabbarBack:
            
            var imageView = UIImageView.init(frame: CGRect.init(x: 8, y: 1, width: 25, height: 30))
            
            if #available(iOS 11.0, *) {
                imageView = UIImageView.init(frame: CGRect.init(x: 8, y: -1, width: 25, height: 30))
            }
            
            imageView.image = withButtonImage
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            let view = UIView.init(frame: CGRect.init(x: 0, y: 5, width: 35, height: 36))
            
            let btn1 = UIButton(type: .custom)
            btn1.frame = view.frame
            
            view.addSubview(imageView)
            view.addSubview(btn1)
            
            self.navigationItem.leftBarButtonItem = nil
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
            btn1.addTarget(self, action: #selector(BackToSelectedIndex), for: .touchUpInside)
            let barItem = UIBarButtonItem(customView: view)
            self.navigationController?.navigationBar.topItem?.leftBarButtonItem = barItem
            //            self.navigationController?.navigationBar.addSubview(view)
            //            self.navigationController?.navigationItem.setLeftBarButton(UIBarButtonItem(customView: view), animated: true)
            //            self.navigationController?.navigationBar.setItems([self.navigationItem], animated: false)
            break
            
        default:
            break
            
        }
        
    }
    
    @objc func rightNavigationButton() {
        
        if (viewDot?.isHidden)!{
            viewDot?.isHidden = false
        }else{
            viewDot?.isHidden = true
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
