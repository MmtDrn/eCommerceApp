//
//  SearchCell.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 15.10.2022.
//

import UIKit
import AlamofireImage

class SearchCell: UICollectionViewCell {
    
    static var identifier = "SearchCell"
    
    private let image:UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleAspectFit
        imageview.layer.cornerRadius = 20
        imageview.image = UIImage(named: "choice2")
        return imageview
    }()
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "hloe Love Story Edp 75 Ml KadÄ±n"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22)
        label.tintColor = UIColor.label
        return label
    }()
    private let priceLabel:UILabel = {
        let label = UILabel()
        label.text = "649.0 $"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20)
        label.tintColor = UIColor.systemOrange
        return label
    }()
    private var buyButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBackground
        button.setTitle("BUY", for: .normal)
        button.setTitleColor(UIColor.systemOrange, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemOrange.cgColor
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray2.cgColor
        contentView.layer.cornerRadius = 20
        
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(buyButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
    }
    
    public func configureViews(item:Item){
        guard let url = URL(string: item.imageURL) else { return }
        image.af.setImage(withURL: url)
        titleLabel.text = item.title
        priceLabel.text = item.price
    }
}
