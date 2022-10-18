//
//  CategorieVC.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 18.10.2022.
//

import UIKit

class CategoryVC: UIViewController {
    
    private var items:[Item] = []
    private let coreDataViewModel:CoreDataViewModel
    
    private let collectionview:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionview
    }()
    
    private var navigationBar:UINavigationBar = {
        let bar = UINavigationBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.isTranslucent = false
        
        return bar
    }()
    
    private let navigationItems: UINavigationItem = {
        let navigationItem = UINavigationItem(title: "eCommerceApp")
        return navigationItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionview.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            collectionview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    init(coreDataViewModel:CoreDataViewModel) {
        self.coreDataViewModel = coreDataViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = items[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        
        cell.configureViews(item: item)
        cell.index = indexPath.row
        cell.SearchCellProtocol = self
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/2)-10, height: view.frame.height/4)
    }
}

extension CategoryVC: SearchCellProtocol {
    
    private func configureViews(){
        
        navigationBar.tintColor = .label
        navigationItems.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .done, target: self, action: #selector(clicked))
        navigationBar.items = [navigationItems]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "eCommerce App"
        
        view.addSubview(collectionview)
        view.addSubview(navigationBar)
        
        view.backgroundColor = .systemBackground
        collectionview.dataSource = self
        collectionview.delegate = self
    }
    
    public func setItemsProduct(products:[Result]){
        
        for product in products {
            let item = Item(product: product)
            self.items.append(item)
        }
        self.collectionview.reloadData()
    }
    public func setItemsFood(foods:[Food]){
        
        for food in foods {
            let item = Item(food: food)
            self.items.append(item)
        }
        self.collectionview.reloadData()
    }
    @objc func clicked(){
        dismiss(animated: true)
    }
    func addBasket(index: Int) {
        let item = items[index]
        coreDataViewModel.coreDataServices.addItem(item: item)
    }
}
