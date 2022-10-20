//
//  CartVC.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 15.10.2022.
//

import UIKit

class BasketVC: UIViewController {
    
    private var items:[BasketItems] = []
    private let viewModel:CoreDataViewModel
    private var totolPrice = 0
    
    private let tableView:UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(BasketCell.self, forCellReuseIdentifier: BasketCell.identifier)
        
        return tableview
    }()
    private let totalPriceView:TotalPriceView = {
        let view = TotalPriceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6

        return view
    }()
    
    init(viewModel:CoreDataViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.CoreDataViewModelProtocol = self
        totalPriceView.ConfirmBasketProtocol = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        constraintViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchCoreData()
    }
}

extension BasketVC:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketCell.identifier, for: indexPath) as! BasketCell
        
        cell.item = item
        cell.BasketCellProtocol = self
        cell.index = indexPath.row
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/5
    }
}

extension BasketVC: CoreDataViewModelProtocol,BasketCellProtocol, ConfirmBasketProtocol {
    
    private func configureView(){
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Shopping Basket"
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(totalPriceView)
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .done, target: self, action: #selector(allDelete))
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
    @objc func allDelete(){
        
        let alert = UIAlertController(title: "Do you confirm that your basket will be deleted??", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { action in
            self.viewModel.coreDataServices.deleteAllItem(items: self.items)
            self.viewModel.fetchCoreData()
            DispatchQueue.main.async {
                self.totolPrice = 0
                self.totalPriceView.setTotalPrice(totalPrice: 0)
            }
        }))
        present(alert, animated: true)
    }
    func fetchCoreData(items: [BasketItems]) {
        self.items = items
        self.tableView.reloadData()
        var price = 0
        
        for item in self.items {
            guard let tmpPrice = item.price else { return }
            price = Int(tmpPrice)!*Int(item.count)
            
            if self.items.count == 1 {
                self.totolPrice = Int(price)
            }else{
                self.totolPrice += Int(price)
            } 
        }
        self.totalPriceView.setTotalPrice(totalPrice: totolPrice)
    }
    func plusButton(count: Int, index:Int) {
       
        let item = items[index]
        item.count = Int16(count)
        
        appDelegate.saveContext()
        viewModel.fetchCoreData()
        self.tableView.reloadData()
        
    }
    func confirmBasket() {
        
        let alet = UIAlertController(title: nil, message: "Your shopping cart has been confirmed.", preferredStyle: .alert)
        alet.addAction(UIAlertAction(title: "Okey", style: .default, handler: { action in
            self.viewModel.coreDataServices.deleteAllItem(items: self.items)
            self.viewModel.fetchCoreData()
            self.tableView.reloadData()
            self.totalPriceView.setTotalPrice(totalPrice: 0)
        }))
        present(alet, animated: true)
    }
    
}
