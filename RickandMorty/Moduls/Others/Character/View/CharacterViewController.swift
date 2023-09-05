//
//  CharacterViewController.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 3/9/23.
//

import UIKit

class CharacterViewController: UIViewController {
    
    // MARK: - Properties
    let character: CharacterViewModelCell
    private var episode: [EpisodeViewModelCell] = []
    
    private lazy var viewModel: CharacterViewModel = {
        let viewModel = CharacterViewModel()
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
        aCollectionView.register(EpisodeCollectionViewCell.self,
                                 forCellWithReuseIdentifier: EpisodeCollectionViewCell.identifier)
        aCollectionView.register(CharacterCoverCollectionViewCell.self,
                                 forCellWithReuseIdentifier: CharacterCoverCollectionViewCell.identifier)
        
        aCollectionView.delegate = self
        aCollectionView.dataSource = self
        return aCollectionView
    }()
    
    // MARK: - Init
    init(character: CharacterViewModelCell) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        aCollectionView.frame = view.bounds
        fetchDetails()
    }
    
    // MARK: - SetUpView
    private func setUpView() {
        view.backgroundColor = .systemBackground
        view.addSubview(aCollectionView)
    }
    
    private func fetchDetails() {
        viewModel.getEpisodes(character: character) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.episode = model
                    self.aCollectionView.reloadData()
                case .failure(let error):
                    self.showAlert(message: error)
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
extension CharacterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return episode.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        switch section{
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterCoverCollectionViewCell.identifier, for: indexPath) as? CharacterCoverCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: character)
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: EpisodeCollectionViewCell.identifier, for: indexPath) as? EpisodeCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: episode[indexPath.row])
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterCoverCollectionViewCell.identifier, for: indexPath) as? CharacterCoverCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: character)
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
        if episode.count == 0 {
            header.configure(with: "Does not appear in episodes")
        }else {
            header.configure(with: "Episodes")
        }
        
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = EpisodeViewController(episode: episode[indexPath.row])
        vc.title = episode[indexPath.row].name
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
            //episodes
            
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
