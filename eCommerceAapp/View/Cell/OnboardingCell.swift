//
//  OnboardingCell.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 14.10.2022.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCell"
    
    private let view:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
    
        return view
    }()
    
    private let image:UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleAspectFit
        imageview.image = UIImage(named: "ecommerce1")
        
        return imageview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews(){
                
        contentView.addSubview(view)
        view.addSubview(image)
        view.frame = bounds
        image.frame = view.bounds
    }
    
    public func configıreImage(named:String){
        image.image = UIImage(named: named)
    }
}
