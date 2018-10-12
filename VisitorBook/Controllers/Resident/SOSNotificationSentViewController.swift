//
//  SOSNotificationSentViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 12/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import MIBlurPopup
import MapKit

class SOSNotificationSentViewController: ResidentAllPageViewController, SlideButtonDelegate, CLLocationManagerDelegate {
    
    

    @IBOutlet weak var medicalEmergencyButton: MMSlidingButton!
    @IBOutlet weak var fireEmergencyButton: MMSlidingButton!
    @IBOutlet weak var theftEmergencyButton: MMSlidingButton!
    @IBOutlet weak var accidentEmergencyButton: MMSlidingButton!
    @IBOutlet weak var otherEmergencyButton: MMSlidingButton!
    
    var lat : Double? = nil
    var long : Double? = nil
    var address : String = ""
    
    var residentDashboardData: ResidentDashboardData?
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        setBackBarButton(buttonType: .Defauld)
        setNavigationTitle(With: "Select SOS Type", type: .white)
        medicalEmergencyButton.delegate = self
        fireEmergencyButton.delegate = self
        theftEmergencyButton.delegate = self
        accidentEmergencyButton.delegate = self
        otherEmergencyButton.delegate = self
        residentDashboardData = CommanFunction.instance.getUserDataResidentDashBoard()
        locationManager.requestAlwaysAuthorization()
        
        // For use when the app is open
        //locationManager.requestWhenInUseAuthorization()
        
        // If location services is enabled get the users location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // You can change the locaiton accuary here.
            locationManager.startUpdatingLocation()
        }
    }
    
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = pdblLatitude
        //21.228124
        let lon: Double = pdblLongitude
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    self.address = addressString
                    print(addressString)
                }
        })
        
    }
    
    // Print out the location to the console
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            lat = location.coordinate.latitude
            long = location.coordinate.longitude
            
            getAddressFromLatLon(pdblLatitude: lat!, withLongitude: long!)
            print(location.coordinate)
            
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    // If we have been deined access give the user the option to change it
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    
    // Show the popup to the user if we have been deined access
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                message: "In order to deliver pizza we need your location",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    func buttonStatus(status: String, sender: MMSlidingButton) {
        
        var str : String = ""
        switch sender {
        case medicalEmergencyButton:
            str = medicalEmergencyButton.buttonLabel.text!
        case fireEmergencyButton:
            str = fireEmergencyButton.buttonLabel.text!
        case theftEmergencyButton:
            str = theftEmergencyButton.buttonLabel.text!
        case accidentEmergencyButton:
            str = accidentEmergencyButton.buttonLabel.text!
        case otherEmergencyButton:
            str = otherEmergencyButton.buttonLabel.text!
        default:
            break
        }
        
        CallSendSOS(str: str)
        
    }
    
    func popupShow(){
        let popUp = SOSPopUpViewController.init(nibName: "SOSPopUpViewController", bundle: nil)
        
        popUp.sOSPopUpClose = {() in
            self.medicalEmergencyButton.reset()
            self.fireEmergencyButton.reset()
            self.theftEmergencyButton.reset()
            self.accidentEmergencyButton.reset()
            self.otherEmergencyButton.reset()
        }
        MIBlurPopup.show(popUp, on: self)
    }
    
    func CallSendSOS(str : String){
        
        showLoader()

        let param : [String : Any] = [

            "id" : (residentData?.id)!,
            "addr" : address,
            "latitutde" : lat != nil ? String(lat!) : "" ,
            "longitude" : long != nil ? String(long!) : "",
            "subuser" : "",
            "status" : str

        ]

        PSServiceManager.CallSendSOS(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if status{

                self.popupShow()
                
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
