//
//  PSValidator.swift
//  VisitorBook
//
//  Created by praveen on 13/09/17.
//  Copyright © 2017 praveen. All rights reserved.
//

import UIKit

class PSValidator: NSObject {
    
    static let CODE: Int = 10000
    
    class func code() -> Int {
        return CODE
    }
    
    class func message(forCode code: Int) -> String {
        var result: String
        
        switch (code) {
        case 0:
            result = "Success.";
            break;
        case 80:
            result = "Agree terms and condition. Please check.";
            break;
        case 90:
            result = "%@ is blank. Please select %@.";
            break;
            
        case 100:
            result = "Please provide an username.";
            break;
        case 101:
            result = "Username cannot contain spaces.";
            break;
        case 102:
            result = "Please enter username with valid characters.";
            break;
            
        case 200:
            result = "Password Required";
            break;
        case 201:
            result = "pin should be minimum 4 characters.";
            break;
        case 203:
            result = "Confirm pin is blank.";
            break;
        case 204:
            result = "pin mismatch. Please check.";
            break;
        case 205:
            result = "pin should be 6-16 alphanumeric characters.";
            break;
            
            
        case 300:
            result = "Please select Tower!";
            break;
        case 301:
            result = "Please select Floor!";
            break;
        case 302:
            result = "Please select Flat!";
            break;
        case 303:
            result = "Please select purpose!";
            break;
            
        case 400:
            result = "Email Required";
            break;
        case 401:
            result = "Email can not contain spaces. Please check.";
            break;
        case 402:
            result = "Invalid email";
            break;
            
        case 500:
            result = "Enter phone number.";
            break;
        case 501:
            result = "Enter a valid phone number.";
            break;
        case 502:
            result = "Mobile no. can not contain spaces. Please check.";
            break;
        case 503:
            result = "Invalid mobile no. Please check.";
            break;
        case 504:
            result = "Phone number should be 10 Digits."
            
        case 600:
            result = "Gender is blank. Please check.";
            break;
        case 700:
            result = "Age is blank. Please check.";
            break;
        case 800:
            result = "Country is blank. Please check.";
            break;
        case 801:
            result = "Location is blank. Please check.";
            break;
        case 802:
            result = "State is blank. Please check.";
            break;
        case 803:
            result = "Zip Code is blank. Please check.";
            break;
        case 900:
            result = "Username Required";
            break;
        case 901:
            result = "Invalid characters in name. Please check.";
            break;
        case 903:result = "Specify your gender.";
        break;
        case 904:
            result = "Last Name is blank. Please check.";
            break;
        case 905:
            result = "Address is blank. Please check.";
            break;
            
        case 920:result = "BBM Pin or email, one is required.";
        break;
        case CODE:
            result = "You need to fill either email or phone. Please check.";
            break;
            
        case 1000:
            result = "pin mismatch. Please check.";
            break;
            
        case 1020:
            result = "Please select profile image.";
            break;
            
        case 1100:
            result = "Please select vehicle year.";
            break;
        case 1101:
            result = "Please select cuisines.";
            break;
        case 1102:
            result = "Please enter certifications.";
            break;
        case 1103:
            result = "Please select School.";
            break;
            
        case 1200:
            result = "Please upload profile image.";
            break;
            
        case 1300:
            result = "Please enter credit card number.";
            break;
        case 1301:
            result = "Invalid credit card. Please check.";
            break;
        case 1302:
            result = "Please enter CVV number.";
            break;
        case 1303:
            result = "Please enter correct CVV number.";
            break;
        case 1304:
            result = "Please enter Expiry date.";
            break;
        case 1305:
            result = "Please enter correct Expiry date.";
            break;
        case 1310:
            result = "Your new and old pin should not match each other.";
            break;
        case 1400:
            result = "Please enter the OTP.";
            break;
        case 1401:
            result = "Your new and old pin should not match each other.";
            break;
        case 1403:
            result = "Your new and old pin should not match each other.";
            break;
        case 1405:
            result = "Please enter country code.";
            break;
        default:
            result = "Something seems wrong. Please check.";
            break;
        }

        return result
    }
    
    class func validateUsername(username: String?) -> Int {
        
        guard let name = username else {
            return 100
        }
        
        if name.count == 0 {
            return 100
        }
        
        if name.range(of:" ") != nil {
            return 101
        }
        let set = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789_.-").inverted
        if name.rangeOfCharacter(from: set) != nil {
            return 102
        }
        return 0
   }
    
    class func validatePassword(_ password: String?) -> Int {
        
        guard let pass = password else {
            return 200
        }

        
        if (pass.count == 0){
            return 200
        }
//        if pass.count < 4 {
//            return 201
//        }
        return 0
    }
    
    class func validateConfirmPassword(_ password: String?) -> Int {
        
        guard let pass = password else {
            return 203
        }
        if (pass.count == 0){
            return 203
        }
        if pass.count < 4 {
            return 204
        }
        return 0
    }
    
    class func isTowerSelected(str: String?) -> Int {
        
        guard let string = str else {
            return 300
        }
        if string.trimmingCharacters(in: CharacterSet.whitespaces).count == 0 {
            return 300
        }
        return 0
    }
    
    class func isFloorSelected(str: String?) -> Int {
        
        guard let string = str else {
            return 301
        }
        if string.trimmingCharacters(in: CharacterSet.whitespaces).count == 0 {
            return 301
        }
        return 0
    }
    
    class func isFlatSelected(str: String?) -> Int {
        
        guard let string = str else {
            return 302
        }
        if string.trimmingCharacters(in: CharacterSet.whitespaces).count == 0 {
            return 302
        }
        return 0
    }
    
    class func isPurposeSelected(str: String?) -> Int {
        
        guard let string = str else {
            return 303
        }
        if string.trimmingCharacters(in: CharacterSet.whitespaces).count == 0 {
            return 303
        }
        return 0
    }
    
    class func validateMobile(Mobile: String?) -> Int {
        
        guard let mobile = Mobile else {
            return 500
        }

        if mobile.count  == 0 {
            return 500
        }
        if mobile.count != 10 {
            return 501
        }
//        if mobile.range(of:" ") != nil  {
//            return 502
//        }
        return 0
    }
    
    class func validateMobileForUS(Mobile: String?) -> Int {
        
        guard let mobile = Mobile else {
            return 500
        }
        
        if mobile.count  == 0 {
            return 500
        }
        if mobile.range(of:" ") != nil  {
            return 502
        }
        if mobile.count < 10 {
            return 504
        }
        return 0
    }
    
    class func validateName(_ Name: String?) -> Int {
        guard let name = Name else {
            return 900
        }
        if name.count == 0 {
            return 900
        }
        return 0
    }
    class func validateCountercode(_ CountryCode: String?) -> Int {
        guard let countryCode = CountryCode else {
            return 1405
        }
        
        
        if countryCode.count == 0 {
            return 1405
        }
        return 0
    }
    
    class func validateImage(with Data: Data?) -> Int {
        guard let data = Data else {
            return 1020
        }

        if data.count == 0 {
            return 1020
        }
        return 0
    }
    
    class func validateFirstName(_ Name: String?) -> Int {
        
        guard let name = Name else {
            return 900
        }

        if name.count == 0 {
            return 900
        }
        return 0
    }
    
    class func validateLastName(_ Name: String?) -> Int {
        
        
        guard let name = Name else {
            return 904
        }
        
        if name.count == 0 {
            return 904
        }
        return 0

    }
    
    class func validateAddress(_ Name: String?) -> Int {
        
        guard let name = Name else {
            return 905
        }
        
        if name.count == 0 {
            return 905
        }
        return 0

    }
    
    class func validateTermsAndCondition(_ status: Bool) -> Int {
        if !status {
            return 80
        }
        return 0
    }

    
    class func validateEmail(Email: String?) -> Int {
        
        guard let email = Email else {
            return 400
        }
        if email.count == 0{
            return 400
        }
        if email.range(of: " ") != nil {
            return 401
        }
        if email.range(of: "@") == nil {
            return 402
        }
        let array: [String] = email.components(separatedBy: "@")
        
        if array.count <= 1
        {
            return 402
        }
        if array[1].range(of: ".") == nil {
            return 402
        }
        
       
        let ar: [String] = array[1].components(separatedBy: ".")
        
        if ar[0].count == 0 || ar[1].count == 0 {
            return 402
        }
        
//        if !(ar.last == "edu") {
//            return 402
//        }
        
        
        return 0
    }
    class func validateGender( Gender: String?) -> Int {
        guard let gender = Gender else {
            return 600
        }
        
        if gender.count  == 0 {
            return 600
        }
        return 0
    }
    
    class func validateAge(_Age: String?) -> Int {
        
        guard let age = _Age else {
            return 700
        }

        if age.count == 0 {
            return 700
        }
        return 0
    }
    
    class func validateCountry( Country: String?) -> Int {
        
        guard let country = Country else {
            return 800
        }
        

        if country.count == 0 {
            return 800
        }
        return 0
    }
    
    class func validateCity(_ City: String?) -> Int {
        guard let city = City else {
            return 801
        }
        
        if city.count == 0 {
            return 801
        }
        return 0
    }
    class func validateState(_ State: String?) -> Int {
        
        guard let state = State else {
            return 802
        }

        if state.count  == 0 {
            return 802
        }
        return 0
    }
    
    class func validateZipCode( Zip: String?) -> Int {
        guard let zip = Zip else {
            return 803
        }

        if zip.count  == 0 {
            return 803
        }
        return 0
    }
    class func validateOTP( Zip: String?) -> Int {
        guard let zip = Zip else {
            return 1400
        }
        
        if zip.count  == 0 {
            return 1400
        }
        return 0
    }
    
    class func matchPassword(_ Password1: String?, withConfirmed Password2: String?) -> Int {
        guard let password1 = Password1 else {
            return 1000
        }
        guard let password2 = Password2 else {
            return 1000
        }

        if password1 != password2 {
            return 1000
        }
        return 0
    }
    
      class func validateProfileImage(_ Key: String?) -> Int {
        guard let key = Key else {
            return 1200
        }
        if key.count == 0 {
            return 1200
        }
        return 0
    }
    
    class func validateSelectCuisine(_ cuisine : String?) -> Int {
        guard let cuisine = cuisine else {
            return 1101
        }
        if cuisine.count == 0 {
            return 1101
        }
        return 0
    }
    class func validateCertifications(_ cuisine : String?) -> Int {
        guard let cuisine = cuisine else {
            return 1102
        }
        if cuisine.count == 0 {
            return 1102
        }
        return 0
    }
    
//    class func validateCreditCardNumber(cardNo: String) -> Int {
//        if cardNo.count == 0 {
//            return 1300
//        }
//        let status: Bool = CreditCardValidator.isValidNumber(cardNo.replacingOccurrences(of: " ", with: ""))
//        if status {
//            return 0
//        }
//        return 1301
//    }
    
    class func validateCvvNumber(CardNo: String) -> Int {
        if CardNo.count == 0 {
            return 1302
        }
        if CardNo.count == 3 {
            return 0
        }
        return 1303
    }

    //Credit card validatio
    
    class func validateExpDate(_ cardNo: String) -> Int {
        if cardNo.count  == 0 {
            return 1304
        }
        if cardNo.count > 0 {
            return 0
        }
        return 1305
    }
    
    // MARK: - To check text field is empty
    class func isTextEmpty(str: String?) -> Int {
        
        guard let string = str else {
            return 90
        }
        if string.trimmingCharacters(in: CharacterSet.whitespaces).count == 0 {
            return 90
        }
        return 0
    }
    
    
    class func textIsValidEmailFormat(_ email: String) -> Int {
      //  let stricterFilter: Bool = true
        let stricterFilterString: String = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        
        //let laxString: String = ".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*"
        
        let emailRegex: String = stricterFilterString
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if !emailTest.evaluate(with: email) {
            return 402
        }
        return 0
    }
    
    class func textIsValidForDecimalPoint(withString value: String) -> Bool {
        //  let stricterFilter: Bool = true
        let stricterFilterString: String = "\\d{0,4}+([.]{1}+\\d{0,2})?"
        
        let emailRegex: String = stricterFilterString
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if !emailTest.evaluate(with: value) {
            return false
        }
        return true
    }


    class func removeWhiteSpace(in str: String) -> String {
        
        return str.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    // MARK: - Check Password is alphanumeric
    class func isAlphaNumericAndContainsAtLeastSixDigit(str: String) -> Bool {
        
        if (str.count > 5 && str.count < 17 && str.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil && str.rangeOfCharacter(from: CharacterSet.lowercaseLetters) != nil || str.rangeOfCharacter(from: CharacterSet.uppercaseLetters) != nil) {
            return true
        }
        return false
    }
    
   static let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    
    class func isAlphaBets(_ str: String) -> Bool {
        let cs = CharacterSet(charactersIn: PSValidator.ACCEPTABLE_CHARACTERS).inverted
        if (str.rangeOfCharacter(from: cs) == nil) {
            return true
        }
        return false
    }
    
    class func validatePhoneNumber(mobilenumber: String?) -> Bool {
        guard var mobileNumber = mobilenumber  else {
            return false
        }
        if mobileNumber.count  > 0 {
            mobileNumber = mobileNumber.replacingOccurrences(of: "(", with: "")
            mobileNumber = mobileNumber.replacingOccurrences(of: ")", with: "")
            mobileNumber = mobileNumber.replacingOccurrences(of: " ", with: "")
            mobileNumber = mobileNumber.replacingOccurrences(of: "-", with: "")
            mobileNumber = mobileNumber.replacingOccurrences(of: "+", with: "")
            var valid: Bool
            let alphaNums = CharacterSet.decimalDigits
            let inStringSet = CharacterSet(charactersIn: mobileNumber)
            valid = alphaNums.isSuperset(of: inStringSet)
            if mobileNumber.count == 10 {
                return valid ? true : false
            }
            else {
                return false
            }
        }
        else {
            return false
        }
   }
    class func getLength(_ mobileNumber: String?) -> Int {
       
        guard let mobilenumber = mobileNumber else{
            return 0
        }
        let filteredString = mobilenumber.replacingOccurrences(of: "[^0-9]", with:"", options: .regularExpression, range: nil).trimmingCharacters(in: CharacterSet.whitespaces)
        
        let length: Int = filteredString.count
        return length
    }
    class func formatNumber( mobilenumber: String?) -> String {
        
        guard let mobileNumber = mobilenumber else {
            return ""
        }
        let result = mobileNumber.replacingOccurrences(of: "[^0-9]", with:"", options:.regularExpression, range: nil).trimmingCharacters(in: CharacterSet.whitespaces)

        return result
    }
    
//    class func textField(_ textField: UITextField, changeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if (string == "*") || (string == "+") || (string == "#") || (string == ".") || (string == ",") || (string == ";") {
//            return false
//        }
//        let length: Int = MBValidator.getLength(textField.text)
//        if length == 10 {
//            if range.length == 0 {
//                return false
//            }
//        }
//        var newString: String = textField.text?.replacingCharacters(in: range, with: string)
//
//        let charactersToRemove = CharacterSet.alphanumerics.inverted
//
//        newString = (newString.components(separatedBy: charactersToRemove) as NSArray).componentsJoined(byString: "")
//
//        let expression: String = "^([0-9]+)?(\\.([0-9]{1,2})?)?$"
//        let regex = try? NSRegularExpression(pattern: expression, options: .caseInsensitive)
//        let numberOfMatches: Int? = regex?.numberOfMatches(in: newString, options: [], range: NSRange(location: 0, length: newString.length()))
//        if numberOfMatches == 0 {
//            return false
//        }
//        if length == 3 {
//            let num: String = MBValidator.formatNumber(textField.text)
//            textField.text = "(\(num))"
//            if range.length > 0 {
//                textField.text = "\(num as? NSString)?.substring(to: 3)"
//            }
//        }
//       else if length == 6 {
//            let num: String = MBValidator.formatNumber(textField.text)
//            //NSLog(@"%@",[num  substringToIndex:3]);
//            //NSLog(@"%@",[num substringFromIndex:3]);
//            textField.text = "(\(num as? NSString)?.substring(to: 3)) \(num as? NSString)?.substring(from: 3)-"
//            if range.length > 0 {
//                textField.text = "(\(num as? NSString)?.substring(to: 3)) \(num as? NSString)?.substring(from: 3)"
//            }
//        }
//        return true
//    }

}
