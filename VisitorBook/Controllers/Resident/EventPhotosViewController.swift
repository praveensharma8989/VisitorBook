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

class EventPhotosViewController: ResidentAllPageViewController, UICollectionViewDelegate, UICollectionViewDataSource, ViewerControllerDataSource, ViewerControllerDelegate, EventPhotoHeaderViewDelegate, EventPhotoFooterViewDelegate {
    
    var viewerController: ViewerController?
    
    var eventData : EventDatum?
    var eventImagesData : EventImageData?
    var selectedIndex : IndexPath?

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        setBackBarButton(buttonType: .Defauld)
        setNavigationTitle(With: "Event Photos", type: .white)
        let cellSize = CGSize(width: (collectionView.bounds.width / 3) - 10, height: collectionView.bounds.width / 3)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        CallEventImagesApi()
        
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
        self.viewerController = ViewerController(initialIndexPath: indexPath, collectionView: collectionView)
        self.viewerController!.dataSource = self
        self.viewerController!.delegate = self
        
        let headerView = EventPhotoHeaderView(headingLabel: (eventImagesData?.eventImages[indexPath.row].name)!)
        headerView.viewDelegate = self
        self.viewerController?.headerView = headerView
        
        let footerView = EventPhotoFooterView()
        
        footerView.viewDelegate = self
        
        self.viewerController?.footerView = footerView
        
        present(viewerController!, animated: false, completion: nil)
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
    
    func headerView(_ headerView: EventPhotoHeaderView, didPressClearButton button: UIButton) {
        self.viewerController?.dismiss(nil)
    }
    
    
    func footerView(_ footerView: EventPhotoFooterView, didPressShareButton button: UIButton) {
        let cell = self.collectionView?.cellForItem(at: selectedIndex!) as? EventPhotosCollectionViewCell
        
        let image = cell?.eventPhoto.image
        let imageShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    func viewerController(_ viewerController: ViewerController, didChangeFocusTo indexPath: IndexPath) {
    
        self.selectedIndex = indexPath
        let headerView = EventPhotoHeaderView(headingLabel: (eventImagesData?.eventImages[indexPath.row].name)!)
        headerView.viewDelegate = self
        self.viewerController!.changeHeaderView(headerViewNew: headerView)
        
        let footerView = EventPhotoFooterView()
        footerView.viewDelegate = self
        self.viewerController?.changeFooterView(footerViewNew: footerView)
        
    }

    func viewerControllerDidDismiss(_ viewerController: ViewerController) {
     
        
        
    }

    func viewerController(_ viewerController: ViewerController, didFailDisplayingViewableAt indexPath: IndexPath, error: NSError) {
        
    }

    func viewerController(_ viewerController: ViewerController, didLongPressViewableAt indexPath: IndexPath) {
        
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
