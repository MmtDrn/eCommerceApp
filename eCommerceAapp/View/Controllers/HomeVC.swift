//
//  HomeVC.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 15.10.2022.
//

import UIKit

class HomeVC: UIViewController {
    
    private var headerView:HeaderView? = nil
    private var sections:[SectionType] = [.choice, .productSection, .foodsSection]
    private let viewModel:NetworkViewModel
    private var foods:[Food] = []
    private var products:[Result] = []
    
    private let tableView:UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.showsVerticalScrollIndicator = false
        tableview.sectionHeaderTopPadding = 1
        
        tableview.register(ChoiceCell.self, forCellReuseIdentifier: ChoiceCell.identifier)
        tableview.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
        tableview.register(FoodsCell.self, forCellReuseIdentifier: FoodsCell.identifier)
        
        return tableview
    }()
    
    init(viewModel:NetworkViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.NetworkViewModelProtocol = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension HomeVC:UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = sections[indexPath.section]
        switch section {
            
        case .choice:
            let cell = tableView.dequeueReusableCell(withIdentifier: ChoiceCell.identifier, for: indexPath) as! ChoiceCell
            return cell
        case .productSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
            cell.configProducts(products: products)
            cell.delegate = self
            return cell
        case .foodsSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: FoodsCell.identifier, for: indexPath) as! FoodsCell
            cell.setFoods(foods: self.foods)
            cell.delegate = self
            return cell
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sections[section]
        return section.title
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        switch section {
            
        case .choice:
            return view.frame.size.height/10
        case .productSection:
            return (view.frame.size.height/10) * 2.3
        case .foodsSection:
            return (view.frame.size.height/10) * 2.3
        }
    }
}

extension HomeVC: NetworkViewModelProtocol, ProductCellProtocol, FoodCellProtocol {
    
    private func configureViews(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "eCommerce App"
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.frame.height / 4))
        tableView.tableHeaderView = headerView
        viewModel.fectData()
    }
    func updateProducts(products: [Result]) {
        self.products = products
        self.tableView.reloadData()
    }
    func updateFoods(foods: [Food]) {
        self.foods = foods
        self.tableView.reloadData()
    }
    func toDetail(item: Item) {
        let detailVC = DetailVC()
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.setItem(item: item)
        present(detailVC, animated: true)
    }
}
