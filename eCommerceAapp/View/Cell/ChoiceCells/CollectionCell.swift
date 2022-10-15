//
//  PhotosCollectionViewCell.swift
//  AmazonTemplate
//
//  Created by mehmet duran on 12.10.2022.
//

import UIKit

class ChoiceCollectionCell: UICollectionViewCell {
    
    static var identifier = "ChoiceCollectionCell"
    
    private let imageView:UIImageView = {
        let imageview = UIImageView()
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = contentView.bounds
    }
    
    public func config(image:String){
        self.imageView.image = UIImage(named: image)
    }
}
