//
//  CharacterCollectionViewCell.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 31/8/23.
//

import UIKit
import SDWebImage

class CharacterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "CharacterCollectionViewCell"
    
    private lazy var aImageCover: UIImageView = {
        let aImage = UIImageView()
        aImage.contentMode = .scaleAspectFit
        return aImage
    }()
    
    private lazy var name: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 1
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var species: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 1
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.font = .systemFont(ofSize: 15, weight: .regular)
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
        aImageCover.frame = contentView.bounds
        name.frame = CGRect(x: 10, y: frame.height - 60 , width: contentView.frame.width-20, height: 25)
        species.frame = CGRect(x: 10, y: frame.height - 35 , width: contentView.frame.width-20, height: 20)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        aImageCover.image = nil
        name.text = nil
        species.text = nil
    }
    // MARK: - Methods
    func configure(with character: CharacterViewModelCell) {
        self.name.text = character.name
        self.species.text = character.species
        self.aImageCover.sd_setImage(with: character.artWork, placeholderImage: UIImage(systemName: "photo"))
    }
    
}
