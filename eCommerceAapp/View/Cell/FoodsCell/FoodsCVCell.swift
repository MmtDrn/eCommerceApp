//
//  FoodsCVCell.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 16.10.2022.
//

import UIKit

class FoodsCVCell: UICollectionViewCell {
    
    static let identifier = "FoodsCVCell"
    
    private let imageView:UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleAspectFill
        imageview.layer.cornerRadius = 10
        imageview.image = UIImage(named: "header1")
        return imageview
    }()
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "hloe Love Story Edp 75 Ml KadÄ±n"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.tintColor = UIColor.label
        return label
    }()
    private let priceLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "649.0 $"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemOrange
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
