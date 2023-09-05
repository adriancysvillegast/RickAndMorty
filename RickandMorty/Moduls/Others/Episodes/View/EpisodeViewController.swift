//
//  EpisodeViewController.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 3/9/23.
//

import UIKit

class EpisodeViewController: UIViewController {

    // MARK: - Properties
    private var episode: EpisodeViewModelCell
    
    private var characters: [CharacterViewModelCell] = []
    
    private lazy var viewModel: EpisodeViewModel = {
        let viewModel = EpisodeViewModel()
        return viewModel
    }()
    
    private lazy var aCollectionView: UICollectionView = {
        let aCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: {section, _ in
                return self.createSectionCollection(with: section)
            }))
        aCollectionView.register(TitleHeaderCollectionReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier)
        aCollectionView.register(EpisodeCoverCollectionViewCell.self,
                                 forCellWithReuseIdentifier: EpisodeCoverCollectionViewCell.identifier)
        aCollectionView.register(CharacterCollectionViewCell.self,
                                 forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
        aCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        aCollectionView.delegate = self
        aCollectionView.dataSource = self
        return aCollectionView
    }()
    
    
    // MARK: - init
    init(episode: EpisodeViewModelCell) {
        self.episode = episode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        fetch()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        aCollectionView.frame = view.bounds
    }
    // MARK: - setUpView
    
    private func setUpView() {
        view.backgroundColor = .black
        view.addSubview(aCollectionView)
    }
    
    // MARK: - Methods
    
    private func fetch() {
        viewModel.getCharacters(
            charactersString: episode.characters) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let model):
                        self?.characters = model
                    case .failure(let error):
                        self?.showAlert(message: error)
                    }
                    self?.aCollectionView.reloadData()
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
extension EpisodeViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return characters.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        switch section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: EpisodeCoverCollectionViewCell.identifier,
                for: indexPath) as? EpisodeCoverCollectionViewCell else {
                    return UICollectionViewCell()
                }
            
            cell.configure(with: episode)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as? CharacterCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: characters[indexPath.row])
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as UICollectionViewCell
            cell.backgroundColor = .yellow
            return cell
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: TitleHeaderCollectionReusableView.identifier,
            for: indexPath) as? TitleHeaderCollectionReusableView else {
            return UICollectionReusableView()
        }
        header.configure(with: "Characters")
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CharacterViewController(character: characters[indexPath.row])
        vc.title = characters[indexPath.row].name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    public func createSectionCollection(with section: Int) -> NSCollectionLayoutSection {
        switch section {
        case 0:
            //Cover
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(400)),
                subitem: item,
                count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            return section
            
        case 1:
            //residents
            
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
            section.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(60)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
            ]
            return section
        default:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(120)),
                subitem: item,
                count: 2)
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
}
