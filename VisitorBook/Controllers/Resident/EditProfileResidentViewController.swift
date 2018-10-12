//
//  EditProfileResidentViewController.swift
//  VisitorBook
//
//  Created by Praveen on 27/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class EditProfileResidentViewController: ResidentAllPageViewController, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: DesignableUITextField!
    @IBOutlet weak var userPhone: DesignableUITextField!
    @IBOutlet weak var userEmail: DesignableUITextField!
    @IBOutlet weak var userAddress: DesignableUITextField!
    @IBOutlet weak var userDOB: DesignableUITextField!
    @IBOutlet weak var userGender: DesignableUITextField!
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var genderPickerView: UIPickerView!
    @IBOutlet weak var toolBarView: UIToolbar!
    
    var isImageChange : Bool = false
    let genderArray : [String] = ["Male", "Female", "Other"]
    var isDatePicker : Bool = false
    var residentFlatProfileData : FlateProfileData?
    let imagePickerView = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()

        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        setBackBarButton(buttonType: .Defauld)
        setNavigationTitle(With: "Edit Profile", type: .white)
        imagePickerView.delegate = self
        datePickerView.isHidden = true
        genderPickerView.isHidden = true
        datePickerView.maximumDate = Date()
        toolBarView.isHidden = true
        
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
    
    @IBAction func userGenderButton_press(_ sender: Any) {
        
        isDatePicker = false
        genderPickerView.isHidden = false
        toolBarView.isHidden = false
        
    }
    @IBAction func userDOBButton_press(_ sender: Any) {
        isDatePicker = true
        datePickerView.isHidden = false
        toolBarView.isHidden = false
    }
    @IBAction func submitButton_press(_ sender: Any) {
        
        self.view.endEditing(true)
        
        let code = validate()
        
        if(code != 0){
            
            print(code)
            let str:String = PSValidator.message(forCode: code)
            self.showAlertMessage(titleStr: "Error", messageStr: str)
        }
        else{
            CallUpdateProfile()
        }
        
    }
    
    func validate()->Int{
        
        
        return 0
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
        
        isImageChange = true
        userImage.image = image.resized(toWidth: 200)
        
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:  true, completion: nil)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return genderArray.count
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return genderArray[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        userGender.text = genderArray[row]
        pickerView.resignFirstResponder()
        
    }

    @IBAction func toolbarDone_press(_ sender: Any) {
        
        toolBarView.isHidden = true
        genderPickerView.isHidden = true
        datePickerView.isHidden = true
        
        if isDatePicker{
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "MM-dd-yyyy"
            
            userDOB.text = dateFormat.string(from: datePickerView.date)
            
        }else{
            
            userGender.text = genderArray[0]
            
        }
        
        
    }
    
    
    @IBAction func toobarCancel_press(_ sender: Any) {
        
        toolBarView.isHidden = true
        genderPickerView.isHidden = true
        datePickerView.isHidden = true

    }
    
    func CallUpdateProfile(){
        
        view.endEditing(true)
        showLoader()
        
        var param : [String : Any]
        
        param = [
            "id": (residentData?.id)!,
            "name": (userName.text)!,
            "mobile": (userPhone.text)!,
            "email": (userEmail.text)!,
            "gender" : (userGender.text)!,
            "address" : (userAddress.text)!,
            "age" : (userDOB.text)!,
            "sticker_no" : "",
            "vehicle_no" : ""
        ]
        
        PSServiceManager.CallUpdateFlatUser(param: param, imageData: isImageChange ? UIImagePNGRepresentation(userImage.image!) : nil) { (response, status, error) -> (Void) in
            self.dismissLoader()
            
            if(status){
                
                self.showAlertMessage(titleStr: "Success", messageStr: response!["msg"] as! String)
                self.PopBack()
                //                self.userData = try? jsonDecoder.decode(VisitorUsers.self, from: jsonData!)
                
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


