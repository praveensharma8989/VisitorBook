//
//  PostViewTableViewCell.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 08/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import Viewer

typealias CommentButtonClick = () -> (Void)
typealias LikeButtonClick = (BlogDetail, Int) -> (Void)
typealias LikeListButtonClick = () -> (Void)
typealias ThreeDotButtonClick = () -> (Void)

protocol CustomCollectionCellDelegate:class {
    
    func collectionView(collectioncell:postImagesCollectionViewCell?, didTappedInTableview TableCell:PostViewTableViewCell, indexPath : IndexPath, _ collectionView: UICollectionView)
    //other delegate methods that you can define to perform action in viewcontroller
}

class PostViewTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var commentButtonClick : CommentButtonClick? = nil
    var likeButtonClick : LikeButtonClick? = nil
    var likeListButtonClick : LikeListButtonClick? = nil
    var threeDotButtonClick : ThreeDotButtonClick? = nil
    
    weak var cellDelegate:CustomCollectionCellDelegate? //define delegate
    var viewerController: ViewerController?
    var selectedIndex : IndexPath?
    
    
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var threeDotButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentCountButton: UIButton!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeButtonImage: UIImageView!
    var blogDetail : BlogDetail? = nil
    var indexBlog : Int = 0
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        collectionView.delegate = self
        collectionView.delegate = self
        registerdCell()
        // Initialization code
    }

    func registerdCell(){
        
        self.collectionView.register(UINib.init(nibName: "postImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "postImagesCollectionViewCell")
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data : BlogDetail){
        self.collectionView.reloadData()
        userImageView.set_sdWebImage(With: data.photo!, placeHolderImage: "userIcon")
        userName.text = data.name
        dateTimeLabel.text = data.postTime
        addressLabel.text = data.flats
        if data.blogRemove == "1"{
            threeDotButton.isHidden = false
        }else{
            threeDotButton.isHidden = true
        }
        messageLabel.text = data.message
        
        if (data.totalLikes == "0" || data.totalLikes == "1") {
            likeCountLabel.text = data.totalLikes! + " Like"
        }else{
            likeCountLabel.text = data.totalLikes! + " Likes"
        }
        
        if (data.totalComment == "0" || data.totalComment == "1") {
            commentCountLabel.text = data.totalComment! + " Comment"
        }else{
            commentCountLabel.text = data.totalComment! + " Comments"
        }
        
        let isLike : Bool = data.currUserLike == "0" ? false : true
        
        likeButton.isSelected = isLike
        likeButtonImage.image = isLike ? #imageLiteral(resourceName: "likeSelected") : #imageLiteral(resourceName: "likeUnSelected")

        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  blogDetail != nil ? (blogDetail?.imagesPart != nil ? (blogDetail?.imagesPart?.count)! : 0) : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postImagesCollectionViewCell", for: indexPath) as! postImagesCollectionViewCell
        
        
        cell.postImageView.set_sdWebImage(With: (blogDetail?.imagesPart![indexPath.row].images)!, placeHolderImage: "userImage")
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? postImagesCollectionViewCell
        self.cellDelegate?.collectionView(collectioncell: cell, didTappedInTableview: self, indexPath : indexPath, collectionView)
        
    }
    
    @IBAction func threeDotButton_press(_ sender: Any) {
        if threeDotButtonClick != nil{
            threeDotButtonClick!()
        }
    }
    @IBAction func likeCountButton_press(_ sender: Any) {
        if likeListButtonClick != nil{
            likeListButtonClick!()
        }
    }
    @IBAction func commentButtonPress(_ sender: Any) {
        if commentButtonClick != nil{
            commentButtonClick!()
        }
    }
    @IBAction func likeButton_press(_ sender: Any) {
        if likeButtonClick != nil{
            likeButtonClick!(blogDetail!, indexBlog)
        }
    }
    
    
    
    
}
