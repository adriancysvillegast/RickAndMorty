//
//  EpisodeCoverCollectionViewCell.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 4/9/23.
//

import UIKit
import SDWebImage

//let name, airDate, episode: String
//let characters: [String]?
class EpisodeCoverCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "EpisodeCoverCollectionViewCell"
    
    private lazy var aImageCover: UIImageView = {
        let aImage = UIImageView()
        aImage.contentMode = .scaleAspectFit
        aImage.image = UIImage(named: "episodes")
        return aImage
    }()
    
    private lazy var aView: UIView = {
        let aImage = UIView()
        aImage.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return aImage
    }()
    
    private lazy var episode: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var airDate: UILabel = {
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
        
        [episode, airDate].forEach {
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
        aView.frame = CGRect(x: 20, y: 300, width: (frame.width-40)/2, height: 85)
        episode.frame = CGRect(x: 5, y: 5, width: frame.width, height: 20)
        airDate.frame = CGRect(x: 5, y: 30, width: frame.width, height: 20)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        episode.text = nil
        airDate.text = nil
    }
    
    // MARK: - Methods
    
    func configure(with model: EpisodeViewModelCell) {
        episode.text = "Episode: \(model.episode)"
        airDate.text = "Air Date: \(model.airDate)"
    }
}
