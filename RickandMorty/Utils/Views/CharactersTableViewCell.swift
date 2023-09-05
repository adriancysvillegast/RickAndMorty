//
//  CharactersTableViewCell.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 5/9/23.
//

import UIKit
import SDWebImage

class CharactersTableViewCell: UITableViewCell {


    // MARK: - Properties
    static let identifier = "CharactersTableViewCell"
    private lazy var aImageCover: UIImageView = {
        let aImage = UIImageView()
        aImage.contentMode = .scaleAspectFit
        aImage.image = UIImage(named: "photo")
        return aImage
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(aImageCover)
        contentView.addSubview(name)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.frame.height-10
        aImageCover.frame = CGRect(x: 0, y: 0, width: imageSize, height: imageSize)
        name.frame = CGRect(x: aImageCover.frame.width+10, y: 10, width: contentView.frame.width-aImageCover.frame.width, height: contentView.frame.height/2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        aImageCover.image = nil
        name.text = nil
    }
    // MARK: - Methods
    
    func configure(with model: CharacterViewModelCell) {
        aImageCover.sd_setImage(with: model.artWork)
        name.text = model.name
    }
}
