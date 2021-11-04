//
//  PostCell.swift
//  Test
//
//  Created by Daniel on 04.11.21.
//

import Foundation
import UIKit

class PostCell : UITableViewCell {
    
    static let identifier = "PostCell"
    static let nib = UINib(nibName: "PostCell", bundle: nil)
    
    @IBOutlet weak var lblUserId: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    
    private var post : Post!
    
    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    static func register(in tableView: UITableView) {
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    static func dequeue(from tableView: UITableView, with indexPath: IndexPath, post: Post) -> PostCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? PostCell ?? PostCell()
        cell.post = post
        cell.setLayout()
        return cell
    }

    private func setLayout() {
        lblUserId.text = "UserId: \(post.userId)"
        lblTitle.text = post.title
        lblBody.text = post.body
    }
}
