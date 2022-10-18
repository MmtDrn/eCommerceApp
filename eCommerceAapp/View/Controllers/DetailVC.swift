//
//  DetailVC.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 16.10.2022.
//

import UIKit
import AlamofireImage

class DetailVC: UIViewController {
    
    private var item:Item?
    
    private let image:UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleAspectFill
        imageview.image = UIImage(named: "choice2")
        return imageview
    }()
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "hloe Love Story Edp 75 Ml KadÄ±n"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        label.tintColor = UIColor.label
        return label
    }()
    private let priceLabel:UILabel = {
        let label = UILabel()
        label.text = "649.0 $"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 25)
        label.tintColor = UIColor.systemOrange
        return label
    }()
    private var buyButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemOrange
        button.setTitle("BUY", for: .normal)
        button.setTitleColor(UIColor.systemBackground, for: .normal)
        button.layer.cornerRadius = 20
        
        return button
    }()
    private var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
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
        configureItems()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            image.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        ])
    }
}
extension DetailVC {
    
    private func configureViews(){
        
        navigationBar.tintColor = .label
        navigationItems.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .done, target: self, action: #selector(clicked))
        navigationBar.items = [navigationItems]
        
        view.backgroundColor = .systemBackground
        view.addSubview(navigationBar)
        view.addSubview(image)
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(buyButton)
        
        self.buyButton.addTarget(self, action: #selector(addBasket), for: .touchUpInside)
    }
    @objc func clicked(){
        dismiss(animated: true)
    }
    private func configureItems(){
        if let item = item {
            guard let url = URL(string: item.imageURL) else {return}
            self.image.af.setImage(withURL: url)
            self.titleLabel.text = item.title
            self.priceLabel.text = item.price
        }
    }
    public func setItem(item:Item){
        self.item = item
    }
    @objc private func addBasket(){
        guard let item = item else { return }
        CoreDataServices.shared.addItem(item: item)
        print("add succes")
    }
}
