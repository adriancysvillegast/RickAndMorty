//
//  EpisodeCollectionViewCell.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 1/9/23.
//

import UIKit

class EpisodeCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "EpisodeCollectionViewCell"
    
    private lazy var aImageCover: UIImageView = {
        let aImage = UIImageView()
        aImage.contentMode = .scaleAspectFill
        aImage.image = UIImage(named: "episodes")
        return aImage
    }()
    
    private lazy var name: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 2
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var airDate: UILabel = {
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
        contentView.backgroundColor = .red
        contentView.addSubview(aImageCover)
        contentView.addSubview(name)
        contentView.addSubview(airDate)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        aImageCover.frame = contentView.bounds
        name.frame = CGRect(x: 10, y: frame.height - 70 , width: contentView.frame.width-20, height: 45)
        airDate.frame = CGRect(x: 10, y: frame.height - 25 , width: contentView.frame.width-20, height: 20)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        name.text = nil
        airDate.text = nil
    }
    // MARK: - Methods
    func configure(with episode: EpisodeViewModelCell) {
        self.name.text = episode.name
        self.airDate.text = episode.airDate
    }
}
