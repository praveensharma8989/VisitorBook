//
//  EventPhotosViewController.swift
//  VisitorBook
//
//  Created by Praveen on 27/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import Viewer
import SDWebImage
private let reuseIdentifier = "EventPhotosCollectionViewCell"

class EventPhotosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ViewerControllerDataSource {
    
    
    
    
    
    var eventData : EventDatum?
    var eventImagesData : EventImageData?

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let cellSize = CGSize(width:collectionView.bounds.width / 3, height:collectionView.bounds.width / 3)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize
//        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
//        layout.minimumLineSpacing = 1.0
//        layout.minimumInteritemSpacing = 1.0
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        CallEventImagesApi()
        // Do any additional setup after loading the view.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventImagesData != nil ? (eventImagesData?.eventImages.count)! : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EventPhotosCollectionViewCell
        
        cell.eventPhoto.set_sdWebImage(With: (eventImagesData?.eventImages[indexPath.row].images)!, placeHolderImage: "userImage")
        
        // Configure the cell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewerController = ViewerController(initialIndexPath: indexPath, collectionView: collectionView)
        viewerController.dataSource = self
        present(viewerController, animated: false, completion: nil)
    }
    
    
    func CallEventImagesApi(){
        
        showLoader()
        
        let param : [String : Any] = ["id" : (eventData?.id)!
        ]
        
        PSServiceManager.CallEventsImages(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if status{
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                
                self.eventImagesData = try? jsonDecoder.decode(EventImageData.self, from: jsonData!)
                
                
                self.collectionView!.reloadData()
                
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
        }
        
    }
    
    func numberOfItemsInViewerController(_ viewerController: ViewerController) -> Int {
        return eventImagesData != nil ? (eventImagesData?.eventImages.count)! : 0
    }
    
    func viewerController(_ viewerController: ViewerController, viewableAt indexPath: IndexPath) -> Viewable {
        
//        Viewable
        let photo = Photo.init(id: (eventImagesData?.eventImages[indexPath.row].images ?? ""))
        
        return photo//(eventImagesData?.eventImages[indexPath.row].images)! as! Viewable
        
        
    }
    
    
    
//    func viewerController(_ viewerController: ViewerController, didChangeFocusTo indexPath: IndexPath) {
//        <#code#>
//    }
//
//    func viewerControllerDidDismiss(_ viewerController: ViewerController) {
//        <#code#>
//    }
//
//    func viewerController(_ viewerController: ViewerController, didFailDisplayingViewableAt indexPath: IndexPath, error: NSError) {
//        <#code#>
//    }
//
//    func viewerController(_ viewerController: ViewerController, didLongPressViewableAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class Photo: Viewable {
    var placeholder = UIImage()
    
    enum Size {
        case small
        case large
    }
    
    var type: ViewableType = .image
    var id: String
    var url: String?
    var assetID: String?
    
    init(id: String) {
        self.id = id
    }
    
    func media(_ completion: @escaping (_ image: UIImage?, _ error: NSError?) -> Void) {
        
        SDWebImageManager.shared().loadImage(with: URL(string: id), options: SDWebImageOptions.highPriority, progress: nil) { (image, data, error, type, completed, url) in
            if(error == nil)
            {
                completion(image,nil)
            }
            else{
                completion(nil,error! as NSError)
            }
        }
//        SDWebImageManager.shared().imageDownloader?.downloadImage(with: URL(string: id), options: SDWebImageDownloaderOptions.lowPriority, progress: nil, completed: { (image, data, error, completed) in
//            if(error == nil)
//            {
//                completion(image,nil)
//            }
//            else{
//                completion(nil,error! as NSError)
//            }
//        })
    }
    
    
}
