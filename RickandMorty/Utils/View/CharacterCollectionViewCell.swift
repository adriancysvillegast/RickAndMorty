//
//  CharacterCollectionViewCell.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 31/8/23.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "CharacterCollectionViewCell"
    
    private lazy var aImageCover: UIImageView = {
        let aImage = UIImageView()
        aImage.contentMode = .scaleAspectFit
        return aImage
    }()
    
//    species
    private lazy var name: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        return label
    }()
    
    private lazy var species: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        return label
    }()
    
    // MARK: - setupView
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(aImageCover)
        contentView.addSubview(name)
        contentView.addSubview(species)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        aImageCover.frame = contentView.bounds
//        name.frame = CGRect(x: 0, y: 0, width: contentView.frame.width-20, height: contentView.frame.height-20)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        aImageCover.image = nil
        name.text = nil
        species.text = nil
    }
    // MARK: - Methods
    func configure(with character: CharacterResponse) {
        
    }
    
}
