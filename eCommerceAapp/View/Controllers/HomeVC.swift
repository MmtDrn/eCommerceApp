//
//  HomeVC.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 15.10.2022.
//

import UIKit

class HomeVC: UIViewController {
    
    private var headerView:HeaderView? = nil
    private let tableView:UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableview()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
}

extension HomeVC {
    
    private func configureTableview(){
        view.addSubview(tableView)
        headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.frame.height / 4))
        tableView.tableHeaderView = headerView
    }
}
