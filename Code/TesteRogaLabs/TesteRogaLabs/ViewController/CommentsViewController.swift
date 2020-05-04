//
//  CommentsViewController.swift
//  TesteRogaLabs
//
//  Created by Fernanda de Lima on 04/05/20.
//  Copyright © 2020 Felima. All rights reserved.
//

import UIKit
import SwiftSpinner

class CommentsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!
    @IBAction func closeActionButton(_ sender: Any) {
        removeAnimate()
    }
    
    var titlePost = ""
    var postID = 0
    var comments: [Comment] = [] {
        didSet{
            DispatchQueue.main.async {
                self.commentsTableView.reloadData()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       showAnimate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titlePost
        SwiftSpinner.show("Carregando comentário")
        loadComments()
    }
    
    private func loadComments(){
        API.get([Comment].self, endpoint: .comments(postID), success: { (result) in
            self.comments = result
            SwiftSpinner.hide()
        }) { (error) in
            print(error.localizedDescription)
            SwiftSpinner.hide()
        }
    }
    
    private func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    private func removeAnimate(){
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished){
                self.view.removeFromSuperview()
            }
        });
    }
}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentIdentifier") as! CommentCell
        cell.setup(comments[indexPath.row])
        return cell
    }
}
