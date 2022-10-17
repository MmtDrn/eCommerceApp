//
//  OpeningVC.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 14.10.2022.
//

import UIKit

class OnboardingVC: UIViewController {
    
    private let images = ["ecommerce1","ecommerce3"]
    
    private let collectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.backgroundColor = UIColor.systemGray6
        collectionview.isPagingEnabled = true
        
        return collectionview
    }()
    
    private let button:UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setTitle("Lets Begin", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        return button
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
    
    private let stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        configureStackview()
    }
}

//MARK: -FUNCS
extension OnboardingVC {
    
    private func configureView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        view.addSubview(stackView)
        stackView.addArrangedSubview(pageControl)
        stackView.addArrangedSubview(button)
        
    }
    
    private func configureStackview(){
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])
    }
    
    @objc private func buttonClicked(){
        let tabbarVC = TabbarController()
        tabbarVC.modalPresentationStyle = .fullScreen
        present(tabbarVC, animated: true)
    }
}

//MARK: -COLLECTIONVIEW
extension OnboardingVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
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
        return CGSize(width: view.frame.size.width, height: view.frame.size.height)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        let current = x / view.frame.width
        self.pageControl.currentPage = Int(current)
        
        if Int(current) == (images.count - 1) {
            self.button.isHidden = false
        }else{
            self.button.isHidden = true
        }
    }
}
