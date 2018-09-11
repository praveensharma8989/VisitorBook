//
//  PendingVisitTableViewCell.swift
//  VisitorBook
//
//  Created by Praveen on 10/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

typealias ViewUserDetail = () -> (Void)
typealias TopButtonClick = () -> (Void)
typealias BottomButtonClick = () -> (Void)

class PendingVisitTableViewCell: UITableViewCell {
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    var viewUserDetail : ViewUserDetail? = nil
    var topButtonClick : TopButtonClick? = nil
    var bottomButtonClick : BottomButtonClick? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data : PendingVisit){
        UserImage.set_sdWebImage(With: data.photo!, placeHolderImage: "CameraImage")
        userName.text = data.name
        userPhone.text = data.mobile
        userEmail.text = data.email
    }
    
    @IBAction func userImagebutton_press(_ sender: Any) {
        if viewUserDetail != nil{
            viewUserDetail!()
        }
    }
    @IBAction func TopButtonClick(_ sender: Any) {
        if topButtonClick != nil{
            topButtonClick!()
        }
    }
    @IBAction func bottomButtonClick(_ sender: Any) {
        if bottomButtonClick != nil{
            bottomButtonClick!()
        }
    }
    
}
