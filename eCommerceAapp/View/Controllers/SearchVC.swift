//
//  SearchVC.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 15.10.2022.
//

import UIKit

class SearchVC: UIViewController {
    
    private var products:[AllModel] = []
    
    private let collectionview:UICollectionView = {
        
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
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "eCommerce App"
        
        view.backgroundColor = .systemBackground
        collectionview.dataSource = self
        collectionview.delegate = self
        
        view.addSubview(collectionview)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionview.frame = view.bounds
    }
}

extension SearchVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/2)-10, height: view.frame.height/3)
    }
}
