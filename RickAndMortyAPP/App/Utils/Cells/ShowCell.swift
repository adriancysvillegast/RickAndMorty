//
//  ShowCell.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 2/1/23.
//

import UIKit

class ShowCell: UITableViewCell {
    
    // MARK: - properties
    let identifier = "ShowCell"
    
    private lazy var aView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameValue: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 1, alpha: 0.5)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - setupView
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(aView)
        
        [ nameValue].forEach {
            aView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            nameValue.topAnchor.constraint(equalTo: aView.topAnchor, constant: 10),
            nameValue.leadingAnchor.constraint(equalTo: aView.leadingAnchor, constant: 10),
            nameValue.trailingAnchor.constraint(equalTo: aView.trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(data: String) {
        nameValue.text = data
    }
    
}
