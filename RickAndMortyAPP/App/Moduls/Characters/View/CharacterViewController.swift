//
//  ViewController.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 2/1/23.
//

import UIKit

class CharacterViewController: UIViewController {
    
    // MARK: - properties
    private lazy var viewModel: CharacterViewModel = {
        let viewModel = CharacterViewModel()
        viewModel.delegateHome = self
        viewModel.delegateShowError = self
        return viewModel
    }()
    
    private lazy var aCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let aCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        aCollection.showsVerticalScrollIndicator = true
        aCollection.register(ShowCollectionCell.self, forCellWithReuseIdentifier: ShowCollectionCell().identifier)
        aCollection.delegate = self
        aCollection.dataSource = self
        aCollection.translatesAutoresizingMaskIntoConstraints = false
        return aCollection
    }()
    
    // MARK: - lifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        viewModel.get()
    }
    
    // MARK: - setupView
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(aCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            aCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            aCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            aCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            aCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

extension CharacterViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characterCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = aCollectionView.dequeueReusableCell(withReuseIdentifier: ShowCollectionCell().identifier, for: indexPath) as? ShowCollectionCell else { return UICollectionViewCell() }
        cell.configureCellForCharacter(data: viewModel.characterData(index: indexPath.row))
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width/1, height: view.frame.height/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        vc.urlDetail = viewModel.characterData(index: indexPath.row).url
        vc.title = viewModel.characterData(index: indexPath.row).name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
// MARK: - HomeViewModelDelegate
extension CharacterViewController: HomeViewModelDelegate {    
    func updateView() {
        DispatchQueue.main.async {
            self.aCollectionView.reloadData()
        }
    }
}

// MARK: - ShowAlert
extension CharacterViewController: ShowAlert {
    func showAlertWithMessage(message: String) {
        let alert = UIAlertController(title: Constants.AlertTitle.title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
}

