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
    
    private lazy var aView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: Constants.backgroundColor.backgroudCell)
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var aViewDetails: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var photoValue: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var statusTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Status:"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var speciesTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Species:"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var speciesValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
     
    private lazy var genderTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Gender:"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genderValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var originTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Origin:"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var originValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var locationTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Location:"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var locationValues: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var locationValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var residentsTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Residents of "
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
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
        
        [aView, aCollectionView, spinner].forEach {
            containerView.addSubview($0)
        }
        
        [photoValue, aViewDetails, residentsTitle, locationValue].forEach {
            aView.addSubview($0)
        }
        
        [statusTitle, statusValue, speciesTitle, speciesValue, genderTitle, genderValue, originTitle, originValue,locationTitle, locationValues].forEach {
            aViewDetails.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        
            aView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            aView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            aView.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            aView.heightAnchor.constraint(equalToConstant: 600),
            
            
            photoValue.topAnchor.constraint(equalTo: aView.topAnchor, constant: 10),
            photoValue.leadingAnchor.constraint(equalTo: aView.leadingAnchor, constant: 10),
            photoValue.trailingAnchor.constraint(equalTo: aView.trailingAnchor, constant: -10),
            photoValue.bottomAnchor.constraint(equalTo: aView.bottomAnchor, constant: -10),
            
            aViewDetails.topAnchor.constraint(equalTo: photoValue.topAnchor, constant: 375),
            aViewDetails.leadingAnchor.constraint(equalTo: photoValue.leadingAnchor, constant: 10),
            aViewDetails.trailingAnchor.constraint(equalTo: photoValue.trailingAnchor, constant: -10),
            aViewDetails.bottomAnchor.constraint(equalTo: photoValue.bottomAnchor, constant: -10),
            
            statusTitle.topAnchor.constraint(equalTo: aViewDetails.topAnchor, constant: 10),
            statusTitle.leadingAnchor.constraint(equalTo: aViewDetails.leadingAnchor, constant: 10),
            statusTitle.widthAnchor.constraint(equalToConstant: 90),
            
            statusValue.topAnchor.constraint(equalTo: statusTitle.topAnchor),
            statusValue.leadingAnchor.constraint(equalTo: statusTitle.trailingAnchor, constant: 5),
            statusValue.trailingAnchor.constraint(equalTo: aViewDetails.trailingAnchor, constant: -10),
            
            speciesTitle.topAnchor.constraint(equalTo: statusTitle.bottomAnchor, constant: 10),
            speciesTitle.leadingAnchor.constraint(equalTo: aViewDetails.leadingAnchor, constant: 10),
            speciesTitle.widthAnchor.constraint(equalToConstant: 90),
            
            speciesValue.topAnchor.constraint(equalTo: speciesTitle.topAnchor),
            speciesValue.leadingAnchor.constraint(equalTo: speciesTitle.trailingAnchor, constant: 5),
            speciesValue.trailingAnchor.constraint(equalTo: aViewDetails.trailingAnchor, constant: -10),
            
            genderTitle.topAnchor.constraint(equalTo: speciesTitle.bottomAnchor, constant: 10),
            genderTitle.leadingAnchor.constraint(equalTo: aViewDetails.leadingAnchor, constant: 10),
            genderTitle.widthAnchor.constraint(equalToConstant: 90),
            
            genderValue.topAnchor.constraint(equalTo: genderTitle.topAnchor),
            genderValue.leadingAnchor.constraint(equalTo: genderTitle.trailingAnchor, constant: 5),
            genderValue.trailingAnchor.constraint(equalTo: aViewDetails.trailingAnchor, constant: -10),
            
            originTitle.topAnchor.constraint(equalTo: genderTitle.bottomAnchor, constant: 10),
            originTitle.leadingAnchor.constraint(equalTo: aViewDetails.leadingAnchor, constant: 10),
            originTitle.widthAnchor.constraint(equalToConstant: 90),
            
            originValue.topAnchor.constraint(equalTo: originTitle.topAnchor),
            originValue.leadingAnchor.constraint(equalTo: originTitle.trailingAnchor, constant: 5),
            originValue.trailingAnchor.constraint(equalTo: aViewDetails.trailingAnchor, constant: -10),
            
            locationTitle.topAnchor.constraint(equalTo: originTitle.bottomAnchor, constant: 10),
            locationTitle.leadingAnchor.constraint(equalTo: aViewDetails.leadingAnchor, constant: 10),
            locationTitle.widthAnchor.constraint(equalToConstant: 90),
            
            locationValues.topAnchor.constraint(equalTo: locationTitle.topAnchor),
            locationValues.leadingAnchor.constraint(equalTo: locationTitle.trailingAnchor, constant: 5),
            locationValues.trailingAnchor.constraint(equalTo: aViewDetails.trailingAnchor, constant: -10),
            
            
            residentsTitle.topAnchor.constraint(equalTo: aView.bottomAnchor, constant: 10),
            residentsTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant:  10),

            locationValue.topAnchor.constraint(equalTo: residentsTitle.topAnchor),
            locationValue.leadingAnchor.constraint(equalTo: residentsTitle.trailingAnchor),
            locationValue.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),

            aCollectionView.topAnchor.constraint(equalTo: residentsTitle.bottomAnchor, constant: 10),
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
            [self.photoValue,self.statusTitle, self.statusValue, self.speciesTitle, self.speciesValue, self.genderTitle, self.genderValue, self.originTitle, self.originValue, self.locationValue, self.aCollectionView, self.residentsTitle, self.aViewDetails, self.aView, self.locationTitle, self.locationValues].forEach {
                $0.isHidden = true
            }
        }
        
    }
    
    func showProperty() {
        DispatchQueue.main.async {
            [self.photoValue,self.statusTitle, self.statusValue, self.speciesTitle, self.speciesValue, self.genderTitle, self.genderValue, self.originTitle, self.originValue, self.locationValue, self.aCollectionView, self.residentsTitle, self.aViewDetails, self.aView, self.locationTitle, self.locationValues].forEach {
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
            self.statusValue.text = data.status
            self.speciesValue.text = data.species
            self.genderValue.text = data.gender
            self.originValue.text = data.origin.name
            self.locationValue.text = data.location.name
            self.locationValues.text = data.location.name
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
        return CGSize(width: aCollectionView.frame.width/2.3, height: aCollectionView.frame.height/1)
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
