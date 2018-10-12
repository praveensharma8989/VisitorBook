//
//  feedComplaintViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 06/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class feedComplaintViewController: ResidentAllPageViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate {
    @IBOutlet weak var complaintPriorityText: UITextField!
    @IBOutlet weak var complaintCategoryText: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var attechPic: UIImageView!
    
    @IBOutlet weak var toolBarView: UIToolbar!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var isPriority : Bool = false
    var priorityIndex : Int = 0
    var categoryIndex : Int = 0
    
    var isImage : Bool = false
    let imagePickerView = UIImagePickerController()
    
    var categoryList : CategoryList? = nil
    let priorityList : [String] = ["Low", "Medium", "High"]
    override func viewDidLoad() {
        super.viewDidLoad()

        initilize()
        
        
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        setBackBarButton(buttonType: .Defauld)
        setNavigationTitle(With: "Feed Complaint", type: .white)
        pickerView.delegate = self
        pickerView.dataSource = self
        toolBarView.isHidden = true
        pickerView.isHidden = true
        imagePickerView.delegate = self
        CallComplainCat()
    }
    
    @IBAction func ComplaintPriorityButton_press(_ sender: Any) {
        
        isPriority = true
        pickerView.reloadAllComponents()
        pickerView.selectRow(priorityIndex, inComponent: 0, animated: false)
        pickerView.isHidden = false
        toolBarView.isHidden = false
    }
    
    @IBAction func ComplaintCategoryButton_press(_ sender: Any) {
        
        isPriority = false
        pickerView.reloadAllComponents()
        pickerView.selectRow(categoryIndex, inComponent: 0, animated: false)
        pickerView.isHidden = false
        toolBarView.isHidden = false
        
    }
    @IBAction func attechImagePickerButton_press(_ sender: Any) {
        
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
        
        attechPic.image = image.resized(toWidth: 200)
        isImage = true
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:  true, completion: nil)
    }
    
    
    @IBAction func submitButtonClick(_ sender: Any) {
        
        if validate(){
            callSendComplain()
        }
        
    }
    
    func validate() ->Bool {
        
        if (PSValidator.validateSelectValue(complaintPriorityText.text)) != 0{
            
            let message = PSValidator.messageWithString(forCode: PSValidator.validateSelectValue(complaintPriorityText.text), str: "Complaint Priority")
            self.showAlertMessage(titleStr: "Error", messageStr: message)
            return false
        }
        
        if (PSValidator.validateSelectValue(complaintCategoryText.text)) != 0{
            
            let message = PSValidator.messageWithString(forCode: PSValidator.validateSelectValue(complaintCategoryText.text), str: "Complaint Category")
            self.showAlertMessage(titleStr: "Error", messageStr: message)
            return false
        }
        
        if (PSValidator.validateEnterValue(descriptionTextView.text)) != 0{
            
            let message = PSValidator.messageWithString(forCode: PSValidator.validateEnterValue(descriptionTextView.text), str: "Description")
            self.showAlertMessage(titleStr: "Error", messageStr: message)
            return false
        }
        
        return true
    }
    
    @IBAction func toolBarDone_click(_ sender: Any) {
        toolBarView.isHidden = true
        pickerView.isHidden = true
        
        if isPriority{
            if priorityIndex == 0{
                complaintPriorityText.text = priorityList[0]
            }
        }else{
            if categoryIndex == 0{
                complaintCategoryText.text = categoryList?.category[0].category
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return isPriority ? priorityList.count : categoryList != nil ? (categoryList?.category.count)! : 0
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return isPriority ? priorityList[row] : categoryList?.category[row].category
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if isPriority{
            complaintPriorityText.text = priorityList[row]
            priorityIndex = row
            pickerView.resignFirstResponder()
        }else{
            complaintCategoryText.text = categoryList?.category[row].category
            categoryIndex = row
            pickerView.resignFirstResponder()
        }
    }
    
    
    func callSendComplain(){
        
        showLoader()
        
        let param : [String : Any] = [
            "id": (residentData?.id)!,
            "subject" : (complaintCategoryText.text)!,
            "message" : (descriptionTextView.text)!,
            "priority" : (complaintPriorityText.text)!
            
        ]
        
        PSServiceManager.CallSendComplain(param: param, imageData: isImage ? UIImagePNGRepresentation(attechPic.image!) : nil) { (response, status, error) -> (Void) in
            
            self.dismissLoader()
            
            if(status){
                
                self.showAlertMessage(titleStr: "Success", messageStr: response!["msg"] as! String)
                self.PopBack()
                
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
            
        }
        
    }
    
    func CallComplainCat(){
        
        showLoader()
        
        let param : [String : Any] = [
            "id": (residentData?.cid)!
        ]
        
        PSServiceManager.CallComplainCat(param: param) { (response, status, error) -> (Void) in
            
            self.dismissLoader()
            
            if(status){
                
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.categoryList = try? jsonDecoder.decode(CategoryList.self, from: jsonData!)
                
                
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
