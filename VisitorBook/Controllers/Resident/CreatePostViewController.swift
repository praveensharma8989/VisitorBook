//
//  CreatePostViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 09/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos

class CreatePostViewController: ResidentAllPageViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextViewDelegate {
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var showSelectedImagesView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var SelectedPhotos : [PHAsset]? = nil
    var SelectedPhotosImages : [Data]? = nil
    var sIds : [String]? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        messageTextView.delegate = self
        messageTextView.text = "Type a message"
        messageTextView.textColor = UIColor.lightGray
        sendButton.isEnabled = false
        
        let cellSize = CGSize(width:((showSelectedImagesView.frame.width / 2) - 10) , height:((showSelectedImagesView.frame.width / 2)))
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize
        collectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    @IBAction func backButton_press(_ sender: Any) {
        
        PopBack()
        
    }
    
    @IBAction func selectImageButton_press(_ sender: Any) {
        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = 6
        
        if SelectedPhotos != nil{
            sIds = SelectedPhotos?.map({ (assets) -> String in
                return assets.localIdentifier
            })
        }
        
        if sIds != nil {
            let evenAssets = PHAsset.fetchAssets(withLocalIdentifiers: sIds!, options: nil)
            vc.defaultSelections = evenAssets
        }
        
        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                           
                                            print("Selected: \(asset)")
        }, deselect: { (asset: PHAsset) -> Void in
            
        }, cancel: { (assets: [PHAsset]) -> Void in
            print("Cancel: \(assets)")
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }, finish: { (assets: [PHAsset]) -> Void in
            
            self.SelectedPhotos = assets
            self.SelectedPhotosImages?.removeAll()
            if assets.count > 0{
                self.SelectedPhotosImages = [Data].init()
                for phasset in assets{
                    self.SelectedPhotosImages?.append(UIImagePNGRepresentation(self.getThumbnail(asset: phasset)!)!)
                }
            }
            
            
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
            
            print("Finish: \(assets)")
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SelectedPhotos != nil ? (SelectedPhotos?.count)! : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreatePostImageViewCollectionViewCell", for: indexPath) as! CreatePostImageViewCollectionViewCell
        
        cell.selectedImageView.image = getThumbnail(asset: SelectedPhotos![indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    func getThumbnail(asset: PHAsset) -> UIImage? {
        
        var thumbnail: UIImage?
        
        let manager = PHImageManager.default()
        
        let options = PHImageRequestOptions()
        
        options.version = .original
        options.isSynchronous = true
        
        manager.requestImageData(for: asset, options: options) { data, _, _, _ in
            
            if let data = data {
                thumbnail = UIImage(data: data)?.resized(toWidth: 500)
            }
        }
        
        return thumbnail
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if messageTextView.text.count == 1 && text == "" {
            sendButton.isEnabled = false
        }else{
            sendButton.isEnabled = true
        }
        
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if messageTextView.textColor == UIColor.lightGray {
            messageTextView.text = ""
            messageTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if messageTextView.text == "" {
            messageTextView.text = "Type a message"
            messageTextView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func sendButton_press(_ sender: Any) {
        
        CallCreateBlog()
        
    }
    
    
    func CallCreateBlog(){
        
        showLoader()
        
        let param : [String : Any] = [
            "uid": (residentData?.id)!,
            "message" : (messageTextView.text)!,
            
        ]
        
        PSServiceManager.CallCreateBlog(param: param, imageData: SelectedPhotosImages) { (response, status, error) -> (Void) in
            
            self.dismissLoader()
            
            if(status){
                
                self.showAlertMessage(titleStr: "Success", messageStr: response!["msg"] as! String)
                self.PopBack()
                
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
