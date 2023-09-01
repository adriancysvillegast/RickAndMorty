//
//  BrowseViewController.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 29/8/23.
//

import UIKit

class BrowseViewController: UIViewController {
    
    // MARK: - Properties
    
    private var browserData: [BrowseSectionType] = []
    
    private var character: [CharacterResponse] = []
    
    private lazy var viewModel: BrowserViewModel = {
        let viewModel = BrowserViewModel()
        return viewModel
    }()
    
    private lazy var aCollectionView: UICollectionView = {
        let aCollection = UICollectionView(frame: .zero,
                                           collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { sections, _ in
            return BrowseViewController.createSectionLayout(with: sections)
        }))
        aCollection.backgroundColor = .systemBackground
        aCollection.delegate = self
        aCollection.dataSource = self
        aCollection.register(CharacterCollectionViewCell.self,
                             forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
        aCollection.register(LocationCollectionViewCell.self,
                             forCellWithReuseIdentifier: LocationCollectionViewCell.identifier)
        aCollection.register(EpisodeCollectionViewCell.self,
                             forCellWithReuseIdentifier: EpisodeCollectionViewCell.identifier)
        aCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return aCollection
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchCharacters()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        aCollectionView.frame = view.bounds
    }
    
    // MARK: - Methods
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(aCollectionView)
    }
    
    func fetchCharacters() {
        viewModel.fechData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
//                    print("MODEL: \(model)")
                    self?.browserData = model
                    self?.aCollectionView.reloadData()
                case .failure(let error):
                    self?.showAlert(message: error)
                }
            }
        }
    }
    
    
    private func showAlert(message: Error) {
        let alert = UIAlertController(title: "Error", message: message.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension BrowseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return browserData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let section = browserData[section]
        switch section {
        case .characters(let model):
            return model.count
        case .location(let model):
            return model.count
        case .episode(model: let model):
            return model.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = browserData[indexPath.section]
        switch section {
        case .characters(let characters):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as? CharacterCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: characters[indexPath.row])
            return cell
            
        case .location(let location):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LocationCollectionViewCell.identifier, for: indexPath) as? LocationCollectionViewCell else {
                return UICollectionViewCell()
            }
            let location = location[indexPath.row]
            cell.configure(with: location)
            return cell
            
        case .episode(let episodes):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: EpisodeCollectionViewCell.identifier, for: indexPath) as? EpisodeCollectionViewCell else {
                return UICollectionViewCell()
            }
            let episode = episodes[indexPath.row]
            cell.configure(with: episode)
            return cell
 
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let section = browserData[indexPath.section]
        switch section {
        case .characters(let model):
            let vc = CharacterViewController(character: model[indexPath.row])
            vc.title = model[indexPath.row].name
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .location(let location): break
            
        case .episode(let episode): break
            
        }
    }
    
    static func createSectionLayout(with section: Int) -> NSCollectionLayoutSection {
        
        switch section{
        case 0:
            //            CHARACTERS
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2)
            
            let groupVertical = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(400))
                ,subitem: item,
                count: 2
            )
            
            groupVertical.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(400)),
                subitem: groupVertical,
                count: 2)
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
            
        case 1:
            //            LOCATION
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.8),
                    heightDimension: .absolute(190)),
                subitem: item,
                count: 1)
            
            horizontalGroup.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            return section
            
        case 2:
            //            EPISODES
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupHorizontal = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(300))
                ,subitem: item,
                count: 1
            )
            let groupVertical = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.8),
                    heightDimension: .absolute(300)),
                subitem: groupHorizontal,
                count: 2)
            
            let section = NSCollectionLayoutSection(group: groupVertical)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
            
        default :
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2)
            
            let groupVertical = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(400))
                ,subitem: item,
                count: 2
            )
            
            groupVertical.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(400)),
                subitem: groupVertical,
                count: 2)
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        }
        
    }
}

