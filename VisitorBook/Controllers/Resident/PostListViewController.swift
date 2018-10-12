//
//  PostListViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 08/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import Viewer
import ExpandingMenu

typealias CompletionCell = (BlogDetail) -> (Void)

class PostListViewController: ResidentAllPageViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var viewerController: ViewerController?
    
    var blogDetailData : BlogDetailData? = nil
    
    var blogDetailArray : [BlogDetail]? = nil
    
    var blogDetail : BlogDetail? = nil
    
    var selectedIndex : IndexPath?
    
    var collectionView: UICollectionView? = nil
    
    var collectioncell: postImagesCollectionViewCell?
    
    var postID : String = ""
    
    var limit : Int = 0
    
    var isApiCall : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        tableView.contentInset = .zero
        tableView.contentInsetAdjustmentBehavior = .never
        setBackBarButton(buttonType: .Defauld)
        setNavigationTitle(With: "User Post", type: .white)
        AddNewComplaintButton()
        registerCell()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        limit = 0
        CallAllBlogs()
    }
    
    func registerCell(){
        
        tableView.register(UINib(nibName: "PostViewTableViewCell", bundle: nil), forCellReuseIdentifier: "PostViewTableViewCell")
    }
    
    func AddNewComplaintButton(){
        
        let menuButtonSize: CGSize = CGSize(width: 64.0, height: 64.0)
        let menuButton = ExpandingMenuButton(frame: CGRect(origin: CGPoint.zero, size: menuButtonSize), centerImage: #imageLiteral(resourceName: "pluseMenuIcon"), centerHighlightedImage: #imageLiteral(resourceName: "pluseMenuIcon"))
        menuButton.center = CGPoint(x: self.view.bounds.width - 32.0, y: self.view.bounds.height - 72.0)
        view.addSubview(menuButton)
        
        let item1 = ExpandingMenuItem(size: menuButtonSize, title: "Create Post", image: #imageLiteral(resourceName: "CreateNewIcon"), highlightedImage: #imageLiteral(resourceName: "CreateNewIcon"), backgroundImage: #imageLiteral(resourceName: "CreateNewIcon"), backgroundHighlightedImage: #imageLiteral(resourceName: "CreateNewIcon")) { () -> Void in
            let CreatePostVC = self.storyboard?.instantiateViewController(withIdentifier: "CreatePostViewController") as! CreatePostViewController
            
            self.Push(controller: CreatePostVC)
        }
        
        
        menuButton.addMenuItems([item1])
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogDetailArray != nil ? (blogDetailArray!.count) : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostViewTableViewCell") as! PostViewTableViewCell
        
        let blogDetailNew = (blogDetailArray![indexPath.row])
        
        cell.blogDetail = blogDetailNew
        cell.collectionViewHeight.constant = blogDetailNew.imagesPart![0].id == "" ? 0 : 200
        cell.setData(data: blogDetailNew)
        cell.indexBlog = indexPath.row
        cell.cellDelegate = self
        
        cell.likeListButtonClick = {() in
            
            if blogDetailNew.totalLikes != "0"{
                let PostReactVC = self.storyboard?.instantiateViewController(withIdentifier: "PostReactViewController") as! PostReactViewController
                PostReactVC.isLiked = true
                PostReactVC.blogDetail = blogDetailNew
                self.Push(controller: PostReactVC)
            }
            
        }
        
        cell.likeButtonClick = {(blogData, indexBlog) in
            
            self.CallBlogLikes(blogData: blogData, indexBlog: indexBlog, completionBlockCell: { (blogDataNew) -> (Void) in
                cell.setData(data: blogDataNew)
            })
    
        }
        
        cell.commentButtonClick = {() in
            let PostReactVC = self.storyboard?.instantiateViewController(withIdentifier: "PostReactViewController") as! PostReactViewController
            PostReactVC.isLiked = false
            PostReactVC.blogDetail = blogDetailNew
            PostReactVC.indexBlog = indexPath.row
            PostReactVC.messageCountOnSend = {(messageCount, indexBlog) in
                
                self.blogDetailArray![indexBlog].totalComment = messageCount
                self.tableView.reloadData()
                
            }
                
            
            self.Push(controller: PostReactVC)
        }
        
        cell.threeDotButtonClick = {() in
            
            
            
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if isApiCall{
            if indexPath.row == (blogDetailArray!.count) - 2{
                CallAllBlogs()
            }
        }
    }
    
    
    func CallAllBlogs(){
        
        if limit == 0 {
            showLoader()
        }
        
        
        let param : [String : Any] = [
            "cid" : (residentData?.cid)!,
            "uid" : (residentData?.id)!,
            "limit" : limit
        ]
        
        PSServiceManager.CallAllBlogs(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            
            if(status){
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.blogDetailData = try? jsonDecoder.decode(BlogDetailData.self, from: jsonData!)
                
                if self.blogDetailArray == nil{
                    self.blogDetailArray = self.blogDetailData!.blogDetails
                }else{
                    self.blogDetailArray = self.blogDetailArray! + self.blogDetailData!.blogDetails
                }
                
                if (self.blogDetailData?.nums)! < 10 {
                    self.isApiCall = false
                    self.limit = self.limit + (self.blogDetailData?.nums)!
                }else{
                    self.limit = self.limit + (self.blogDetailData?.nums)!
                }
                self.tableView.reloadData()
                
            }else{
                
                if self.blogDetailArray != nil{
                    self.isApiCall = false
                }else{
                    self.showAlertMessage(titleStr: "Error", messageStr: error!)
                }
                
            }
            
        }
        
    }
    
    
    func CallBlogLikes(blogData : BlogDetail, indexBlog : Int, completionBlockCell:@escaping CompletionCell){
        showLoader()
        
        let param : [String : Any] = [
            "id" : blogData.id,
            "uid" : (residentData?.id)!
        ]
        
        PSServiceManager.CallBlogLikes(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            
            if(status){
                
                if response!["status"] as! Int == 0{
                    self.blogDetailData?.blogDetails[indexBlog].currUserLike = "0"
                    let totalCount : Int =  Int((self.blogDetailData?.blogDetails[indexBlog].totalLikes)!)!
                    self.blogDetailData?.blogDetails[indexBlog].totalLikes = String(totalCount - 1)
                    
                }else{
                    self.blogDetailData?.blogDetails[indexBlog].currUserLike = "1"
                    let totalCount : Int =  Int((self.blogDetailData?.blogDetails[indexBlog].totalLikes)!)!
                    self.blogDetailData?.blogDetails[indexBlog].totalLikes = String(totalCount + 1)
                }
                
                completionBlockCell((self.blogDetailData?.blogDetails[indexBlog])!)
                
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


extension PostListViewController:CustomCollectionCellDelegate, ViewerControllerDataSource, ViewerControllerDelegate, EventPhotoHeaderViewDelegate, EventPhotoFooterViewDelegate {
 
    func collectionView(collectioncell: postImagesCollectionViewCell?, didTappedInTableview TableCell: PostViewTableViewCell, indexPath: IndexPath, _ collectionView: UICollectionView) {
        if let _ = collectioncell, let selCategory = TableCell.blogDetail {
//            if let imageName = cell.postImageView {
                blogDetail = selCategory
                self.collectionView = collectionView
                self.viewerController = ViewerController(initialIndexPath: indexPath, collectionView: collectionView)
                self.viewerController!.dataSource = self
                self.viewerController!.delegate = self
                
                let headerView = EventPhotoHeaderView.init(headingLabel: "")
                headerView.viewDelegate = self
                self.viewerController?.headerView = headerView
            
                let footerView = EventPhotoFooterView()
                
                footerView.viewDelegate = self
                
                self.viewerController?.footerView = footerView
                
                present(viewerController!, animated: false, completion: nil)
                
            }
//        }
    }
    
    
    func numberOfItemsInViewerController(_ viewerController: ViewerController) -> Int {
        return blogDetail != nil ? (blogDetail?.imagesPart != nil ? blogDetail?.imagesPart?.count : 0)! : 0
    }
    
    func viewerController(_ viewerController: ViewerController, viewableAt indexPath: IndexPath) -> Viewable {
        
        
        //        Viewable
        let photo = Photo.init(id: ((blogDetail?.imagesPart![indexPath.row].images) ?? ""))
        
        return photo//(eventImagesData?.eventImages[indexPath.row].images)! as! Viewable
        
        
    }
    
    func headerView(_ headerView: EventPhotoHeaderView, didPressClearButton button: UIButton) {
        self.viewerController?.dismiss(nil)
    }
    
    
    func footerView(_ footerView: EventPhotoFooterView, didPressShareButton button: UIButton) {
    
        let imageView = UIImageView.init()
        imageView.set_sdWebImage(With: (blogDetail?.imagesPart![(viewerController?.currentIndexPath.row)!].images)!, placeHolderImage: "userIcon")
        
        let image = imageView.image
        let imageShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageShare , applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    func viewerController(_ viewerController: ViewerController, didChangeFocusTo indexPath: IndexPath) {
        
        self.selectedIndex = indexPath
        
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
    
}
