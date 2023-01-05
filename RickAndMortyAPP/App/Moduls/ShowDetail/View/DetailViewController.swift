//
//  DetailViewController.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 3/1/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - properties
    private lazy var contentSize = CGSize(width: view.frame.size.width, height: 900)
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.contentSize = contentSize
        scrollView.frame = self.view.bounds
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.bounces = true
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let aView = UIView()
        aView.backgroundColor = .white
        aView.frame.size = contentSize
        return aView
    }()
    
    var urlDetail: String? = ""
    var titleCharacter: String? = ""
    
    private lazy var viewModel : DetailViewModel = {
        let viewModel = DetailViewModel()
        viewModel.delegateDetail = self
        viewModel.delegateShowError = self
        viewModel.delegateSpinner = self
        return viewModel
    }()
    
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
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var speciesValue: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 1, alpha: 0.5)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
     
    private lazy var genderValue: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 1, alpha: 0.5)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var originTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Origin:"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var originValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var locationTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Location:"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var locationValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var residentsTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Residents:"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let aCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        aCollection.backgroundColor = .white
        aCollection.delegate = self
        aCollection.dataSource = self
        aCollection.register(ShowCollectionCell.self, forCellWithReuseIdentifier: ShowCollectionCell().identifier)
        aCollection.translatesAutoresizingMaskIntoConstraints = false
        return aCollection
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .medium
        spinner.color = .black
        spinner.isHidden = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        self.viewModel.getDetails(url: urlDetail)
    }
    
    // MARK: - setupView
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        [photoValue, nameValue, speciesValue, genderValue, originTitle, originValue, locationTitle, locationValue, residentsTitle, aCollectionView, spinner].forEach {
            containerView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoValue.topAnchor.constraint(equalTo: containerView.topAnchor),
            photoValue.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            photoValue.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            photoValue.heightAnchor.constraint(equalToConstant: 500),
            
            nameValue.leadingAnchor.constraint(equalTo: photoValue.leadingAnchor, constant: 10),
            nameValue.topAnchor.constraint(equalTo: photoValue.bottomAnchor, constant: -120),
            
            speciesValue.topAnchor.constraint(equalTo: nameValue.bottomAnchor, constant: 10),
            speciesValue.leadingAnchor.constraint(equalTo: photoValue.leadingAnchor, constant: 10),
            
            genderValue.topAnchor.constraint(equalTo: speciesValue.bottomAnchor, constant: 10),
            genderValue.leadingAnchor.constraint(equalTo: photoValue.leadingAnchor, constant: 10),
            
            originTitle.topAnchor.constraint(equalTo: photoValue.bottomAnchor, constant: 10),
            originTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            
            originValue.topAnchor.constraint(equalTo: originTitle.bottomAnchor, constant: 5),
            originValue.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            
            locationTitle.topAnchor.constraint(equalTo: originValue.bottomAnchor, constant: 10),
            locationTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            
            locationValue.topAnchor.constraint(equalTo: locationTitle.bottomAnchor, constant: 5),
            locationValue.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant:  10),
            
            residentsTitle.topAnchor.constraint(equalTo: locationValue.bottomAnchor, constant: 10),
            residentsTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant:  10),
            
            aCollectionView.topAnchor.constraint(equalTo: residentsTitle.bottomAnchor, constant: 5),
            aCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            aCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            aCollectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
            
            spinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}

// MARK: - DetailViewModelDelegate
extension DetailViewController: DetailViewModelDelegate {
    func hiddenProperty() {
        DispatchQueue.main.async {
            [self.photoValue, self.nameValue, self.speciesValue, self.genderValue, self.originTitle, self.originValue, self.locationTitle, self.locationValue, self.aCollectionView, self.residentsTitle].forEach {
                $0.isHidden = true
            }
        }
        
    }
    
    func showProperty() {
        DispatchQueue.main.async {
            [self.photoValue, self.nameValue, self.speciesValue, self.genderValue, self.originTitle, self.originValue, self.self.locationTitle, self.locationValue, self.self.aCollectionView,self.residentsTitle].forEach {
                $0.isHidden = false
            }
        }
        
    }
    
    func updateCollection() {
        DispatchQueue.main.async {
            self.aCollectionView.reloadData()
        }
    }
    
    func updateView(data: DetailCharacterModel) {
        DispatchQueue.main.async {
            guard let url = URL(string: data.image) else { return }
            self.photoValue.loadImage(at: url)
            self.nameValue.text = data.name
            self.speciesValue.text = data.species
            self.genderValue.text = data.gender
            self.originValue.text = data.origin.name
            self.locationValue.text = data.location.name
        }
    }
}

// MARK: - ShowAlert
extension DetailViewController: ShowAlert {
    func showAlertWithMessage(message: String) {
        let alert = UIAlertController(title: Constants.AlertTitle.title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension DetailViewController:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getResidentCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = aCollectionView.dequeueReusableCell(withReuseIdentifier: ShowCollectionCell().identifier, for: indexPath) as? ShowCollectionCell else { return UICollectionViewCell() }
        cell.configureCellForResidents(data: viewModel.showResidentsData(index: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: aCollectionView.frame.width/3, height: aCollectionView.frame.height/1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.urlDetail = viewModel.showResidentsData(index: indexPath.row).url
        present(vc, animated: true)
    }
}

// MARK: - SpinnersDelegate
extension DetailViewController: SpinnersDelegate {
    func startProcess() {
        DispatchQueue.main.async {
            self.spinner.startAnimating()
            self.spinner.isHidden = false
        }
    }
    
    func stopProcess() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        }
    }
}
