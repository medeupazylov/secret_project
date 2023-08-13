//
//  PhotoScrollView.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 12.08.2023.
//

import UIKit

class PhotoCarouselCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.frame = bounds
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil // Reset the image content
    }
}
