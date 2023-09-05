//
//  CharacterCollectionReusableView.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 1/9/23.
//

import UIKit
import SDWebImage

class CharacterCollectionReusableView: UICollectionReusableView {
    // MARK: - properties
    
    static let identifier = "CharacterCollectionReusableView"
    
    private lazy var aImageCover: UIImageView = {
        let aImage = UIImageView()
        aImage.contentMode = .scaleAspectFit
        return aImage
    }()
    
    private lazy var aView: UIView = {
        let aImage = UIView()
        aImage.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return aImage
    }()
    
    private lazy var species: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var status: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var genre: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(aImageCover)
        aImageCover.addSubview(aView)
        
        [species, status, genre].forEach {
            aView.addSubview($0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - SetupView
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        aImageCover.frame = CGRect(
            x: 0,
            y: 0,
            width: frame.width,
            height: frame.width
        )
        aView.frame = CGRect(x: 20, y: 300, width: (frame.width-40)/2, height: 100)
        species.frame = CGRect(x: 5, y: 5, width: frame.width, height: 20)
        status.frame = CGRect(x: 5, y: 30, width: frame.width, height: 20)
        genre.frame = CGRect(x: 5, y: 55, width: frame.width, height: 20)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    // MARK: - Methods
    
    func configure(with model: CharacterViewModelCell) {
        aImageCover.sd_setImage(with: model.artWork, placeholderImage: UIImage(named: "logo"))
        species.text = "Species: \(model.species)"
        status.text = "Status: \(model.status)"
        genre.text = "Genre: \(model.gender)"
    }
}
