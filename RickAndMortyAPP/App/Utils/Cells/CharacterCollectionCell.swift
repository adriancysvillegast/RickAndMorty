//
//  NextPageCollectionCell.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 4/1/23.
//

import UIKit

class CharacterCollectionCell: UICollectionViewCell {
    // MARK: - properties
    let identifier = "CharacterCollectionCell"

    
    private lazy var aView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: Constants.backgroundColor.backgroudCell)
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var photoValue: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - setupView
    override init(frame: CGRect) {
        super.init(frame: frame)
        [aView].forEach {
            addSubview($0)
        }
        
        [photoValue, nameValue].forEach {
            aView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            
            aView.topAnchor.constraint(equalTo: topAnchor),
            aView.leadingAnchor.constraint(equalTo: leadingAnchor),
            aView.trailingAnchor.constraint(equalTo: trailingAnchor),
            aView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            photoValue.topAnchor.constraint(equalTo: aView.topAnchor, constant: 10),
            photoValue.leadingAnchor.constraint(equalTo: aView.leadingAnchor, constant: 10),
            photoValue.trailingAnchor.constraint(equalTo: aView.trailingAnchor, constant: -10),
            photoValue.bottomAnchor.constraint(equalTo: aView.bottomAnchor, constant: -50),
            
            nameValue.topAnchor.constraint(equalTo: photoValue.bottomAnchor, constant: 5),
            nameValue.leadingAnchor.constraint(equalTo: aView.leadingAnchor, constant: 5),
            nameValue.trailingAnchor.constraint(equalTo: aView.trailingAnchor, constant: -5),
            nameValue.bottomAnchor.constraint(equalTo: aView.bottomAnchor)
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
}

