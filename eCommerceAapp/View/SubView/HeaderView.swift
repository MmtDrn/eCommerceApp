//
//  HeaderView.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 15.10.2022.
//

import UIKit

class HeaderView: UIView {
    
    private let images = ["header1","header2","header3"]
    
    private let collectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.backgroundColor = UIColor.systemGray6
        collectionview.showsHorizontalScrollIndicator = false
        collectionview.isPagingEnabled = true
        
        return collectionview
    }()
    
    private lazy var pageControl:UIPageControl = {
        let pagecontroll = UIPageControl()
        pagecontroll.translatesAutoresizingMaskIntoConstraints = false
        pagecontroll.currentPage = 0
        pagecontroll.numberOfPages = images.count
        pagecontroll.currentPageIndicatorTintColor = UIColor.systemRed
        pagecontroll.pageIndicatorTintColor = UIColor.black
        
        return pagecontroll
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension HeaderView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let image = images[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
        cell.configıreImage(named: image)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width, height: frame.size.height)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        let current = x / frame.width
        self.pageControl.currentPage = Int(current)
    }
}

extension HeaderView {
    
    private func configureView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubview(collectionView)
        addSubview(pageControl)
        
        collectionView.frame = bounds
        
        NSLayoutConstraint.activate([
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor),
            pageControl.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15)
        ])
    }
}
