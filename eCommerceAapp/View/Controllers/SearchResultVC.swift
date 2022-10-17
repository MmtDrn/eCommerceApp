//
//  SearchResultVC.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 17.10.2022.
//

import UIKit

class SearchResultVC: UIViewController {

    var items:[Item] = []
    
    let collectionview:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionview.frame = view.bounds
    }
}

extension SearchResultVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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

extension SearchResultVC {

    private func configureViews(){
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "eCommerce App"
        
        view.backgroundColor = .systemBackground
        collectionview.dataSource = self
        collectionview.delegate = self
        
        view.addSubview(collectionview)
    }
}
