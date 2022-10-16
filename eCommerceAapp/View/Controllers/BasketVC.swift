//
//  CartVC.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 15.10.2022.
//

import UIKit

class BasketVC: UIViewController {
    
    private let tableView:UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(BasketCell.self, forCellReuseIdentifier: BasketCell.identifier)
        
        return tableview
    }()
    
    private let totalPriceView:UIView = {
        let view = TotalPriceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        constraintViews()
    }
}

extension BasketVC:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketCell.identifier, for: indexPath) as! BasketCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/5
    }
}

extension BasketVC {
    private func configureView(){
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Shopping Basket"
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(totalPriceView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func constraintViews(){
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.9),
            
            totalPriceView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            totalPriceView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            totalPriceView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            totalPriceView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1)
        ])
    }
}
