//
//  ShowCollectionCell.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 3/1/23.
//

import UIKit

class ShowCollectionCell: UICollectionViewCell {
    // MARK: - properties
    let identifier = "ShowCollectionCell"

    private lazy var photoValue: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameValue: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 1, alpha: 0.5)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - setupView
    override init(frame: CGRect) {
        super.init(frame: frame)
        [photoValue, nameValue].forEach {
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            photoValue.topAnchor.constraint(equalTo: topAnchor),
            photoValue.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoValue.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoValue.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            nameValue.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameValue.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameValue.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configureCell
    func configureCellForCharacter(data: DetailCharacterModel) {
        guard let url = URL(string: data.image) else { return }
        nameValue.text = data.name
        photoValue.loadImage(at: url)
    }

    func configureCellForResidents(data: ResidentsData) {
        guard let image = data.dataImage else { return }
        nameValue.text = data.name
        photoValue.image = UIImage(data: image)
    }
}
