//
//  SearchVC.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 15.10.2022.
//

import UIKit

class SearchVC: UIViewController {
    
    private var items:[Item] = []
    private let viewModel:NetworkViewModel
    
    private let collectionview:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionview
    }()
    private let searchController:UISearchController = {
        
        let controller = UISearchController(searchResultsController: SearchResultVC())
        controller.searchBar.placeholder = "Write what you are looking for"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionview.frame = view.bounds
    }
    init(viewModel:NetworkViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.NetworkViewModelProtocol = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/2)-10, height: view.frame.height/4)
    }
}

extension SearchVC: NetworkViewModelProtocol, UISearchResultsUpdating {

    private func configureViews(){
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "eCommerce App"
        
        view.backgroundColor = .systemBackground
        collectionview.dataSource = self
        collectionview.delegate = self
        
        view.addSubview(collectionview)
        viewModel.fectData()
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    func updateFoods(foods: [Food]) {
        for food in foods {
            let item = Item(food: food)
            self.items.append(item)
        }
        self.collectionview.reloadData()
    }
    
    func updateProducts(products: [Result]) {
        for product in products {
            let item = Item(product: product)
            self.items.append(item)
        }
        self.collectionview.reloadData()
    }
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,!query.trimmingCharacters(in: .whitespaces).isEmpty,
        let resultController = searchController.searchResultsController as? SearchResultVC
        else { return }
        
        resultController.items.removeAll()
        resultController.items = self.items.filter({ items in
            items.title.lowercased().contains(query.lowercased())
        })
        resultController.collectionview.reloadData()
    }
}
