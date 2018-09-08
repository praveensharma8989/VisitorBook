//
//  VisitorDetailsViewController.swift
//  VisitorBook
//
//  Created by Praveen on 07/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class VisitorDetailsViewController: AllPageViewController, UIImagePickerControllerDelegate {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var vahicleText: DesignableUITextField!
    @IBOutlet weak var companytext: DesignableUITextField!
    @IBOutlet weak var addressText: DesignableUITextField!
    @IBOutlet weak var emailText: DesignableUITextField!
    @IBOutlet weak var nameText: DesignableUITextField!
    @IBOutlet weak var mobileText: DesignableUITextField!
    
    var oldVisitorData : NewVisitorData?
    var gateKeeperData : VisitorUsers?
    
    var isImage : Bool = false
    let imagePickerView = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilize()
        // Do any additional setup after loading the view.
    }

    func initilize(){
        
        setBackBarButton(buttonType: .Home)
        imagePickerView.delegate = self
        if oldVisitorData?.msg == "Old Visitor"{
            userImage.set_sdWebImage(With: (oldVisitorData?.photo)!, placeHolderImage: "CameraImage")
            mobileText.isHidden = false
            mobileText.text = oldVisitorData?.mobile
            nameText.text = oldVisitorData?.name
            emailText.text = oldVisitorData?.email
            addressText.text = oldVisitorData?.address
            companytext.text = oldVisitorData?.company
            vahicleText.text = oldVisitorData?.vehicle
            isImage = true
        }else{
            mobileText.isHidden = false
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validation()-> Int{
        
        if (PSValidator.validateName(nameText.text) != 0)
        {
            return PSValidator.validateName(nameText.text)
        }
        if (PSValidator.validateEmail(Email : emailText.text) != 0)
        {
            return PSValidator.validateEmail(Email : emailText.text)
        }
        return 0
    }
    
    
    @IBAction func sendButton_press(_ sender: Any) {
        self.view.endEditing(true)
        let code = validation()
        
        if(code != 0){
            
            print(code)
            let str:String = PSValidator.message(forCode: code)
            self.showAlertMessage(titleStr: "Error", messageStr: str)
        }else if !isImage{
            self.showAlertMessage(titleStr: "Error", messageStr: "Please Upload Image!")
        }
        else{
            SendVisitorDetail()
            
        }
        
    }
    
    func SendVisitorDetail(){
        
        view.endEditing(true)
        showLoader()
        
        var param : [String : Any]
        
        param = [
            "cid": (gateKeeperData?.cid)!,
            "name": (nameText.text)!,
            "mobile": (oldVisitorData?.mobile)!,
            "email": (emailText.text)!,
            "vehicle" : (vahicleText.text)!,
            "address" : (addressText.text)!,
            "empid" : (gateKeeperData?.id)!,
            "company" : (companytext.text)!
        ]
        
        PSServiceManager.newVisitor(param: param, imageData: UIImagePNGRepresentation(userImage.image!)!) { (response, status, error) -> (Void) in
            self.dismissLoader()
            
            if(status){
                
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
//                self.userData = try? jsonDecoder.decode(VisitorUsers.self, from: jsonData!)
                self.MoveToTowerAndPurposeScreen()
                
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
            
        }
        
    }
    
    func MoveToTowerAndPurposeScreen(){
        
        let TowerAndPurposeVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectTowerAndPusposeViewController") as! SelectTowerAndPusposeViewController
        TowerAndPurposeVC.newVisitorData = oldVisitorData
        TowerAndPurposeVC.gateKeeperData = gateKeeperData
        Push(controller: TowerAndPurposeVC)
        
    }
    
    
    @IBAction func imageButton_press(_ sender: Any) {
        
        imagePickerView.allowsEditing = false
        let actionsheet = UIAlertController(title: "Photo Source", message: "Choose A Sourece", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction)in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.imagePickerView.sourceType = .camera
                self.present(self.imagePickerView, animated: true, completion: nil)
            }else
            {
                print("Camera is Not Available")
            }
        }))
        actionsheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction)in
            self.imagePickerView.sourceType = .photoLibrary
            self.present(self.imagePickerView, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionsheet,animated: true, completion: nil)
        
//        present(imagePickerView, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        userImage.image = image
        isImage = true
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:  true, completion: nil)
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
