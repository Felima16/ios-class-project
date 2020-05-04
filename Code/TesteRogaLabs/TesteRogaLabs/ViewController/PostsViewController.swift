//
//  ViewController.swift
//  TesteRogaLabs
//
//  Created by Fernanda de Lima on 04/05/20.
//  Copyright © 2020 Felima. All rights reserved.
//

import UIKit
import SwiftSpinner

class PostsViewController: UIViewController {
    @IBOutlet weak var postTableView: UITableView!
    var posts: [Post] = [] {
        didSet{
            DispatchQueue.main.async {
                self.postTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftSpinner.show("Carregando posts")
        loadPosts()
    }
    
    private func loadPosts(){
        API.get([Post].self, endpoint: .posts, success: { (result) in
            self.posts = result
            SwiftSpinner.hide()
        }) { (error) in
            print(error.localizedDescription)
            SwiftSpinner.hide()
        }
    }
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postIdentifier") as! PostCell
        cell.setupCell(posts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
        popOverVC.titlePost = "O que a galera comentou sobre \n\(posts[indexPath.row].title)"
        popOverVC.postID = posts[indexPath.row].id
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview((popOverVC.view)!)
        popOverVC.didMove(toParent: self)
    }
}
