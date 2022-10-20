//
//  CategoryCell.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 15.10.2022.
//

import UIKit

protocol CategoryCellProtocol:AnyObject {
    func toCategoryVC(category:CategoryModel)
}

class CategoryCell: UITableViewCell {
    
    public static let identifier = "CategoryCell"
    private var categories:[CategoryModel] = []
    
    weak var ChoiceCellProtocol:CategoryCellProtocol?
    
    
    private let collectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.isPagingEnabled = true
        collectionview.isScrollEnabled = false
        collectionview.register(CategoryCVCell.self, forCellWithReuseIdentifier: CategoryCVCell.identifier)
        return collectionview
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    private func configureView(){
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //"choice1","choice2","choice3","choice4"
        let choice1 = CategoryModel(imageName: "choice1", name: "Products", vc: CategoryVC(coreDataViewModel: CoreDataViewModel(coreDataServices: CoreDataServices())))
        let choice2 = CategoryModel(imageName: "choice2", name: "Foods", vc: CategoryVC(coreDataViewModel: CoreDataViewModel(coreDataServices: CoreDataServices())))
        let choice3 = CategoryModel(imageName: "choice3", name: "Coming soon..", vc: nil)
        let choice4 = CategoryModel(imageName: "choice4", name: "Coming soon..", vc: nil)
        categories.append(choice1)
        categories.append(choice2)
        categories.append(choice3)
        categories.append(choice4)
    }
}

extension CategoryCell:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let categorie = categories[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVCell.identifier, for: indexPath) as! CategoryCVCell
        cell.config(categorie: categorie)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categorie = categories[indexPath.row]
        self.ChoiceCellProtocol?.toCategoryVC(category: categorie)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width/4) - 25, height: (frame.height) - 20)
    }
}
