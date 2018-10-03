//
//  EditProfileResidentViewController.swift
//  VisitorBook
//
//  Created by Praveen on 27/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class EditProfileResidentViewController: ResidentAllPageViewController, UIImagePickerControllerDelegate {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: DesignableUITextField!
    @IBOutlet weak var userPhone: DesignableUITextField!
    @IBOutlet weak var userEmail: DesignableUITextField!
    @IBOutlet weak var userAddress: DesignableUITextField!
    @IBOutlet weak var userDOB: DesignableUITextField!
    @IBOutlet weak var userGender: DesignableUITextField!
    
    var residentFlatProfileData : FlateProfileData?
    let imagePickerView = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()

        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        setBackBarButton(buttonType: .Defauld)
        imagePickerView.delegate = self
        setData()
    }
    
    func setData(){
        
        userImage.set_sdWebImage(With: (residentFlatProfileData?.photo)!, placeHolderImage: "userIcon")
        userName.text = residentFlatProfileData?.name
        userPhone.text = residentFlatProfileData?.mobile
        userEmail.text = residentFlatProfileData?.email
        userAddress.text = residentFlatProfileData?.address
        userDOB.text = residentFlatProfileData?.age
        userGender.text = residentFlatProfileData?.gender
        
    }
    
    @IBAction func submitButton_press(_ sender: Any) {
    }
    
    @IBAction func imageChangeButton_press(_ sender: Any) {
        
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
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        userImage.image = image.resized(toWidth: 200)
        
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:  true, completion: nil)
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


