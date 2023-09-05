//
//  LocationViewController.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 3/9/23.
//

import UIKit

class LocationViewController: UIViewController {
    
    // MARK: - Properties
    private var location: LocationViewModelCell
    
    private var residents: [CharacterViewModelCell] = []
    
    private lazy var viewModel: LocationViewModel = {
        let viewModel = LocationViewModel()
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
        aCollectionView.register(LocationCoverCollectionViewCell.self,
                                 forCellWithReuseIdentifier: LocationCoverCollectionViewCell.identifier)
        aCollectionView.register(CharacterCollectionViewCell.self,
                                 forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
        aCollectionView.delegate = self
        aCollectionView.dataSource = self
        return aCollectionView
    }()
    
    // MARK: - Init
    init(location: LocationViewModelCell) {
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchResidents()
        setUpView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        aCollectionView.frame = view.bounds
    }
    
    // MARK: - setupView
    private func setUpView() {
        view.addSubview(aCollectionView)
    }
    
    // MARK: - Methods
    private func fetchResidents() {
        viewModel.getResident(
            residentsArray: location.residents) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let model):
                        self.residents = model
                        self.aCollectionView.reloadData()
                    case .failure(let error):
                        print(error)
                    }
                }
            }
    }
    
}


extension LocationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return residents.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCoverCollectionViewCell.identifier, for: indexPath) as? LocationCoverCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: location)
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterCollectionViewCell.identifier,
                for: indexPath) as? CharacterCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: residents[indexPath.row])
            return cell
    
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCoverCollectionViewCell.identifier, for: indexPath) as? LocationCoverCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: location)
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
        if residents.count == 0 {
            header.configure(with:"Don't have Residents")
        }else {
            header.configure(with:"Residents")
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = CharacterViewController(character: residents[indexPath.row])
        vc.title = residents[indexPath.row].name
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
