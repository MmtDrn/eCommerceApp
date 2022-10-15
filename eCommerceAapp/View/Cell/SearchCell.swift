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
        imageview.contentMode = .scaleAspectFill
        imageview.layer.cornerRadius = 20
        imageview.image = UIImage(named: "choice2")
        return imageview
    }()
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "hloe Love Story Edp 75 Ml KadÄ±n"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.tintColor = UIColor.label
        return label
    }()
    private let priceLabel:UILabel = {
        let label = UILabel()
        label.text = "649.0 $"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        label.tintColor = UIColor.systemOrange
        return label
    }()
    private var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(image)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(priceLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            stackView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    public func configureViews(imageURL:String,title:String,price:String){
        guard let url = URL(string: imageURL) else { return }
        image.af.setImage(withURL: url)
        titleLabel.text = title
        priceLabel.text = price
    }
}
