//
//  HomeViewController.swift
//  Makestagram
//
//  Created by Alexander Niehaus on 7/12/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher


class HomeViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        UserService.posts(for: User.current) { (posts) in
            self.posts = posts
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    
    func configureTableView() {
            // remove separators for empty cells
        tableView.tableFooterView = UIView()
            // remove separators from cells
        tableView.separatorStyle = .none
    }
    
    let timestampFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        return dateFormatter
    } ()
}

extension HomeViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.section]
            
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "PostHeaderCell") as! PostHeaderCell
                cell.usernameLabel.text = User.current.username
                
                return cell
                
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "PostImageCell") as! PostImageCell
                
                let imageURL = URL(string: post.imageURL)
                cell.postImageView.kf.setImage(with: imageURL)
                
                return cell
                
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "PostActionCell") as! PostActionCell
                cell.likeCountLabel.text = "\(post.likeCount) likes"
                cell.timeAgoLabel.text = timestampFormatter.string(from: post.creationDate)
                
                return cell
                
            default:
                fatalError("Error: unexpected indexPath.")
            }
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostImageCell", for: indexPath) as! PostImageCell
        let imageURL = URL(string: post.imageURL)
        cell.postImageView.kf.setImage(with: imageURL)
        
        return cell
    }
    
    func configureCell(_ cell: PostActionCell, with post: Post) {
        cell.timeAgoLabel.text = timestampFormatter.string(from: post.creationDate)
        cell.likeButton.isSelected = post.isLiked
        cell.likeCountLabel.text = "\(post.likeCount) likes"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return PostHeaderCell.height
            
        case 1:
            let post = posts[indexPath.section]
            return post.imageHeight
            
        case 2:
            return PostActionCell.height
            
        default:
            fatalError()
        }
    }
}

extension HomeViewController: PostActionCellDelegate {
    func didTapLikeButton(_ likeButton: UIButton, on cell: PostActionCell) {
        guard let indexPath = tableView.indexPath(for: cell)
            else { return }
        
        likeButton.isUserInteractionEnabled = false
        
        let post = posts[indexPath.section]
        
        LikeService.setIsLiked(!post.isLiked, for: post) { (success) in
            defer {
                likeButton.isUserInteractionEnabled = true
            }
            guard success else {return}
            
            post.likeCount += !post.isLiked ? 1 : -1
            post.isLiked = !post.isLiked
            
            guard let cell = self.tableView.cellForRow(at: indexPath) as?
            PostActionCell
                else {return}
            
            DispatchQueue.main.async {
                self.configureCell(cell, with: post)
            }
        }
    }
}




