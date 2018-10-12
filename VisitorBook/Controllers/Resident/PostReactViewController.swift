//
//  PostReactViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 09/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit


typealias MessageCountOnSend = (String, Int) -> (Void)
class PostReactViewController: ResidentAllPageViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate  {
    
    var messageCountOnSend : MessageCountOnSend? = nil
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var writeMsgTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var sendView: UIView!
    @IBOutlet weak var sendMessageHeight: NSLayoutConstraint!
    
    var isLiked : Bool = false
    var blogDetail : BlogDetail? = nil
    var blogLikeData : BlogLikeData? = nil
    var blogCommentData : BlogCommentData? = nil
    var indexBlog : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        //        setBackBarButton(buttonType: .Defauld)
        //        setNavigationTitle(With: (FlatUser?.cmplid)!, type: .white)
        
        registerCell()
        
        setBackBarButton(buttonType: .Defauld)
        
        if isLiked{
            setNavigationTitle(With: "People who reacted", type: .white)
            sendView.isHidden = true
            sendMessageHeight.constant = 0
            CallAllBlogLikes()
        }else{
            setNavigationTitle(With: "People who commented", type: .white)
            sendView.isHidden = false
            sendMessageHeight.constant = 50
            writeMsgTextView.delegate = self
            writeMsgTextView.text = "Type a message"
            writeMsgTextView.textColor = UIColor.lightGray
            sendButton.isEnabled = false
            CallAllBlogComment()
        }
        
    }

    
    func registerCell(){
        tableView.register(UINib(nibName: "PostReactTableViewCell", bundle: nil), forCellReuseIdentifier: "PostReactTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (isLiked == true ? (blogLikeData != nil ? blogLikeData?.blogLikesUser.count : 0) : (blogCommentData != nil ? blogCommentData?.blogCommentDetails.count : 0)) ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostReactTableViewCell") as! PostReactTableViewCell
        
        if isLiked {
            cell.setData(data: (blogLikeData?.blogLikesUser[indexPath.row])!)
        }else{
            cell.setData(data: (blogCommentData?.blogCommentDetails[indexPath.row])!)
        }
        
        return cell
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if writeMsgTextView.text.count == 1 && text == "" {
            sendButton.isEnabled = false
        }else{
            sendButton.isEnabled = true
        }
        
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if writeMsgTextView.textColor == UIColor.lightGray {
            writeMsgTextView.text = ""
            writeMsgTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if writeMsgTextView.text == "" {
            writeMsgTextView.text = "Type a message"
            writeMsgTextView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func sendButton_press(_ sender: Any) {

        CallBlogComment()
    }
    
    func CallAllBlogLikes(){
        
        showLoader()
        
        let param : [String : Any] = [
            
            "id" : (blogDetail?.id)!
            
        ]
        PSServiceManager.CallAllBlogLikes(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if status{
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.blogLikeData = try? jsonDecoder.decode(BlogLikeData.self, from: jsonData!)
                
                
                self.tableView.reloadData()
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
        }
        
    }
    
    func CallAllBlogComment(){
        showLoader()
        
        let param : [String : Any] = [
            "id" : (blogDetail?.id)!
        ]
        
        PSServiceManager.CallAllBlogComment(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if status{
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.blogCommentData = try? jsonDecoder.decode(BlogCommentData.self, from: jsonData!)
                
                if self.messageCountOnSend != nil{
                    self.messageCountOnSend!((self.blogCommentData?.totalComment)!, self.indexBlog)
                }
                
                self.tableView.reloadData()
                
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
        }
        
    }
    
    func CallBlogComment(){
        showLoader()
        
        let param : [String : Any] = [
            "id" : (blogDetail?.id)!,
            "uid" : (residentData?.id)!,
            "comment" : (writeMsgTextView.text)!
        ]
        
        writeMsgTextView.text = ""
        view.endEditing(true)
        
        PSServiceManager.CallBlogComment(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if status{
                
                self.CallAllBlogComment()
                
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
