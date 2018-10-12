//
//  QRCodeScannerViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 05/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import AVFoundation
import QRCodeReader
import MIBlurPopup

class QRCodeScannerViewController: GatekeeperAllPageViewController, QRCodeReaderViewControllerDelegate {
    
    lazy var reader: QRCodeReader = QRCodeReader()
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader                  = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            $0.showTorchButton         = true
            $0.preferredStatusBarStyle = .lightContent
            
            $0.reader.stopScanningWhenCodeIsFound = false
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    // MARK: - Actions
    
    private func checkScanPermissions() -> Bool {
        do {
            return try QRCodeReader.supportsMetadataObjectTypes()
        } catch let error as NSError {
            let alert: UIAlertController
            
            switch error.code {
            case -11852:
                alert = UIAlertController(title: "Error", message: "This app is not authorized to use Back Camera.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (_) in
                    DispatchQueue.main.async {
                        if let settingsURL = URL(string: UIApplicationOpenSettingsURLString) {
                            UIApplication.shared.open(settingsURL, options: [:], completionHandler: { (status) in
                                
                            })
//                            UIApplication.shared.openURL(settingsURL)
                        }
                    }
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            default:
                alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            }
            
            present(alert, animated: true, completion: nil)
            
            return false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initilize()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !AppDelegate.sharedInstance.isScannerApear{
            scanQR()
        }
        
    }
    
    func initilize(){
        
        
    }
    
    func scanQR(){
        guard checkScanPermissions() else { return }
        
        readerVC.modalPresentationStyle = .formSheet
        readerVC.delegate               = self
        
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            if let result = result {
                print("Completion with result: \(result.value) of type \(result.metadataType)")
            }
        }
        
        AppDelegate.sharedInstance.isScannerApear = true
        
        present(readerVC, animated: true, completion: nil)
    }
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        
        reader.stopScanning()
        
        dismiss(animated: true, completion: {
            if AppDelegate.sharedInstance.gateKeeperSelectedIndex == 0{
                self.CallStaffVarify(id: result.value)
            }else{
                self.CallStaffLogout(id: result.value)
            }
        })
        
        
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            AppDelegate.sharedInstance.isScannerApear = false
        }
        BackToSelectedIndex()
        
    }
    
    func CallStaffLogout(id: String){
        
        showLoader()
        
        let param : [String : Any]  = [
            "id": id
        ]
        
        PSServiceManager.CallStaffLogout(param: param) { (response, status, error) -> (Void) in
            
            self.dismissLoader()
            
            if(status){
                
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                let qRLoginData = try? jsonDecoder.decode(QRLoginData.self, from: jsonData!)
                
                let popUp = QRVerifyPopupViewController.init(nibName: "QRVerifyPopupViewController", bundle: nil)
                popUp.qRLoginData = qRLoginData
                popUp.isEntered = AppDelegate.sharedInstance.gateKeeperSelectedIndex == 0 ? true : false
                popUp.visitorPopupClick = {() in
                    
//                    AppDelegate.sharedInstance.isScannerApear = true
                    
//                    self.PopBack()
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        AppDelegate.sharedInstance.isScannerApear = false
                        self.BackToSelectedIndex()
//                    })
                    
                }
                MIBlurPopup.show(popUp, on: self)
                
            }else{
                self.BackToSelectedIndex()
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
            
        }
        
    }
    
    func CallStaffVarify(id: String){
        
        showLoader()
        
        let param : [String : Any]  = [
            "id": id,
            "empid" : (gateKeeperData?.id)!
        ]
        
        PSServiceManager.CallStaffVerify(param: param) { (response, status, error) -> (Void) in
            
            AppDelegate.sharedInstance.isScannerApear = false
            
            self.dismissLoader()
            
            if(status){
                
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                let qREntryData = try? jsonDecoder.decode(QREntryData.self, from: jsonData!)
                
                let QRVarifyOTPVC = self.storyboard?.instantiateViewController(withIdentifier: "QRVarifyOTPViewController") as! QRVarifyOTPViewController
                
                QRVarifyOTPVC.qREntryData = qREntryData
                QRVarifyOTPVC.isEntered = AppDelegate.sharedInstance.gateKeeperSelectedIndex == 0 ? true : false
                QRVarifyOTPVC.varifyOTPBACK = {(status) in
                    
                    self.PopBack()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        AppDelegate.sharedInstance.isScannerApear = false
                        self.BackToSelectedIndex()
                    })
                }
                
                self.Push(controller: QRVarifyOTPVC)
                
            }else{
                self.BackToSelectedIndex()
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
