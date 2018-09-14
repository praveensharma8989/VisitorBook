//
//  SelectTowerAndPusposeViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 08/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

enum pickerType : Int {
    case Tower = 0
    case floor
    case flat
    case purpose
    case None
}

class SelectTowerAndPusposeViewController: AllPageViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var purposeText: DesignableUITextField!
    @IBOutlet weak var flateText: DesignableUITextField!
    @IBOutlet weak var floorText: DesignableUITextField!
    @IBOutlet weak var towerText: DesignableUITextField!
    
    var towerId : String?
    var flateId : String?
    var floorId : String?
    var purposeId : String?
    var tempTowerId : String?
    var tempFlateId : String?
    var tempFloorId : String?
    var tempPurposeId : String?
    var towerIndex : Int = 0
    var flateIndex : Int = 0
    var floorIndex : Int = 0
    var purposeIndex : Int = 0
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var toolbarView: UIToolbar!
    
    var newVisitorData : NewVisitorData?
    var newId : String?
    
    var towerData : TowerData?
    var floorData : FloorData?
    var flateData : FlateData?
    var purposeData : PurposeData?
    
    var PickerType : pickerType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initilize()
        
        // Do any additional setup after loading the view.
    }

    
    func initilize(){
        
        callTower()
        setBackBarButton(buttonType: .Defauld)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.isHidden = true
        toolbarView.isHidden = true
        pickerView.showsSelectionIndicator = false
        PickerType = .None
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func towerButton_press(_ sender: Any) {
        
        guard towerData != nil else{
            showAlertMessage(titleStr: "Error", messageStr: "No tower!")
            return
        }
        guard (towerData?.tower.count)! > 0 else{
            showAlertMessage(titleStr: "Error", messageStr: "No tower!")
            return
        }
        self.PickerType = .Tower
        pickerView.reloadAllComponents()
        pickerView.selectRow(towerIndex, inComponent: 0, animated: false)
        pickerView.isHidden = false
        toolbarView.isHidden = false
        
        
    }
    
    @IBAction func floorButton_press(_ sender: Any) {
        guard floorData != nil else{
            showAlertMessage(titleStr: "Error", messageStr: "Please select tower first!")
            return
        }
        guard (floorData?.floor.count)! > 0 else{
            showAlertMessage(titleStr: "Error", messageStr: "No floor!")
            return
        }
        self.PickerType = .floor
        pickerView.reloadAllComponents()
        pickerView.selectRow(floorIndex, inComponent: 0, animated: false)
        pickerView.isHidden = false
        toolbarView.isHidden = false
    }
    
    @IBAction func flateButton_press(_ sender: Any) {
        guard flateData != nil else{
            showAlertMessage(titleStr: "Error", messageStr: "Please select floor first!")
            return
        }
        guard (flateData?.flat.count)! > 0 else{
            showAlertMessage(titleStr: "Error", messageStr: "No flat!")
            return
        }
        self.PickerType = .flat
        pickerView.reloadAllComponents()
        pickerView.selectRow(flateIndex, inComponent: 0, animated: false)
        pickerView.isHidden = false
        toolbarView.isHidden = false
    }
    
    @IBAction func purposeButton_press(_ sender: Any) {
        
        guard purposeData != nil else{
            showAlertMessage(titleStr: "Error", messageStr: "No flat!")
            return
        }
        self.PickerType = .purpose
        pickerView.reloadAllComponents()
        pickerView.selectRow(purposeIndex, inComponent: 0, animated: false)
        pickerView.isHidden = false
        toolbarView.isHidden = false
    }

    @IBAction func submitButton_press(_ sender: Any) {
        
        let code = validate()
        
        if(code != 0){
            
            print(code)
            let str:String = PSValidator.message(forCode: code)
            self.showAlertMessage(titleStr: "Error", messageStr: str)
        }
        else{
            callUpdateVisitor()
        }
        
    }
    
    func validate()->Int{
        
        if (PSValidator.isTowerSelected(str: towerId)) != 0 {
            return PSValidator.isTowerSelected(str: towerId)
        }
        if (PSValidator.isFloorSelected(str: floorId)) != 0 {
            return PSValidator.isTowerSelected(str: floorId)
        }
        if (PSValidator.isFlatSelected(str: flateId)) != 0 {
            return PSValidator.isTowerSelected(str: flateId)
        }
        if (PSValidator.isPurposeSelected(str: purposeText.text)) != 0 {
            return PSValidator.isTowerSelected(str: purposeText.text)
        }
        return 0
    }
    
    func callTower(){
        
        showLoader()
        
        let param : [String : Any] = [
            "cid": (gateKeeperData?.cid)!
        ]
        
        
        
        PSServiceManager.CallAllTower(param: param) { (response, status, error) -> (Void) in
            
            if(status){
                
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.towerData = try? jsonDecoder.decode(TowerData.self, from: jsonData!)
                
                self.callPurpose()
                
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
            
        }
        
        
    }
    
    func callFloor(){
        
        showLoader()
        
        let param : [String : Any] = [
            "tower_id": (towerId)!
        ]
        
        PSServiceManager.CallAllFloor(param: param) { (response, status, error) -> (Void) in
            
            self.dismissLoader()
            
            if(status){
                
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.floorData = try? jsonDecoder.decode(FloorData.self, from: jsonData!)
                
                
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
            
        }
        
    }
    
    func callFlat(){
        
        showLoader()
        
        let param : [String : Any] = [
            "tower_id": (towerId)!,
            "floor_id": (floorId)!
        ]
        
        PSServiceManager.CallAllFlat(param: param) { (response, status, error) -> (Void) in
            
            self.dismissLoader()
            
            if(status){
                
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.flateData = try? jsonDecoder.decode(FlateData.self, from: jsonData!)
                
                
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
            
        }
        
    }
    
    func callPurpose(){
        
        showLoader()
        
        let param : [String : Any] = [
            "id": (gateKeeperData?.cid)!
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
    
    func callUpdateVisitor(){
        
        showLoader()
        
        let param : [String : Any] = [
            "id": newId!,
            "tower" : towerId!,
            "floors" : floorId!,
            "flats" : flateId!,
            "meet_purpose" : (purposeText.text)!
        ]
        
        PSServiceManager.CallUpdateVisitor(param: param) { (response, status, error) -> (Void) in
            
            self.dismissLoader()
            
            if(status){
                
//                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
//                let jsonDecoder = JSONDecoder()
                
                self.PopToRoot()
                
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch PickerType {
        case .Tower:
            return (towerData?.tower.count)!
        case .floor:
            return (floorData?.floor.count)!
        case .flat:
            return (flateData?.flat.count)!
        case .purpose:
            return (purposeData?.purpose.count)!
        default:
            return 0
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch PickerType {
        case .Tower:
            return towerData?.tower[row].towerName
        case .floor:
            return floorData?.floor[row].floor
        case .flat:
            return flateData?.flat[row].flat
        case .purpose:
            return purposeData?.purpose[row].purpose
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch PickerType {
        case .Tower:
            towerText.text = towerData?.tower[row].towerName
            towerId = towerData?.tower[row].id
            towerIndex = row
            pickerView.resignFirstResponder()
        case .floor:
            floorText.text = floorData?.floor[row].floor
            floorId = floorData?.floor[row].id
            floorIndex = row
            pickerView.resignFirstResponder()
        case .flat:
            flateText.text = flateData?.flat[row].flat
            flateId = flateData?.flat[row].id
            flateIndex = row
            pickerView.resignFirstResponder()
        case .purpose:
            purposeText.text = purposeData?.purpose[row].purpose
            purposeId = purposeData?.purpose[row].id
            purposeIndex = row
            pickerView.resignFirstResponder()
        default:
            break
        }
    }
    
    @IBAction func toolbarDone_press(_ sender: Any) {
        
        toolbarView.isHidden = true
        pickerView.isHidden = true
        
        switch PickerType {
        case .Tower:
            if towerId == nil{
                towerId = towerData?.tower[0].id
                towerText.text = towerData?.tower[0].towerName
                towerIndex = 0
            }
            floorIndex = 0
            flateIndex = 0
            tempTowerId = towerId
            floorData = nil
            floorText.text = ""
            floorId = nil
            flateData = nil
            flateText.text = ""
            flateId = nil
            callFloor()
        case .floor:
            if floorId == nil{
                floorId = floorData?.floor[0].id
                floorText.text = floorData?.floor[0].floor
                floorIndex = 0
            }
            flateIndex = 0
            tempFloorId = floorId
            flateData = nil
            flateText.text = ""
            flateId = nil
            callFlat()
        case .flat:
            if flateId == nil{
                flateId = flateData?.flat[0].id
                flateText.text = flateData?.flat[0].flat
                flateIndex = 0
            }
            tempFlateId = flateId
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
    
    
    @IBAction func toobarCancel_press(_ sender: Any) {
        
        toolbarView.isHidden = true
        pickerView.isHidden = true
        
        switch PickerType {
        case .Tower:
            towerId = tempTowerId
        case .floor:
            floorId = tempFloorId
        case .flat:
            flateId = tempFlateId
        case .purpose:
            purposeId = tempPurposeId
        default:
            break
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
