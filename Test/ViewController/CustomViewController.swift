//
//  CustomViewController.swift
//  Test
//
//  Created by Daniel on 04.11.21.
//

import Foundation
import UIKit

// MARK:- ViewController

class CustomViewController: UIViewController {

    static let storyboardID = "CustomViewController"
    static let vcStoryboard = UIStoryboard(name: "CustomViewController", bundle: nil)

    @IBOutlet weak var tableView: UITableView!
    
    private let dataController = DataController()
    private var posts = [Post]()
    
    // MARK: -

    static func newInstance() -> CustomViewController{
        let vc = vcStoryboard.instantiateViewController(withIdentifier: storyboardID)
        as? CustomViewController ?? CustomViewController()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        startObservation()
        fetchData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    deinit {
        print("CustomViewController deinit")
    }
    
    private func setupLayout() {
        PostCell.register(in: tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 10
        
        let refresher = UIRefreshControl()
        refresher.backgroundColor = .clear
        refresher.tintColor = .systemBlue
        refresher.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        tableView.refreshControl = refresher
    }
    
    private func startObservation() {
        dataController.posts.observe = { [weak self] response in
            DispatchQueue.main.async {
                self?.tableView.refreshControl?.endRefreshing()
            }
            
            switch response {
            case .success(let value):
                self?.posts = value
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failed(let error):
                print(error)
            }
        }
    }
    
    @objc private func fetchData() {
        dataController.getJSONData()
    }
}

// MARK: Extensions

extension CustomViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PostCell.dequeue(from: tableView, with: indexPath, post: posts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("SELECTED!!")
    }
}
