//
//  EventPhotosCollectionViewController.swift
//  VisitorBook
//
//  Created by Praveen on 26/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import Viewer

private let reuseIdentifier = "Cell"

class EventPhotosCollectionViewController: UICollectionViewController {

    var eventData : EventDatum?
    var eventImagesData : EventImageData?
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 90)
        
        CallEventImagesApi()
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return eventImagesData != nil ? (eventImagesData?.eventImages.count)! : 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        configureCell(cell: cell, forItemAtIndexPath: indexPath, data : (eventImagesData?.eventImages[indexPath.row])!)
        // Configure the cell
    
        return cell
    }

    func configureCell(cell: UICollectionViewCell, forItemAtIndexPath: IndexPath, data : EventImage) {
        cell.backgroundColor = UIColor.black
        //3
        let imgView = UIImageView(frame: CGRect(x:0, y:0, width:layout.itemSize.width, height: layout.itemSize.height))
        imgView.contentMode = .scaleAspectFit
        imgView.set_sdWebImage(With: data.images, placeHolderImage: "userImage")
        cell.addSubview(imgView)
        
    }
    
//    func collectionView(collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//        return UIEdgeInsetsMake(20, 10, 10, 10); //UIEdgeInsetsMake(topMargin, left, bottom, right);
//    }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return self.collectionViewLayout.collectionViewContentSize
//    }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) ->
//        CGFloat {
//            return (collectionView.bounds.width / 3)
//    }
    
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
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension EventPhotosCollectionViewController: ViewerControllerDataSource {
    func numberOfItemsInViewerController(_ viewerController: ViewerController) -> Int {
        return eventImagesData != nil ? (eventImagesData?.eventImages.count)! : 0
    }
    
    func viewerController(_ viewerController: ViewerController, viewableAt indexPath: IndexPath) -> Viewable {
        return eventImagesData?.eventImages[indexPath.row].images as! Viewable
    }
}
