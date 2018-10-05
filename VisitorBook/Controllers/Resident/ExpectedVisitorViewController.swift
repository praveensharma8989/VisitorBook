//
//  ExpectedVisitorViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 03/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit


enum ExpectedVisitorPickerType : Int {
    case validity = 0
    case purpose
    case startDate
    case endDate
    case None
}

class ExpectedVisitorViewController: ResidentAllPageViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var validityVisitorText: DesignableUITextField!
    @IBOutlet weak var purposeText: DesignableUITextField!
    @IBOutlet weak var visitorText: DesignableUITextField!
    @IBOutlet weak var visitorMobileText: DesignableUITextField!
    
    @IBOutlet weak var startDateText: DesignableUITextField!
    @IBOutlet weak var endDateText: DesignableUITextField!
    
    
    @IBOutlet weak var viewSection: UIView!
    @IBOutlet weak var pickerToolbar: UIToolbar!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    var isDatePicker : Bool = false
    var isStartDate : Bool = false
    var purposeData : PurposeData?
    
    var expectedVisitorPickerType : ExpectedVisitorPickerType = .None
    var purposeId : String?
    var tempPurposeId : String?
    let validityArray : [String] = ["One Time", "7 Days", "30 Days", "Customize"]
    let validityIndexArray : [String] = ["1", "7", "30", "0"]
    var validityVisitorIndex : Int = 0
    var purposeIndex : Int = 0
    
    var startDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initilize()
        
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        callPurpose()
        setBackBarButton(buttonType: .DefaultHome)
        viewSection.isHidden = true
        pickerView.isHidden = true
        pickerToolbar.isHidden = true
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = false
        datePickerView.isHidden = true
        datePickerView.backgroundColor = UIColor.white
        datePickerView.datePickerMode = .dateAndTime
        
    }
    
    
    @IBAction func validityButton_press(_ sender: Any) {
        
        isDatePicker = false
        expectedVisitorPickerType = .validity
        pickerView.reloadAllComponents()
        pickerView.selectRow(validityVisitorIndex, inComponent: 0, animated: false)
        pickerView.isHidden = false
        pickerToolbar.isHidden = false
        
    }
    @IBAction func purposeDropButton_press(_ sender: Any) {
        
        isDatePicker = false
        guard purposeData != nil else{
            showAlertMessage(titleStr: "Error", messageStr: "No Purpose!")
            return
        }
        expectedVisitorPickerType = .purpose
        pickerView.reloadAllComponents()
        pickerView.selectRow(purposeIndex, inComponent: 0, animated: false)
        pickerView.isHidden = false
        pickerToolbar.isHidden = false
        
    }
    
    @IBAction func startDateButton_press(_ sender: Any) {
        
        isDatePicker = true
        isStartDate = true
        datePickerView.minimumDate = startDate
        datePickerView.isHidden = false
        pickerToolbar.isHidden = false
        
    }
    
    @IBAction func endDateButton_press(_ sender: Any) {
        
        if startDateText.text == ""{
            showAlertMessage(titleStr: "Error", messageStr: "Please select start date first")
        }else{
            isDatePicker = true
            isStartDate = false
            datePickerView.minimumDate = startDate
            datePickerView.isHidden = false
            pickerToolbar.isHidden = false
        }
        
    }
    
    @IBAction func submitButton_press(_ sender: Any) {
        
        if validate(){
            callSubmitData()
        }
        
    }
    
    
    func validate() ->Bool {
        
        if (PSValidator.validateSelectValue(validityVisitorText.text)) != 0{
            
            let message = PSValidator.messageWithString(forCode: PSValidator.validateSelectValue(validityVisitorText.text), str: "Expected validity")
            self.showAlertMessage(titleStr: "Error", messageStr: message)
            return false
        }else if validityVisitorText.text == "Customize"{
            if (PSValidator.validateSelectValue(startDateText.text)) != 0{
                
                let message = PSValidator.messageWithString(forCode: PSValidator.validateSelectValue(startDateText.text), str: "start date")
                self.showAlertMessage(titleStr: "Error", messageStr: message)
                return false
            }
            if (PSValidator.validateSelectValue(endDateText.text)) != 0{
                let message = PSValidator.messageWithString(forCode: PSValidator.validateSelectValue(endDateText.text), str: "end date")
                self.showAlertMessage(titleStr: "Error", messageStr: message)
                return false
            }
        }
        
        if (PSValidator.validateSelectValue(purposeText.text)) != 0{
            
            let message = PSValidator.messageWithString(forCode: PSValidator.validateSelectValue(purposeText.text), str: "Purpose")
            self.showAlertMessage(titleStr: "Error", messageStr: message)
            return false
        }
        
        if (PSValidator.validateEnterValue(visitorText.text)) != 0{
            
            let message = PSValidator.messageWithString(forCode: PSValidator.validateEnterValue(visitorText.text), str: "name")
            self.showAlertMessage(titleStr: "Error", messageStr: message)
            return false
        }
        
        if (PSValidator.validateMobile(Mobile: visitorMobileText.text)) != 0{
            
            let message = PSValidator.message(forCode: PSValidator.validateEnterValue(visitorMobileText.text))
            self.showAlertMessage(titleStr: "Error", messageStr: message)
            return false
        }
        
        return true
    }
    
    
    @IBAction func viewAllVisitorButton_press(_ sender: Any) {
        
        let ExpectedVisitorListVC = self.storyboard?.instantiateViewController(withIdentifier: "ExpectedVisitorListViewController") as! ExpectedVisitorListViewController
        Push(controller: ExpectedVisitorListVC)
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch expectedVisitorPickerType {
        case .validity:
            return validityArray.count
        case .purpose:
            return (purposeData?.purpose.count)!
        case .startDate:
            return 0
        case .endDate:
            return 0
        default:
            return 0
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch expectedVisitorPickerType {
        case .validity:
            return validityArray[row]
        case .purpose:
            return purposeData?.purpose[row].purpose
        case .startDate:
            return ""
        case .endDate:
            return ""
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch expectedVisitorPickerType {
        case .validity:
            validityVisitorText.text = validityArray[row]
            validityVisitorIndex = row
            pickerView.resignFirstResponder()
        case .purpose:
            purposeText.text = purposeData?.purpose[row].purpose
            purposeId = purposeData?.purpose[row].id
            purposeIndex = row
            pickerView.resignFirstResponder()
        case .startDate:
//            flateText.text = flateData?.flat[row].flat
//            flateId = flateData?.flat[row].id
//            flateIndex = row
            pickerView.resignFirstResponder()
        case .endDate:
//            purposeText.text = purposeData?.purpose[row].purpose
//            purposeId = purposeData?.purpose[row].id
//            purposeIndex = row
            pickerView.resignFirstResponder()
        default:
            break
        }
    }
    
    
    @IBAction func toolbarDone_press(_ sender: Any) {
        
        pickerToolbar.isHidden = true
        pickerView.isHidden = true
        datePickerView.isHidden = true
        
        if isDatePicker{
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "dd/MM/yyyy hh:mm a"
            
            if isStartDate{
                startDate = datePickerView.date
                startDateText.text = dateFormat.string(from: startDate)
            }else{
                endDateText.text = dateFormat.string(from: datePickerView.date)
            }
        }else{
            switch expectedVisitorPickerType {
            case .validity:
                
                if validityVisitorIndex == 0{
                    validityVisitorText.text = validityArray[0]
                }
                if validityVisitorText.text == "Customize"{
                    viewSection.isHidden = false
                }else{
                    viewSection.isHidden = true
                }
                
            case .purpose:
                if purposeId == nil{
                    purposeId = purposeData?.purpose[0].id
                    purposeText.text = purposeData?.purpose[0].purpose
                    purposeIndex = 0
                }
                tempPurposeId = purposeId
            default:
                break
            }
        }
        
        
        
    }
    
    
    @IBAction func toobarCancel_press(_ sender: Any) {

        pickerToolbar.isHidden = true
        pickerView.isHidden = true
        datePickerView.isHidden = true

        switch expectedVisitorPickerType {
        case .validity:
            
            if validityVisitorText.text == "Customize"{
                viewSection.isHidden = false
            }else{
                viewSection.isHidden = true
            }

        case .purpose:
            purposeId = tempPurposeId
            
        default:
            break
        }


    }
    

    func callPurpose(){
        
        showLoader()
        
        let param : [String : Any] = [
            "id": (residentData?.cid)!
        ]
        
        PSServiceManager.CallAllPurpose(param: param) { (response, status, error) -> (Void) in
            
            self.dismissLoader()
            
            if(status){
                
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.purposeData = try? jsonDecoder.decode(PurposeData.self, from: jsonData!)
                
                
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
            
        }
        
    }
    
    func callSubmitData(){
        
        showLoader()
        
        let param : [String : Any] = [
            "uid" : (residentData?.id)!,
            "name" : (visitorText.text)!,
            "mobile" : (visitorMobileText.text)!,
            "purpose" : (purposeText.text)!,
            "valid_for" : validityVisitorText.text == "Customize" ? (startDateText.text! + "|" + endDateText.text!) : validityIndexArray[validityVisitorIndex]
        ]
        
        PSServiceManager.CallCreateExpectedVisitor(param: param) { (response, status, error) -> (Void) in
            
            self.dismissLoader()
            
            if(status){
                
                self.showAlertMessage(titleStr: "Success", messageStr: response!["msg"] as! String)
                
                let ExpectedVisitorListVC = self.storyboard?.instantiateViewController(withIdentifier: "ExpectedVisitorListViewController") as! ExpectedVisitorListViewController
                self.Push(controller: ExpectedVisitorListVC)
                
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
