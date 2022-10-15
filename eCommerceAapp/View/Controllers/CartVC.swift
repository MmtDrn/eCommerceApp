//
//  CartVC.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 15.10.2022.
//

import UIKit

class CartVC: UIViewController {
    
    private let tableView:UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(CartCell.self, forCellReuseIdentifier: CartCell.identifier)
        
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension CartVC:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.identifier, for: indexPath) as! CartCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/5
    }
}

extension CartVC {
    private func configureView(){
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Shopping Cart"
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
}
