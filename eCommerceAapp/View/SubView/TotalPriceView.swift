//
//  TotalPriceView.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 16.10.2022.
//

import UIKit

class TotalPriceView: UIView {
    
    private let totalLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total"
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
        label.font = .boldSystemFont(ofSize: 20)
        label.tintColor = UIColor.systemOrange
        return label
    }()
    
    private var confirmButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemOrange
        button.setTitle("Confirm Basket", for: .normal)
        button.tintColor = UIColor.systemBackground
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    private var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(confirmButton)
        addSubview(stackView)
        stackView.addArrangedSubview(totalLabel)
        stackView.addArrangedSubview(priceLabel)
        
        confirmButton.addTarget(self, action: #selector(calculateTotalPrice), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            
            confirmButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            confirmButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            confirmButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            confirmButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    @objc func calculateTotalPrice(){
        print("clicked")
    }
}
