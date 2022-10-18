//
//  CartCell.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 15.10.2022.
//

import UIKit
import AlamofireImage

class BasketCell: UITableViewCell {
    
    static let identifier = "BasketCell"
    
    private let image:UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleAspectFill
        imageview.layer.cornerRadius = 20
        imageview.image = UIImage(named: "choice2")
        return imageview
    }()
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "hloe Love Story Edp 75 Ml KadÄ±n"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20)
        label.tintColor = UIColor.label
        return label
    }()
    private let priceLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "649.0 $"
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        label.tintColor = UIColor.systemOrange
        return label
    }()
    private var plusButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = UIColor.orange
        
        return button
    }()
    private var countLabel:UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        label.backgroundColor = .systemGray6
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.text = "0"
        
        return label
    }()
    private var minusButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = UIColor.systemRed
        
        return button
    }()
    private var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.darkGray.cgColor
        stackView.layer.cornerRadius = 10
        
        
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(minusButton)
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(plusButton)
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            image.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
            
            stackView.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            stackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25),
            
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    public func configureViews(item:BasketItems) {
        guard let url = URL(string: item.imageURL ?? "") else { return }
        image.af.setImage(withURL: url)
        self.titleLabel.text = item.title
        self.priceLabel.text = item.price
    }
}
