//
//  LocationCoverCollectionViewCell.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 3/9/23.
//

import UIKit

class LocationCoverCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "LocationCoverCollectionViewCell"
    
    private lazy var aImageCover: UIImageView = {
        let aImage = UIImageView()
        aImage.contentMode = .scaleAspectFill
        aImage.image = UIImage(named: "location-cover")
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
    
    private lazy var type: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 1
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private lazy var dimension: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 1
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    // MARK: - setupView
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        contentView.addSubview(aImageCover)
        contentView.addSubview(name)
        contentView.addSubview(type)
        contentView.addSubview(dimension)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        aImageCover.frame = contentView.bounds
        name.frame = CGRect(x: 10, y: frame.height - 85 , width: contentView.frame.width-20, height: 25)
        type.frame = CGRect(x: 10, y: frame.height - 55 , width: contentView.frame.width-20, height: 25)
        dimension.frame = CGRect(x: 10, y: frame.height - 30, width: contentView.frame.width-20, height: 25)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        name.text = nil
        type.text = nil
    }
    // MARK: - Methods
    func configure(with location: LocationViewModelCell) {
        self.name.text = "Name: \(location.name)"
        self.type.text = "Type: \(location.type)"
        if location.dimension == "unknown" {
            self.dimension.text = "Dimension: unknown"
        }else {
            self.dimension.text = location.dimension
        }
    }
}
