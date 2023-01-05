//
//  NextPageCollectionCell.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 4/1/23.
//

import UIKit

class NextPageCollectionCell: UICollectionViewCell {
    // MARK: - properties
    let identifier = "NextPageCollectionCell"

    private lazy var photoValue: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.tintColor = .gray
        view.image = UIImage(systemName: "plus")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - setupView
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(photoValue)
        
        NSLayoutConstraint.activate([
            photoValue.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            photoValue.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            photoValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            photoValue.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

